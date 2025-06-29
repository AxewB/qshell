pragma ComponentBehavior

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Hyprland
import "root:."
import "root:/service"
import "root:/components"
import "root:/utils"

Rectangle {
    id: root

    property var workspaces: Hyprland.workspaces
    property var workspacesCount: 9
    property var focusedWorkspace: Hyprland.focusedWorkspace
    property var focusedWorkspaceData: null

    implicitWidth: rowlayout.implicitWidth
    implicitHeight: rowlayout.implicitHeight
    color: Colors.palette.m3surfaceContainer
    radius: Appearance.radius.small

    StyledRectangle {
        id: backgroundSlider
        color: Colors.palette.m3primary
        radius: Appearance.radius.small
        z: 0

        property var activeItem: null

        x: activeItem ? activeItem.x - (activeItem.activeWidth * 0.1) : 0
        y: activeItem ? activeItem.y : 0
        implicitWidth: activeItem ? activeItem.activeWidth * 1.2 : 0
        implicitHeight: activeItem ? activeItem.implicitHeight : 0

        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: backgroundSlider
                    scale: 0.8
                }
            }
        ]
    }


    Flow {
        id: rowlayout
        spacing: Appearance.padding.normal
        padding: Appearance.padding.normal
        leftPadding: Appearance.padding.huge
        rightPadding: Appearance.padding.huge

        Repeater {
            id: workspaceRepeater
            model: root.workspaces.values

            WorkspaceItem {}
        }
    }



    Behavior on color {
        ColorAnimation {
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }
    }

    Behavior on implicitHeight {
        Anim {}
    }

    Behavior on implicitWidth {
        Anim {}
    }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }
}
