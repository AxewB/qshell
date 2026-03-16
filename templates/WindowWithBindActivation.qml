pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.components

Scope {
  id: root
  property string shortcutName: "SHORTCUTNAME"
  property bool active: false

  MinshGlobalShortcut {
    name: root.shortcutName
    onPressed: root.toggleWindow()
  }

  function toggleWindow(provider) {
    if (root.active) {
      root.active = false;
      return;
    }

    root.active = !root.active;
    root.reset();
  }

  function execute() {
    currentProvider.execute(activeEntry);
    root.active = false;
  }

  function reset() {
    prompt = "";
    grab.windows = [];
  }

  Loader {
    active: root.active
    sourceComponent: MinshPanelWindow {
      id: launcherWindow

      focusable: true

      implicitWidth: launcherContent.implicitWidth
      implicitHeight: launcherContent.implicitHeight

      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

      MouseArea {
        anchors.fill: parent
        onClicked: root.active = false
      }

      Component.onCompleted: {
        grab.windows.push(launcherWindow);
        console.log(grab.windows);
      }
    }
  }

  HyprlandFocusGrab {
    id: grab
    windows: []
    active: true
  }
}
