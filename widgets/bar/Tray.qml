pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import qs.components
import qs.services

WrapperItem {
  id: root
  readonly property list<SystemTrayItem> trayItems: SystemTray.items.values
  implicitWidth: layout.implicitWidth
  implicitHeight: layout.implicitHeight

  RowLayout {
    id: layout
    spacing: 4

    Repeater {
      model: root.trayItems
      Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

      TrayItem {}
    }
  }

  component TrayItem: Item {
    id: trayItem

    required property SystemTrayItem modelData

    height: 20
    width: 20

    MinshWrapperRectangle {
      anchors.fill: parent
      property alias hovered: mouseArea.containsMouse
      color: hovered ? Colorscheme.base03 : "transparent"
      radius: 4
      margin: 2

      IconImage {
        anchors.centerIn: parent
        height: parent.height
        width: parent.width
        asynchronous: true

        source: {
          let icon = trayItem.modelData.icon;
          if (icon.includes("?path=")) {
            const [name, path] = icon.split("?path=");
            icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
          }
          return icon;
        }
      }
    }

    MouseArea {
      id: mouseArea
      anchors.fill: parent
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      cursorShape: Qt.PointingHandCursor

      hoverEnabled: true

      onClicked: function (mouse) {
        if (mouse.button === Qt.LeftButton) {
          trayItem.modelData.activate();
        } else if (mouse.button === Qt.MiddleButton) {
          trayItem.modelData.secondaryActivate();
        } else if (mouse.button === Qt.RightButton) {
          const pos = trayItem.mapToItem(null, 0, 0);
          trayItem.modelData.display(QsWindow.window, pos.x, pos.y + trayItem.height);
        }
      }

      onWheel: function (wheel) {
        if (wheel.angleDelta.y > 0) {
          trayItem.modelData.scroll(1, false);
        } else {
          trayItem.modelData.scroll(-1, false);
        }
      }
    }
  }
}
