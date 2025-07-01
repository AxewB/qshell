import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import "root:/service"
import "root:/config"
import "root:/utils"
import "root:/components"

WrapperItem {
    id: root
    readonly property bool enabled: NightLightService.enabled

    WrapperMouseArea {
        anchors.fill: parent
        onClicked: root.toggleNightLight()

        WrapperRectangle {
            id: content
            radius: 1000
            margin: Appearance.padding.normal
            color: root.enabled ? Colors.palette.m3primary : Colors.palette.m3surfaceContainer

            Icon {
                icon: "night_sight_max"
            }
        }
    }

    function toggleNightLight() {
        NightLightService.enabled = !NightLightService.enabled
    }

    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: window
            property ShellScreen modelData
            screen: modelData

            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Overlay
            color: "transparent"

            // making click-through
            mask: Region {
                x: 0
                y: 0
                width: window.width
                height: window.height
                intersection: Intersection.Xor
            }

            anchors {
                top: true
                right: true
                bottom: true
                left: true
            }

            // overlay color
            StyledRectangle {
                anchors.fill: parent
                color: NightLightService.color
                opacity: root.enabled ? NightLightService.intensity : 0
            }
        }
    }
}
