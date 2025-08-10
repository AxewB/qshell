import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.components
import qs.service

Item {
    id: root
    readonly property var notifications: NotificationService.notifsPopupsModel
    property alias listHeight: list.implicitHeight
    property alias listWidth: list.implicitWidth

    implicitHeight: list.implicitHeight
    implicitWidth: list.implicitWidth

    ListView {
        id: list
        implicitHeight: contentHeight
        implicitWidth: 400
        model: root.notifications

        spacing: Appearance?.padding.huge ?? 0
        clip: false
        interactive: false
        keyNavigationEnabled: false
        boundsBehavior: Flickable.StopAtBounds

        add: Transition {
            NumberAnimation {
                property: "y"
                from: ViewTransition.item.ViewTransition.destination.y - ViewTransition.item.height
                to: ViewTransition.item.ViewTransition.destination.y

                duration: Appearance.animation.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.animation.curves.ease
            }
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1.0

                duration: Appearance.animation.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.animation.curves.ease
            }
        }


        remove: Transition {
            // NumberAnimation {
            //     property: "y"
            //     from: ViewTransition.item.ViewTransition.destination.y
            //     to: ViewTransition.item.ViewTransition.destination.y - ViewTransition.item.height

            //     duration: Appearance.animation.durations.normal
            //     easing.type: Easing.BezierSpline
            //     easing.bezierCurve: Appearance.animation.curves.ease
            // }
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0

                duration: Appearance.animation.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.animation.curves.ease
            }
        }



        // Анимация для сдвига оставшихся элементов
        displaced: Transition {
            NumberAnimation {
                properties: "x,y"

                duration: Appearance.animation.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Appearance.animation.curves.ease
            }
        }


        delegate: NotificationItem { }
    }
}
