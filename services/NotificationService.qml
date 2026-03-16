pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root

  property list<MinshNotification> notifList: []

  Connections {
    target: notificationServer
    function onNotification(notification) {
      notification.tracked = true;

      const newNotif = minshNotificationComponent.createObject(root, {
        notification: notification,
        notifId: notification.id,
        summary: notification.summary,
        body: notification.body,
        desktopEntry: notification.desktopEntry,
        appName: notification.appName,
        image: notification.image,
        actions: notification.actions,
        appIcon: notification.appIcon,

        timer: minshNotificationTimer.createObject(this, {})
      })

      root.notifList.push(newNotif)
    }
  }

  NotificationServer{
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

  Component {
    id: minshNotificationComponent
    MinshNotification {}
  }

  Component {
    id: minshNotificationTimer

    Timer {
      interval: 10000
      running: true
    }
  }

  component MinshNotification: QtObject {
    id: minshNotification
    property Notification notification
    property Connections notificationConnection: Connections {
      target: minshNotification.notification
      function onClosed() {
        minshNotification.expire()
      }
    }

    property int notifId
    property string appName
    property string summary
    property string body
    property string desktopEntry
    property string image
    property list<NotificationAction> actions
    property string appIcon

    property Timer timer
    property Connections timerConnection: Connections {
      target: minshNotification.timer
      function onTriggered() {
        minshNotification.expire()
      }
    }

    function dismiss(action) {
      root.dismissNotification(minshNotification, action)
    }

    function expire() {
      root.expireNotification(minshNotification)
    }
  }

  function dismissNotification(notif, action) {
    const index = root.notifList.indexOf(notif)

    if (index !== -1) {
        notifList.splice(index, 1)[0].destroy()
    }

    if (action) {
      action.invoke()
    } else {
      notif.notification.dismiss()
    }
  }


  function expireNotification(notif) {
    const index = root.notifList.indexOf(notif)

    if (index !== -1) {
        notifList.splice(index, 1)[0].destroy()
    }

    notif.notification.expire()
  }
}
