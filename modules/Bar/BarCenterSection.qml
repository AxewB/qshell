import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"
import "./Workspaces"

Item {
    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth
    Layout.fillHeight: true

    RowLayout {
        id: content
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        height: parent.height

        BarModuleWrapper {
            implicitHeight: root.implicitHeight
            WorkspacesAlt {}
        }
    }
}
