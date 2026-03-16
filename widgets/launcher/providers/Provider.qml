import QtQuick
import qs.services
import qs.components
import Quickshell.Hyprland

Item {
  id: root
  required property var entries
  property string promptHint: ""
  property string shortcutName: ""

  signal bindCalled

  Loader {
    active: root.shortcutName !== ""

    MinshGlobalShortcut {
      name: root.shortcutName
      onPressed: {
        root.bindCalled()
      }
    }
  }
}
