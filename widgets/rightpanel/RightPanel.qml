pragma ComponentBehavior: Bound
import QtQuick.Effects

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.components

Scope {
  id: root
  required property Item bar
  property string shortcutName: "toggle-rightbar"
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
    grab.windows = [];
  }

  Loader {
    active: root.active
    sourceComponent: MinshPanelWindow {
      id: launcherWindow

      anchors.right: true
      anchors.top: true
      anchors.bottom: true
      anchors.left: true
      focusable: true

      // exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Top
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

      MouseArea {
        anchors.fill: parent
        onClicked: root.active = false
      }

      Content {
        id: content
        anchors.right: parent.right
        anchors.top: parent.top
        implicitHeight: parent.height
        anchors.margins: 20
      }

      Component.onCompleted: {
        grab.windows.push(launcherWindow);
      }

      MultiEffect {
        source: content
        anchors.fill: content
        shadowEnabled: true
        blurMax: 16
        shadowColor: "black"
      }
    }
  }

  HyprlandFocusGrab {
    id: grab
    windows: []
    active: true
  }
}
