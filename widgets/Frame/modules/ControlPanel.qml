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
        margin: Config.appearance.padding.huge

        ColumnLayout {
            spacing: Config.appearance.padding.huge
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
