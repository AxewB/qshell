import Quickshell
import QtQuick.Effects
import QtQuick
import Quickshell.Widgets
import Quickshell.Wayland
import qs.components
import qs.service
import qs.config
import "./FakeScreenRounding"
import "./FrameBorders"
import "./FrameModules"

Variants {
    model: Quickshell.screens
    Scope {
        required property ShellScreen modelData

        PanelWindow {
            id: window
            screen: modelData
            focusable: true
            color: "transparent"
            WlrLayershell.exclusionMode: ExclusionMode.Ignore

            anchors { left: true; right: true; top: true; bottom: true; }

            mask: Region {
                id: regionMask
                x: 1 + frameBorders.leftItem.implicitWidth
                y: 1 + frameBorders.topItem.implicitHeight
                width: window.screen.width - (1 + x + frameBorders.rightItem.implicitWidth)
                height: window.screen.height - (1 + y + frameBorders.bottomItem.implicitHeight)

                intersection: Intersection.Xor

                regions: modulesRegions.instances
            }

            Variants {
                id: modulesRegions
                model: frameModules.children

                delegate: Region {
                    required property Item modelData

                    x: modelData.itemX
                    y: modelData.itemY
                    width: modelData.itemWidth
                    height: modelData.itemHeight

                    intersection: Intersection.Subtract
                }
            }

            MultiEffect {
                source: shadowSource
                anchors.fill: shadowSource
                shadowEnabled: true
                blurMax: 32
                shadowColor: Colors.palette.m3shadow
            }


            Item {
                id: shadowSource
                anchors.fill: parent

                FrameBorders {
                    id: frameBorders
                    screen: window.screen
                }

                FrameModules {
                    id: frameModules
                    z: -1
                    workingArea: {
                        "x": frameBorders.leftItem.width,
                        "y": frameBorders.topItem.height,
                        "height": window.screen.height - frameBorders.topItem.height - frameBorders.bottomItem.height,
                        "width": window.screen.width - frameBorders.leftItem.width - frameBorders.rightItem.width
                    }
                }
            }

        }
    }
}
