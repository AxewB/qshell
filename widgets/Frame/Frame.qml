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

    PanelWindow {
        property var modelData
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

        Borders {id: borders; bar: bar; screen: modelData }

        MultiEffect {
            source: borders
            anchors.fill: borders
            shadowEnabled: true
            shadowColor: Colors.palette.m3shadow
        }

        Bar { id: bar }


        Exclusions {
            screen: modelData
            bar: bar
            borders: borders
        }
    }
}
