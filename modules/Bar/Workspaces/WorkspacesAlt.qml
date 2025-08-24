pragma ComponentBehavior

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.config
import qs.service
import qs.components

Item {
    id: root

    property var workspaces: Hyprland.workspaces
    property list<int> activeWorkspacesId: workspaces.values.map(ws => ws.id)

    property var focusedWorkspace: Hyprland.focusedWorkspace
    property var focusedWorkspaceData: null
    property Item activeButton: null

    implicitWidth: rowlayout.implicitWidth
    implicitHeight: rowlayout.implicitHeight

    StyledRectangle {
        id: backgroundSlider
        color: Colors.palette.m3primary
        opacity: 0.5
        radius: height / 2

        property var activeItem: null

        x: activeItem ? activeItem.x : 0
        y: activeItem ? activeItem.y : 0
        Behavior on x { Anim {} }

        implicitWidth: (activeItem ? activeItem.implicitWidth : 0)
        implicitHeight: (activeItem ? activeItem.implicitHeight : 0)
        z: 10
    }

    Flow {
        id: rowlayout
        padding: Config.appearance.padding.normal
        spacing: 0

        Repeater {
            id: workspaceRepeater
            model: 8

            StyledButton {
                id: wsButton
                required property int modelData
                readonly property int wsId: modelData + 1
                readonly property bool focused: Hyprland.focusedWorkspace.id == wsId
                onFocusedChanged: if (focused) backgroundSlider.activeItem = this

                idleColor: root.activeWorkspacesId.includes(wsId) ? Colors.palette.m3primaryContainer : "transparent"
                // active: wsId === Hyprland.focusedWorkspace.id
                topRightRadius: root.activeWorkspacesId.includes(wsId + 1) ? 0 : 20
                bottomRightRadius:  root.activeWorkspacesId.includes(wsId + 1) ? 0 : 20
                topLeftRadius: root.activeWorkspacesId.includes(wsId - 1) ? 0 : 20
                bottomLeftRadius:  root.activeWorkspacesId.includes(wsId - 1) ? 0 : 20

                padding: 4
                implicitWidth: Config.appearance.icon.small
                implicitHeight: Config.appearance.icon.small

                onLeftClicked: Hyprland.dispatch(`workspace ${wsId}`)

                StyledText {
                    id: wrapperItemText
                    text: wsId

                    font.bold: parent.active ?? false
                    color: contentColor
                    z: 20
                }
            }

        }
    }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.easeOutQuad
    }
}
