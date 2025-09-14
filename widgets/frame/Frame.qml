import Quickshell
import QtQuick.Effects
import QtQuick
import Quickshell.Widgets
import Quickshell.Wayland
import qs.components
import qs.service
import qs.config
// import qs.widgets.frame.frameBorders as Borders
// import qs.widgets.frame.frameModules as Modules
import "frameBorders" as Borders
import "frameModules" as Modules

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
                x: 1 + frameBorders.workingArea.x
                y: 1 + frameBorders.workingArea.y
                width: 1 + frameBorders.workingArea.width
                height: 1 + frameBorders.workingArea.height

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

                Borders.FrameBorders {
                    id: frameBorders
                    screen: window.screen
                }

                Modules.FrameModules {
                    id: frameModules
                    z: -1
                    workingArea: frameBorders.workingArea
                }
            }

        }
    }
}
