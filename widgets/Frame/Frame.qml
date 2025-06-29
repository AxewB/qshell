import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Particles
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/config"
import "root:/utils"
import "root:/components"
import "root:/widgets/Bar"
import "./FrameDrawer"

Variants {
    model: Quickshell.screens

    Scope {
        id: scope
        property ShellScreen modelData

        PanelWindow {
            screen: modelData
            id: window

            color: "transparent"

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Bottom

            anchors {
                left: true
                right: true
                top: true
                bottom: true
            }

            Borders {
                id: borders;
                screen: modelData
                topContent: frameTop
                rightContent: frameRight
                bottomContent: frameBottom
                leftContent: frameLeft
            }

            MultiEffect {
                source: borders
                anchors.fill: borders
                shadowEnabled: true
                blurMax: 16
                shadowColor: Colors.palette.m3shadow
            }

            WrapperItem {
                id: frameTop
                margin: Appearance.padding.huge
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                Bar { id: bar }
            }
            FrameDrawer {
                id: frameBottom
                side: "bottom"
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
            }
            FrameDrawer {
                id: frameRight
                side: "right"
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
            }
            FrameDrawer {
                id: frameLeft
                side: "left"
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
            }
        }

        Exclusions {
            screen: modelData
            topContent: frameTop
            rightContent: frameRight
            bottomContent: frameBottom
            leftContent: frameLeft
            borders: borders
        }

    }
}
