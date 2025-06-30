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
    WrapperMouseArea {
        implicitHeight: 30
        implicitWidth: 50

        onClicked: {
            TogglesConfig.nightLight = !TogglesConfig.nightLight
        }

        Rectangle {
            anchors.fill: parent
            radius: 1000
            color: TogglesConfig.nightLight ? Colors.palette.m3primary : Colors.palette.m3surfaceContainer

            Text {
                text: "TOOL"
                color: TogglesConfig.nightLight ? Colors.palette.m3onPrimary : Colors.palette.m3onSurface
                anchors.centerIn: parent
            }
        }
    }
    Process {
        id: proc
        running: TogglesConfig.nightLight
        command: ["hyprsunset", "-t", "3000"]
    }
    Component.onCompleted: {
        console.log("PROC START")
        console.log(proc.running)
        console.log(proc.running)
        console.log(proc.running)
        console.log(proc.running)
        console.log("PROC END")
    }


    Component.onDestruction: {
        proc.running = false
    }
}
