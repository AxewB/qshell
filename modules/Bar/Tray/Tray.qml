
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import qs.config


Item {
    id: root

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Row {
        id: content
        spacing: Config.appearance.padding.normal

        add: Transition {
            NumberAnimation {
                properties: "scale"
                from: 0
                to: 1
                duration: Config.appearance.animation.durations.normal
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Config.appearance.animation.curves.ease
            }
        }

        Repeater {
            id: items
            model: SystemTray.items

            TrayItem {}
        }
    }
}
