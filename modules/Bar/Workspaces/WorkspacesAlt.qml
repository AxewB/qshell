pragma ComponentBehavior

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import "root:/service"
import "root:/components"
import "root:/utils"

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

        implicitWidth: (activeItem ? activeItem.implicitWidth : 0)
        implicitHeight: (activeItem ? activeItem.implicitHeight : 0)
        z: 10
    }

    Flow {
        id: rowlayout
        padding: Appearance.padding.normal
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
                implicitWidth: Appearance.icon.small
                implicitHeight: Appearance.icon.small

                onLeftClicked: Hyprland.dispatch(`workspace ${wsId}`)

                StyledText {
                    anchors.centerIn: wsButton
                    id: wrapperItemText
                    text: wsId

                    font.bold: parent.active
                    color: contentColor
                    z: 20
                }
            }

        }
    }

    Behavior on implicitHeight { Anim {} }
    Behavior on implicitWidth { Anim {} }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }
}
