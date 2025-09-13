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
    property alias topItem: topArea
    property alias bottomItem: bottomArea
    property alias leftItem: leftArea
    property alias rightItem: rightArea

    property int padding: Config.appearance.padding.normal

    readonly property int possibleWidth: screen.width - (leftArea.implicitWidth + rightArea.implicitWidth)
    readonly property int possibleHeight: screen.height - (topArea.implicitHeight + bottomArea.implicitHeight)


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
            implicitWidth: root.possibleWidth
        }
        isVertical: true
    }

    BorderDrawer {
        id: bottomArea
        position: "bottom"
        screen: root.screen
        isVertical: true
    }


    BorderFilling {
        topItem: topArea
        bottomItem: bottomArea
        leftItem: leftArea
        rightItem: rightArea
    }
}
