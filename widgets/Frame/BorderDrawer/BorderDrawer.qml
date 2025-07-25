import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"
import "root:/widgets/Bar"

WrapperItem {
    id: root
    required property string side // left right top bottom
    property bool isOpened: false

    WrapperMouseArea {
        hoverEnabled: true
        onEntered: () => root.isOpened = true
        onExited: () => root.isOpened = false

        Loader {
            id: drawerLoader
            active: true
            sourceComponent: {
                switch(root.side) {
                    case "top": return topDrawer;
                    case "right": return rightDrawer;
                    case "bottom": return bottomDrawer;
                    case "left": return leftDrawer;
                    default: return null;
                }
            }
        }
    }


    Component {
        id: rightDrawer
        BorderDrawerRight { isOpened: root.isOpened }
    }
    Component {
        id: bottomDrawer
        BorderDrawerBottom { isOpened: root.isOpened }
    }
    Component {
        id: leftDrawer
        BorderDrawerLeft { isOpened: root.isOpened }
    }
}
