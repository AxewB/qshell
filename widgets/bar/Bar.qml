pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import qs.services
import qs.config

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    MinshPanelWindow {
      id: panelWindow
      required property var modelData
      readonly property bool floating: Config.bar.floating
      property bool active: false

      screen: modelData
      implicitHeight: !floating ? 32 : (active ? 32 : 1)

      exclusiveZone: floating ? 1 : 32

      MouseArea {
        id: mouseArea
        anchors.fill: windowRect
        hoverEnabled: true

        property bool hovered: containsMouse

        onHoveredChanged: {
          if (!panelWindow.floating) {
            return;
          }
          panelWindow.active = true
          if (hovered) {
            hideTimer.stop()
          } else {
            hideTimer.restart()
          }
        }
      }


      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
        id: windowRect
        width: panelWindow.width
        height: panelWindow.height
        color: Colorscheme.base00
      }

      Item {
        id: sectionsAnchor
        property int margin: 16
        anchors.centerIn: windowRect
        width: panelWindow.width - this.margin * 2

        MinshWrapperRectangle {
          anchors.left: sectionsAnchor.left
          anchors.verticalCenter: sectionsAnchor.verticalCenter
          LeftGroup {}
        }

        MinshWrapperRectangle {
          anchors.right: centerrow.left
          anchors.verticalCenter: sectionsAnchor.verticalCenter
          anchors.rightMargin: 4
          CenterLeftGroup {}
        }

        MinshWrapperRectangle {
          id: centerrow
          anchors.centerIn: sectionsAnchor
          anchors.rightMargin: 4
          anchors.leftMargin: 4
          CenterGroup {}
        }

        MinshWrapperRectangle {
          anchors.left: centerrow.right
          anchors.verticalCenter: sectionsAnchor.verticalCenter
          anchors.leftMargin: 4
          CenterRightGroup {}
        }

        MinshWrapperRectangle {
          anchors.right: sectionsAnchor.right
          anchors.verticalCenter: sectionsAnchor.verticalCenter
          RightGroup {}
        }
      }

      Timer {
        id: hideTimer
        interval: 500
        onTriggered: {
          panelWindow.active = false
        }
      }
    }
  }




  component LeftGroup: RowLayout {
    spacing: 8
    WrapperMouseArea {
      onClicked: Config.bar.floating = !Config.bar.floating

      MinshIcon {
        icon: !panelWindow.floating ? "toggle_on" : "toggle_off"

        size: 20
        color: Colorscheme.base07
      }
    }

    Workspaces {}
    CurrentApp {}
  }

  component CenterLeftGroup: RowLayout {
    spacing: 8
    layoutDirection: Qt.RightToLeft
    Divider {}
    ResourceMonitor {}
  }
  component CenterGroup: RowLayout {
    spacing: 8
    Clock {}
  }
  component CenterRightGroup: RowLayout {
    spacing: 8
    Media {
      visible: MprisService.players.length > 0
    }
    Vpn {}
  }
  component RightGroup: RowLayout {
    spacing: 8
    layoutDirection: Qt.RightToLeft
    Controls {}
    Tray {}
  }
  component Divider: MinshRectangle {
    height: 2
    width: 16
    radius: height
  }
}
