import QtQuick
import QtQuick.Effects
import qs.config
import qs.service

Item {
    id: root
    property Item topItem
    property Item bottomItem
    property Item leftItem
    property Item rightItem

    // readonly property alias
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
            anchors.fill: parent
            anchors.topMargin: root.topItem.implicitHeight
            anchors.bottomMargin: root.bottomItem.implicitHeight
            anchors.leftMargin: root.leftItem.implicitWidth
            anchors.rightMargin: root.rightItem.implicitWidth
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
