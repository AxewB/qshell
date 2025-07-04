pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import "root:/service"
import "root:/utils"
import "root:/components"


Item {
    id: root
    property string time: "00:00 AM"
    property string format: "%H:%M"

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    RowLayout {
        id: content
        spacing: Appearance.padding.huge

        StyledText {
            color: Colors.palette.m3onSurface
            text: root.time
        }
    }


    Process {
        id: timeUpdateProc
        command: ['date', `+${root.format}`]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.time = this.text.trim()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeUpdateProc.running = true
    }
}
