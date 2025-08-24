pragma ComponentBehavior

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Hyprland
import Quickshell.Widgets
import "root:/service"
import "root:/components"
import "root:/utils"

// TODO: make LIST instead of repeater
Item {
    id: root

    property var workspaces: Hyprland.workspaces
    property var workspacesCount: 9
    property var focusedWorkspace: Hyprland.focusedWorkspace
    property var focusedWorkspaceData: null

    implicitWidth: rowlayout.implicitWidth
    implicitHeight: rowlayout.implicitHeight

    StyledRectangle {
        id: backgroundSlider
        color: Colors.palette.m3primary
        radius: Config.appearance.radius.small
        z: 0

        property var activeItem: null

        x: activeItem ? activeItem.x - (activeItem.activeWidth * 0.1) : 0
        y: activeItem ? activeItem.y : 0
        implicitWidth: activeItem ? activeItem.activeWidth * 1.2 : 0
        implicitHeight: activeItem ? activeItem.implicitHeight : 0
    }


    Flow {
        id: rowlayout
        padding: Config.appearance.padding.normal
        spacing: Config.appearance.padding.normal

        Repeater {
            id: workspaceRepeater
            model: root.workspaces.values

            WorkspaceItem {}
        }
    }

    Behavior on implicitHeight { Anim {} }
    Behavior on implicitWidth { Anim {} }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.ease
    }
}
