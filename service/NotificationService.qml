pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root
    readonly property bool debug: false

    property list<Notif> notifs: []
    property alias notifsPopupsModel: notifsPopupsListModel
    property alias notifsModel: notifsListModel
    property var notifsJson: []

    ListModel { id: notifsPopupsListModel } // model for displaying popups
    ListModel { id: notifsListModel } // model for history

    NotificationServer {
        id: notificationServer
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: false
        
        bodyMarkupSupported: false
        bodySupported: true
        imageSupported: true
        keepOnReload: true
        persistenceSupported: false
        inlineReplySupported: true
    }

    component Notif: QtObject {
        property double time
        property Notification notification
        property Timer timer
        property bool popup: true

        // Notification props
        required property var id
        property var actions: {
            if (!notification || !notification.actions) return []
            const actionsList = []
            for (let i = 0; i < notification.actions.length; i++) {
                const action = notification.actions[i]
                actionsList.push({
                    "identifier": action.identifier,
                    "text": action.text,
                    "originalAction": action
                })
            }
            return actionsList
        }
        property string appIcon: notification?.appIcon ?? ""
        property string appName : notification?.appName ?? ""
        property string body : notification?.body ?? ""
        property string image : notification?.image ?? ""
        property string summary : notification?.summary ?? ""
        property string urgency : notification?.urgency.toString() ?? "normal"
        property bool hasInlineReply: notification?.hasInlineReply ?? false
        property string inlineReplyPlaceholder: notification?.inlineReplyPlaceholder ?? ""

        function closePopup() {
            popup = false
            root.removePopupNotif(id)
        }

        function dismissNotification() {
            popup = false
            notification.dismiss()
            root.removeNotif(id)
        }

        function toJson() {
            return {
                time: time,
                id: id,
                actions: actions,
                appIcon: appIcon,
                appName: appName,
                body: body,
                image: image,
                summary: summary,
                urgency: urgency,
                hasInlineReply: hasInlineReply,
                inlineReplyPlaceholder: inlineReplyPlaceholder,
                notification: notification,
            }
        }
    }

    function removePopupNotif(id) {
        for (var i = 0; i < notifsPopupsModel.count; i++) {
            if (notifsPopupsModel.get(i).id == id) {
                notifsPopupsModel.remove(i)
                break
            }
        }
    }

    function removeNotif(id) {
        for (var i = 0; i < notifsModel.count; i++) {
            if (notifsModel.get(i).id == id) {
                notifsModel.remove(i)
                break
            }
        }
        // also removing from popups if it exists there
        removePopupNotif(id)
    }

    // Popup timer
    Component {
        id: notificationTimer
        Timer {
            interval: 5000
            running: true
            repeat: false

            onTriggered: () => {
                parent.closePopup()
            }
        }
    }

    Component {
        id: notifComponent
        Notif {}
    }

    Connections {
        target: notificationServer

        function onNotification(notification) {
            notification.tracked = !debug
            const newNotif = notifComponent.createObject(root, {
                "id": notification.id,
                "time": Date.now(),
                "timer": null,
                "notification": notification
            })

            // adding popup timer
            const newNotifTimer = notificationTimer.createObject(newNotif)
            newNotif.timer = newNotifTimer

            root.addNotification(newNotif)
        }
    }

    function addNotification(newNotif) {
        const notifJson = newNotif.toJson()

        root.notifs = [...root.notifs, newNotif]
        root.notifsModel.append(notifJson)
        root.notifsPopupsModel.append(notifJson)
    }

    function removeNotificationFromModel(id, model) {
        for (var i = 0; i < model.count; i++) {
            const item = model.get(i)

            if (item.id == id) {
                model.remove(i)
                return
            }
        }
    }

    function closeNotificationPopup(id) {
        const notifToClose = notifs.find(n => n.id == id)
        removeNotificationFromModel(notifToClose.id, notifsPopupsModel)
    }

    function dismissNotification(id) {
        const notifToDismiss = notifs.find(n => n.id == id)
        notifToDismiss.notification.dismiss()

        notifs = notifs.filter(n => n != notifToDismiss)
    }

    function updateNotifListJson() {
        root.notifsJson = root.notifs.map(notif => notif.toJson())
    }

    onNotifsChanged: {
        root.updateNotifListJson()
    }
}
