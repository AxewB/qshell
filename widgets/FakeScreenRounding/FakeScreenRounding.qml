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
import qs.service
import qs.modules
import qs.config
import qs.components

LazyLoader {
    active: AppConfig.modules.fakeScreenRounding
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: window
            property ShellScreen modelData
            screen: modelData

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Overlay
            color: "transparent"

            mask: Region {
                x: 0
                y: 0
                width: window.width
                height: window.height
                intersection: Intersection.Xor
            }

            anchors {
                left: true
                right: true
                top: true
                bottom: true
            }

            Rectangle {
                id: borders
                anchors.fill: parent
                color: "black"
                visible: false
            }

            Item {
                id: mask

                anchors.fill: parent
                layer.enabled: true
                visible: false

                Rectangle {
                    anchors.fill: parent
                    radius: BorderConfig.radius
                }
            }

            MultiEffect {
                source: borders
                maskSource: mask
                anchors.fill: parent
                maskEnabled: true
                maskInverted: true
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1
            }
        }
    }
}
