import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/config"
import "root:/utils"
import "root:/components"
import "./Tray"

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    implicitHeight: content.implicitHeight

    RowLayout {
        id: content
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        height: parent.height
        layoutDirection: Qt.RightToLeft

        Time { }
        Tray { }
    }
}
