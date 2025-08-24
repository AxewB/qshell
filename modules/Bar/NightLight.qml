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

// TODO: сделать увеличение/уменьшение температуры по скроллу
WrapperItem {
    id: root
    readonly property bool enabled: NightLightService.enabled

    StyledIconButton {
        id: control
        active: root.enabled
        icon: "symptoms"
        size: Config.appearance.icon.small
        onLeftClicked: root.toggleNightLight()
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
