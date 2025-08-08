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
import "root:/service"
import "root:/config"
import "root:/utils"
import "root:/components"
import "root:/modules/Bar"
import "./BorderDrawer"

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

            QtObject {
                id: clickThroughRegionBorders
                property int x: borders.thickness + frameLeft.implicitWidth
                property int y: borders.thickness + frameTop.implicitHeight
                property int width: window.width - borders.thickness * 2 - frameLeft.implicitWidth - frameRight.implicitWidth
                property int height: window.height - borders.thickness * 2 - frameBottom.implicitHeight - frameTop.implicitHeight
            }

            mask: Region {
                id: regionMask
                x: clickThroughRegionBorders.x
                y: clickThroughRegionBorders.y
                width: clickThroughRegionBorders.width
                height: clickThroughRegionBorders.height
                intersection: Intersection.Xor

                // regions: widgetBorders.instances
                regions: maskRegions.instances


            }

            Variants {
                id: maskRegions
                model: moduleArea.regions

                delegate: Region {
                    required property Region modelData

                    x: modelData.x
                    y: modelData.y
                    width: modelData.width
                    height: modelData.height
                    intersection: Intersection.Subtract
                }
            }

            ModuleArea {
                id: moduleArea
                workingArea: clickThroughRegionBorders
            }


            anchors {
                left: true
                right: true
                top: true
                bottom: true
            }

            Borders {
                id: borders
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
                topMargin: BorderConfig.thickness
                leftMargin: frameLeft.implicitWidth + BorderConfig.thickness + BorderConfig.panelsPadding
                rightMargin: frameRight.implicitWidth + BorderConfig.thickness + BorderConfig.panelsPadding
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                Bar {}
            }

            WrapperItem {
                id: frameBottom
                bottomMargin: BorderConfig.thickness
                leftMargin: frameLeft.implicitWidth + BorderConfig.thickness + BorderConfig.panelsPadding
                rightMargin: frameRight.implicitWidth + BorderConfig.thickness + BorderConfig.panelsPadding
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
            }
            WrapperItem {
                id: frameRight
                rightMargin: BorderConfig.thickness
                bottomMargin: frameBottom.implicitHeight + BorderConfig.thickness + BorderConfig.panelsPadding
                topMargin: frameTop.implicitHeight + BorderConfig.thickness + BorderConfig.panelsPadding
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
            }
            WrapperItem {
                id: frameLeft
                leftMargin: BorderConfig.thickness
                bottomMargin: frameBottom.implicitHeight + BorderConfig.thickness + BorderConfig.panelsPadding
                topMargin: frameTop.implicitHeight + BorderConfig.thickness + BorderConfig.panelsPadding
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
        }
    }
}
