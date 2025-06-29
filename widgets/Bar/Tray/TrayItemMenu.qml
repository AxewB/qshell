import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"

Rectangle {
    id: root
    property var menu

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    // implicitWidth: 100
    // implicitHeight: 100

    ColumnLayout {
        id: content

        QsMenuOpener {
            id: menuOpener
            menu: root.menu
        }

        Repeater {
            model: menuOpener.children

            Text {
                text: 'text'
            }
        }
    }

}
