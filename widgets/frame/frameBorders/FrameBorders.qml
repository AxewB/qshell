pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick
import Quickshell.Widgets
import Quickshell.Wayland
import qs.config
import qs.service
import qs.components
import qs.modules.bar


Item {
    id: root
    anchors.fill: parent
    required property ShellScreen screen

    readonly property WorkingArea workingArea: WorkingArea {
        x: leftArea.width
        y: topArea.height
        height: root.screen.height - topArea.height - bottomArea.height
        width: root.screen.width - leftArea.width - rightArea.width
    }

    readonly property int maxDrawerWidth: screen.width - (leftArea.implicitWidth + rightArea.implicitWidth)
    readonly property int maxDrawerHeight: screen.height - (topArea.implicitHeight + bottomArea.implicitHeight)


    BorderDrawer{
        id: leftArea
        position: "left"
        screen: root.screen
        topMargin: topArea.height
        bottomMargin: bottomArea.height
        isVertical: true
    }

    BorderDrawer{
        id: rightArea
        position: "right"
        screen: root.screen
        isVertical: true
    }

    BorderDrawer {
        id: topArea
        position: "top"
        screen: root.screen
        leftMargin: leftArea.implicitWidth / 2
        externalItem: Bar {
            implicitWidth: root.maxDrawerWidth
        }
        isVertical: true
    }

    BorderDrawer {
        id: bottomArea
        position: "bottom"
        screen: root.screen
        isVertical: true
    }


    Filling {
        workingArea: root.workingArea
    }

    component WorkingArea: QtObject {
        property int x: 0
        property int y: 0
        property int height: 0
        property int width: 0
    }
}
