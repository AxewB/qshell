import QtQuick
import Quickshell

Rectangle {
    id: delayedHoverHandler
    property bool hovered: false
    required property string position
    property int inDelay: 150
    property int outDelay: 250
    opacity: 0.2
    z: 100

    HoverHandler {
        id: frameHoverHandler
        target: parent
        onHoveredChanged: {
            if (hovered) {
                delayTimerClose.running = false
                delayTimerOpen.running = true
            } else {
                delayTimerClose.running = true
                delayTimerOpen.running = false
            }
        }
    }

    Timer {
        id: delayTimerOpen
        interval: delayedHoverHandler.inDelay
        running: false
        onTriggered: {
            parent.hovered = true
        }
    }

    Timer {
        id: delayTimerClose
        interval: delayedHoverHandler.outDelay
        running: true
        onTriggered: {
            parent.hovered = true
            parent.hovered = false
        }
    }

    Component.onCompleted: {
        if (["left", "top", "bottom"].includes(position))
            root.anchors.left = root.parent.left
        if (["right", "top", "bottom"].includes(position))
            root.anchors.right = root.parent.right
        if (["top", "right", "left"].includes(position))
            root.anchors.top = root.parent.top
        if (["bottom", "right", "left"].includes(position))
            root.anchors.bottom = root.parent.bottom
    }
}
