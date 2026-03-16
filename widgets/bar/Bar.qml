pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick.Layouts
import qs.components
import qs.services

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    MinshPanelWindow {
      id: window
      required property var modelData

      screen: modelData
      implicitHeight: 32

      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
        id: windowRect
        width: window.width
        height: window.height
        color: Colorscheme.base00
      }

      Item {
        id: sectionsAnchor
        property int margin: 16
        anchors.centerIn: windowRect
        width: window.width - this.margin * 2

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
    }
  }

  component LeftGroup: RowLayout {
    spacing: 8
    MinshIcon {
      icon: "crown"
      size: 20
      color: Colorscheme.base07
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
    Time {}
  }
  component CenterRightGroup: RowLayout {
    spacing: 8
    Media {}
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
