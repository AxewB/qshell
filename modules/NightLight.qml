import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/config"
import "root:/utils"
import "root:/components"

WrapperItem {
    id: root
    readonly property bool active: TogglesConfig.nightLight


    WrapperMouseArea {
        anchors.fill: parent
        onClicked: root.toggleNightLight()

        WrapperRectangle {
            id: content
            radius: 1000
            margin: Appearance.padding.normal
            color: root.active ? Colors.palette.m3primary : Colors.palette.m3surfaceContainer

            Icon {
                icon: "night_sight_max"
            }
        }
    }

    function toggleNightLight() {
        TogglesConfig.nightLight = !TogglesConfig.nightLight
    }

    Process {
        id: proc
        running: root.active
        command: ["hyprsunset", "-t", "3000"]
    }
}
