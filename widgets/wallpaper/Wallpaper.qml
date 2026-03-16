import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.components
import qs.services
import qs.config

Scope {
  id: root
  readonly property string path: Config.wallpaper

  Variants {
    model: Quickshell.screens
    MinshPanelWindow {
      id: wallpaper
      required property var modelData
      screen: modelData
      color: Colorscheme.base00

      exclusionMode: ExclusionMode.Ignore
      aboveWindows: false
      WlrLayershell.layer: WlrLayer.Bottom

      anchors {
        left: true
        bottom: true
        top: true
        right: true
      }

      Image {
        anchors.fill: parent
        source: root.path
      }
    }
  }
}
