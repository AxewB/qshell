import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import qs.components
import qs.services

Scope {
  id: root
  readonly property real volume: Pipewire.defaultAudioSink?.audio.volume ?? 0

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Connections {
    target: Pipewire.defaultAudioSink?.audio

    function onVolumeChanged() {
      root.shouldShowOsd = true;
      hideTimer.restart();
    }
  }

  property bool shouldShowOsd: false

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: root.shouldShowOsd = false
  }

  LazyLoader {
    active: root.shouldShowOsd

    MinshPanelWindow {
      anchors.top: true
      margins.top: 16
      exclusiveZone: 0

      implicitWidth: 280
      implicitHeight: 50

      // An empty click mask prevents the window from blocking mouse events.
      mask: Region {}

      MinshRectangle {
        anchors.fill: parent
        radius: 8
        color: Colorscheme.base00

        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: 16
          anchors.rightMargin: 16
          spacing: 16

          MinshIcon {
            size: 32
            icon: {
              if (root.volume >= 0.7)
                return "volume_up";
              else if (root.volume >= 0.1)
                return "volume_down";
              else
                return "volume_mute";
            }
          }

          MinshRectangle {
            // Stretches to fill all left-over space
            Layout.fillWidth: true

            implicitHeight: 8
            radius: 2
            color: Colorscheme.base01

            MinshRectangle {
              id: progressBar
              anchors.left: parent.left
              anchors.top: parent.top
              anchors.bottom: parent.bottom

              implicitWidth: parent.width * root.volume
              radius: parent.radius
              color: Colorscheme.base07
            }

            MinshWrapperRectangle {
              anchors.leftMargin: -textIndicator.width
              anchors.left: progressBar.right
              anchors.verticalCenter: progressBar.verticalCenter
              border.color: Colorscheme.base07
              border.width: 1
              margin: 4
              radius: 4
              color: Colorscheme.base01

              MinshText {
                id: textIndicator
                size: 14
                text: {
                  if (root.volume < 1) {
                    return `${(root.volume.toFixed(2) * 100).toString().slice(0, 2)}%`;
                  } else {
                    return `${(root.volume.toFixed(2) * 100).toString().slice(0, 3)}%`;
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
