pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick.Effects
import QtQuick
import qs.components

Scope {
  id: root
  readonly property string color: "#000000"

  Variants {
    model: Quickshell.screens

    MinshPanelWindow {
      id: window
      required property var modelData
      screen: modelData

      exclusionMode: ExclusionMode.Ignore
      aboveWindows: false
      WlrLayershell.layer: WlrLayer.Overlay

      anchors {
        left: true
        bottom: true
        top: true
        right: true
      }

      mask: Region {}

      MinshRectangle {
        anchors.fill: parent
        color: root.color

        layer.enabled: true
        layer.effect: MultiEffect {
          maskSource: mask
          maskEnabled: true
          maskInverted: true
          maskThresholdMin: 0.5
          maskSpreadAtMin: 1
        }
      }

      Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
          anchors.fill: parent
          radius: 8
        }
      }
    }
  }
}
