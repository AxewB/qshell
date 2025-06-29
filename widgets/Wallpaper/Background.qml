import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "root:/service"
import "root:/utils"



Scope {
    id: root
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"
            WlrLayershell.exclusionMode: ExclusionMode.ignore
            WlrLayershell.layer: WlrLayer.Background

            anchors {
                left: true
                top: true
                right: true
                bottom: true
            }

            Wallpaper {
                anchors.fill: parent
            }

        }
    }
}
