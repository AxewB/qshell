import QtQuick
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.components
import qs.service
import qs.config

StyledButton {
    id: root
    required property HyprlandWorkspace modelData

    idleColor: modelData.active ? Colors.palette.m3primaryContainer : "transparent"
    active: modelData.id === Hyprland.focusedWorkspace.id
    radius: Appearance.radius.xsmall
    padding: 4
    implicitWidth: Appearance.icon.small
    implicitHeight: Appearance.icon.small

    onLeftClicked: {
        Hyprland.dispatch(`workspace ${modelData.id}`)
    }

    StyledText {
        id: wrapperItemText
        text: modelData.id

        font.bold: root.active
        color: root.contentColor
    }
}
