pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import qs.services

// TODO: read and cache applications

Scope {
  id: root
  property bool active: false

  GlobalShortcut {
    id: shortcut
    appid: Variables.namespace
    name: "test"
    onPressed: root.active = !root.active
  }

  function activate_menu_item(item = {}) {
    console.log(item);
    Quickshell.execDetached(["sh", "-c", item.cmd]);
    root.active = false;
  }

  PanelWindow {
    id: panelWindow
    visible: root.active
    implicitHeight: rect.height
    implicitWidth: rect.width
    focusable: true
    Rectangle {
      id: rect
        width: 400
        height: 200
        color: "grey"
      TextInput {
        anchors.fill: reck
        focus: true
      }
    }
  }

  HyprlandFocusGrab {
    id: grab
    active: root.active
    windows: [panelWindow]
  }

  // Loader {
  //   active: root.active
  //   sourceComponent: PanelWindow {
  //     id: panelwindow
  //
  //     anchors {
  //       left: true
  //       bottom: true
  //       right: true
  //     }
  //     focusable: true
  //     color: "transparent"
  //     WlrLayershell.namespace: Variables.namespace
  //     exclusionMode: ExclusionMode.Ignore
  //
  //     Rectangle {
  //       anchors.fill: textinput
  //       color: "grey"
  //     }
  //
  //     TextInput {
  //       id: textinput
  //       height: 100
  //       width: 200
  //       focus: true
  //       anchors.centerIn: parent
  //       onAccepted: {
  //         root.activate_menu_item({
  //           name: "test item",
  //           cmd: "notify-send 'hello, i am test action in quickshell!'"
  //         });
  //       }
  //
  //       Keys.onPressed: event => {
  //         if (event.key === Qt.Key_Escape) {
  //           console.log("Escape was pressed");
  //           root.active = false;
  //         }
  //       }
  //     }
  //
  //     HyprlandFocusGrab {
  //       id: grab
  //       windows: [panelwindow]
  //       active: true
  //       onActiveChanged: {
  //         if (!active)
  //           root.active = false;
  //       }
  //     }
  //   }
  // }
}
