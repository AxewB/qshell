pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import qs.services
import qs.config

Scope {
  id: root

  readonly property bool floating: Config.bar.floating
  property bool active: false

  Variants {
    model: Quickshell.screens

    MinshPanelWindow {
      id: panelWindow

      required property var modelData

      exclusiveZone: root.floating ? 1 : 25
      implicitHeight: !root.floating ? 25 : (root.active ? 25 : 1)
      screen: modelData

      anchors.left: true
      anchors.right: true
      anchors.top: true

      MouseArea {
        id: mouseArea

        property bool hovered: containsMouse

        anchors.fill: windowRect
        hoverEnabled: true

        onHoveredChanged: {
          if (!root.floating) {
            return;
          }
          root.active = true;
          if (hovered) {
            hideTimer.stop();
          } else {
            hideTimer.restart();
          }
        }
      }



      MinshRectangle {
        id: windowRect

        color: Colorscheme.base00
        height: panelWindow.height
        width: panelWindow.width
      }


      Item {
        id: sectionsAnchor


        anchors.top: windowRect.top
        anchors.topMargin: 12
        width: panelWindow.width

        MinshWrapperRectangle {
          anchors.left: sectionsAnchor.left
          anchors.verticalCenter: sectionsAnchor.verticalCenter

          LeftGroup {}
        }

        MinshWrapperRectangle {
          anchors.right: centerrow.left
          anchors.rightMargin: 4
          anchors.verticalCenter: sectionsAnchor.verticalCenter

          CenterLeftGroup {}
        }

        MinshWrapperRectangle {
          id: centerrow

          anchors.centerIn: sectionsAnchor
          anchors.leftMargin: 4
          anchors.rightMargin: 4

          CenterGroup {}
        }

        MinshWrapperRectangle {
          anchors.left: centerrow.right
          anchors.leftMargin: 4
          anchors.verticalCenter: sectionsAnchor.verticalCenter

          CenterRightGroup {}
        }

        MinshWrapperRectangle {
          anchors.right: sectionsAnchor.right
          anchors.verticalCenter: sectionsAnchor.verticalCenter

          RightGroup {}
        }
      }

      MinshRectangle {
          anchors.bottom: windowRect.bottom
          anchors.right: windowRect.right
          anchors.left: windowRect.left
          height: 1
          color: Colorscheme.base01
      }

      Timer {
        id: hideTimer

        interval: 500

        onTriggered: {
          root.active = false;
        }
      }
    }
  }

  component CenterGroup: RowLayout {
    spacing: 8

    Clock {}
  }
  component CenterLeftGroup: RowLayout {
    layoutDirection: Qt.RightToLeft
    spacing: 8
    Spacer { }
    Media {}
  }
  component CenterRightGroup: RowLayout {
    spacing: 8
  }
  component Spacer: MinshRectangle {
    height: 2
    radius: height
    width: 16
  }
  component LeftGroup: RowLayout {
    spacing: 8

    Workspaces {}
    Spacer {}
    CurrentApp {}
    Spacer {}
    ResourceMonitor {}
    Spacer {}

  }
  component RightGroup: RowLayout {
    layoutDirection: Qt.RightToLeft
    spacing: 0

    WrapperMouseArea {
      onClicked: Config.bar.floating = !Config.bar.floating

      MinshIcon {
        color: Colorscheme.base07
        fill: !root.floating ? 1 : 0
        icon: !root.floating ? "toggle_on" : "toggle_off"
        size: 20
      }
    }

    Vpn {}

    Controls {}

    Spacer {}

    Tray {}
  }
}
