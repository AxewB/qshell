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


            mask: Region {
                x: bar.implicitWidth
                y: Config.border.thickness
                width: win.width - bar.implicitWidth - Config.border.thickness
                height: win.height - Config.border.thickness * 2
                intersection: Intersection.Xor

                regions: regions.instances
            }

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
                shadowColor: Colors.palette.m3shadow
            }

            WrapperItem {
                id: frameTop
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                Bar { id: bar }
            }
            WrapperItem {
                id: frameRight
                anchors {
                    top: parent.top
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: frameBottom.implicitHeight + borders.thickness
                    topMargin: frameTop.implicitHeight + borders.thickness
                }
            }
            WrapperItem {
                id: frameBottom
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
            }
            WrapperItem {
                id: frameLeft
                anchors {
                    top: parent.top
                    left: parent.left
                    bottom: parent.bottom
                    bottomMargin: frameBottom.implicitHeight + borders.thickness
                    topMargin: frameTop.implicitHeight + borders.thickness
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
