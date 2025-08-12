import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.config
import qs.service

PanelWindow {
    id: root
    color: "transparent"

    Rectangle {
        color: Colors.palette.m3surface
        radius: 400
    }

    property ShellScreen modelData

    width: 300

    anchors.right: true
    anchors.top: true
    anchors.bottom: true
    exclusiveZone: 0

    WrapperItem {
        id: content
        margin: Appearance.padding.huge

        ColumnLayout {
            spacing: Appearance.padding.huge
            Layout.fillWidth: true
            Button {}
            Button {}
            Button {}
            Button {}
            Button {}
            Button {}
        }
    }
}
