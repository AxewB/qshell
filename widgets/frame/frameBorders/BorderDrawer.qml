import Quickshell
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick
import Quickshell.Widgets
import Quickshell.Wayland
import qs.config
import qs.service

Item {
    id: root

    required property ShellScreen screen
    required property string position // "top" | "bottom" | "right" | "left"
    property bool isOpened: false
    property alias externalItem: externalWrapper.data
    property alias internalItem: internalWrapper.data
    property bool isVertical: false

    property int topMargin: 0
    property int bottomMargin: 0
    property int rightMargin: 0
    property int leftMargin: 0

    anchors {
        top: if(["top", "left", "right"].includes(position)) parent.top
        bottom: if(["bottom", "left", "right"].includes(position)) parent.bottom
        right: if(["bottom", "top", "right"].includes(position)) parent.right
        left: if(["bottom", "top", "left"].includes(position)) parent.left
    }

    onIsOpenedChanged: {
        isOpened ? opened() : closed()
    }

    implicitWidth: externalWrapperItem.width + isOpened * (internalWrapperItem.width + Config.borders.thickness)
    implicitHeight: externalWrapperItem.height + isOpened * (internalWrapperItem.height + Config.borders.thickness)

    Behavior on implicitHeight  {Anim {}}
    Behavior on implicitWidth  {Anim {}}

    clip: true


    PanelWindow {
        screen: root.screen
        color: "transparent"
        implicitWidth: externalWrapper.implicitWidth + Config.borders.panelsPadding
        implicitHeight: externalWrapper.implicitHeight + Config.borders.panelsPadding
        focusable: false
        aboveWindows: false
        anchors {
            top: ["top", "left", "right"].includes(position)
            bottom: ["bottom", "left", "right"].includes(position)
            right: ["bottom", "top", "right"].includes(position)
            left: ["bottom", "top", "left"].includes(position)
        }
    }
    PanelWindow {
        screen: root.screen
        color: "transparent"
        focusable: false
        aboveWindows: false
        implicitWidth: isOpened ? internalWrapper.implicitWidth : 0
        implicitHeight: isOpened ? internalWrapper.implicitHeight : 0

        anchors {
            top: ["top", "left", "right"].includes(position)
            bottom: ["bottom", "left", "right"].includes(position)
            right: ["bottom", "top", "right"].includes(position)
            left: ["bottom", "top", "left"].includes(position)
        }
    }

    signal opening()
    signal closing()

    signal opened()
    signal closed()

    onOpening: {
        closeTimer.stop()
        openTimer.restart()
    }
    onClosing: {
        openTimer.stop()
        closeTimer.restart()
    }

    onOpened: if (root.internalItem) root.isOpened = true
    onClosed: if (root.internalItem) root.isOpened = false

    // 1 px hover area to activate internal item
    MouseArea {
        id: testHandler
        enabled: !root.isOpened
        hoverEnabled: true

        height: ["left", "right"].includes(root.position) ? root.height : Config.borders.activationAreaWidth
        width:  ["top", "bottom"].includes(root.position) ? root.width : Config.borders.activationAreaWidth
        y: root.position == "bottom" ? externalWrapperItem.height - Config.borders.activationAreaWidth : 0
        x: root.position == "right" ? externalWrapperItem.width - Config.borders.activationAreaWidth : 0


        // Rectangle {
        //     anchors.fill: parent
        // }

        onContainsMouseChanged: containsMouse ? root.opening() : null
    }


    HoverHandler {
        enabled: true
        onHoveredChanged: !hovered ? root.closing() : null
    }

    Item {
        id: externalWrapperItem
        implicitWidth: externalWrapper.implicitWidth
        implicitHeight: externalWrapper.implicitHeight
        anchors.right: if (position === 'left') root.right
        anchors.bottom: if (position === "top") root.bottom

        WrapperItem {
            id: externalWrapper

            topMargin: root.topMargin
            bottomMargin: root.bottomMargin
            rightMargin: root.rightMargin
            leftMargin: root.leftMargin
            extraMargin: Config.borders.borderItemPadding
        }
    }

    Item {
        id: internalWrapperItem
        implicitHeight: internalWrapper.implicitHeight
        implicitWidth: internalWrapper.implicitWidth
        x: isOpened ? 0
            : position === "left" ? -implicitWidth * 2
            : position === "right" ? implicitWidth * 2
            : 0
        y: isOpened ? 0
            : position === "top" ? -implicitHeight * 2
            : position === "bottom" ? -implicitHeight * 2
            : 0
        Behavior on implicitWidth {Anim {}}
        Behavior on x {Anim {}}
        Behavior on y {Anim {}}
        Behavior on implicitHeight {Anim {}}
        anchors.right: if (position === 'right') root.right
        anchors.bottom: if (position === "bottom") root.bottom
        clip: true

        WrapperItem {
            id: internalWrapper;
            opacity: isOpened
            Behavior on opacity {Anim {}}

            topMargin: root.topMargin
            bottomMargin: root.bottomMargin
            rightMargin: root.rightMargin
            leftMargin: root.leftMargin
        }
    }

    Timer {
        id: openTimer
        interval: Config.borders.openTimerInterval
        onTriggered: root.opened()
    }

    Timer {
        id: closeTimer
        interval: Config.borders.closeTimerInterval
        onTriggered: root.closed()
    }

    component Anim: NumberAnimation { duration: 250 }
}
