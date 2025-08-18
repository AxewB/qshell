pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/config"
import "root:/utils"
import "root:/components"

Loader {
    id: root
    active: AppConfig.modules.borders
    required property WrapperItem topContent
    required property WrapperItem rightContent
    required property WrapperItem bottomContent
    required property WrapperItem leftContent
    property ShellScreen screen
    property int thickness: BorderConfig.thickness
    anchors.fill: parent

    sourceComponent: Item {
        id: content
        anchors.fill: parent

        Rectangle {
            id: borders
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
                anchors.topMargin: root.topContent.implicitHeight
                anchors.bottomMargin: root.bottomContent.implicitHeight
                anchors.leftMargin: root.leftContent.implicitWidth
                anchors.rightMargin: root.rightContent.implicitWidth
                radius: BorderConfig.radius
            }
        }


        MultiEffect {
            source: borders
            maskSource: mask
            anchors.fill: parent
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }
}
