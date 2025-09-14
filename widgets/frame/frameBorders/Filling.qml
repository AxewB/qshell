import QtQuick
import QtQuick.Effects
import qs.config
import qs.service
import "."

Item {
    id: root

    required property var workingArea

    anchors.fill: parent
    z: -1 // otherwise content is under filling

    Rectangle {
        id: fillRect
        anchors.fill: parent
        color: Colors.palette.m3surface
        visible: false
    }

    Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            x: root.workingArea.x
            y: root.workingArea.y
            height: root.workingArea.height
            width: root.workingArea.width
            radius: Config.borders.radius
        }
    }

    MultiEffect {
        source: fillRect
        maskSource: mask
        anchors.fill: root
        maskEnabled: true
        maskInverted: true
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1
    }
}
