pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
    id: root
    default property alias content: contentItem.data
    property bool active: true
    property alias region: contentRegion
    property alias margin: contentItem.margin

    x: contentItem.x
    y: contentItem.y
    implicitHeight: contentItem.height
    implicitWidth: contentItem.width

    // Rectangle {
    //     anchors.fill: root
    // }

    WrapperItem {
        id: contentItem
    }

    property point itemPosition: Qt.point(0, 0)

    Region {
        id: contentRegion
        x: root.active ? itemPosition.x : 0
        y: root.active ? itemPosition.y : 0
        height: root.active ? contentItem.height : 0
        width: root.active ? contentItem.width : 0
        intersection: Intersection.Subtract
    }

    function updatePosition() {
        if (contentItem.parent) {
            const pos = contentItem.mapToItem(null, 0, 0)
            root.itemPosition = pos
        } else {
            positionUpdateTimer.start()
        }
    }

    onXChanged: positionUpdateTimer.start()
    onYChanged: positionUpdateTimer.start()
    onWidthChanged: positionUpdateTimer.start()
    onHeightChanged: positionUpdateTimer.start()
    onParentChanged: positionUpdateTimer.start()

    Timer {
        id: positionUpdateTimer
        interval: 50
        repeat: false
        onTriggered: root.updatePosition()
    }
}
