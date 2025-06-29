pragma ComponentBehavior

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Hyprland
import "root:."
import "root:/config"
import "root:/components"
import "root:/utils"

StyledRectangle {
    id: workspace

    property int workspaceId: modelData.id
    property bool isActive: Hyprland.focusedWorkspace.id == workspaceId

    readonly property int inactiveWidth: wsText.implicitHeight * 1.2
    readonly property int activeWidth: wsText.implicitHeight * 1.2

    // implicitWidth: (wsText.implicitHeight + Appearance.padding.normal) * (isActive ? 2 : 1)
    implicitWidth: isActive ? activeWidth : inactiveWidth
    implicitHeight: wsText.implicitHeight + Appearance.padding.normal

    color: "transparent"

    onIsActiveChanged: {
        if (isActive) {
            backgroundSlider.activeItem = this
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onReleased: {
            backgroundSlider.state = ""
        }

        states:  [
            State {
                name: "pressed"
                when: mouseArea.containsPress

                PropertyChanges {
                    target: wsBackground
                    state: "pressed"
                    color: Colors.palette.m3primary
                }

                PropertyChanges {
                    target: wsText
                    color: Colors.palette.m3onPrimary
                }

                PropertyChanges {
                    target: backgroundSlider
                    state: if (workspace.isActive) return "pressed"
                }
            },

            State {
                name: "hovered"
                when: mouseArea.containsMouse

                PropertyChanges {
                    target: wsBackground
                    color: Colors.palette.m3primary
                }

                PropertyChanges {
                    target: wsText
                    color: Colors.palette.m3onPrimary
                }
            }
        ]

        onClicked: {
            Hyprland.dispatch(`workspace ${modelData.id}`)
        }
    }


    StyledRectangle {
        id: wsBackground
        radius: Appearance.radius.small
        anchors.fill: parent

        StyledText {
            id: wsText
            color: workspace.isActive ? Colors.palette.m3onPrimary : Colors.palette.m3onPrimaryContainer
            text: `${modelData.id}`
            anchors.centerIn: parent
            font.weight: 800
        }
    }
}
