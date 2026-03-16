pragma Singleton
import qs.components
import Quickshell.Hyprland
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string lang: ""

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (!event.name.includes("activelayout")) {
        return;
      }
      layoutUpdateProcess.running = true;
    }
  }

  Process {
    id: layoutUpdateProcess
    command: ["hyprctl", "devices", "-j"]
    stdout: StdioCollector {
      onStreamFinished: {
        const json = JSON.parse(this.text);
        const mainKeyboard = json.keyboards.filter(k => k.main === true)[0];
        const keymap = mainKeyboard.active_keymap;
        const keymapShort = keymap.slice(keymap.indexOf('(') + 1, keymap.lastIndexOf(')')).slice(0, 2).toUpperCase();

        root.lang = keymapShort;
      }
    }
  }

  function next() {
    Quickshell.execDetached(["sh", "-c", "hyprctl switchxkblayout current next"]);
  }

  Component.onCompleted: {
    layoutUpdateProcess.running = true;
  }
}
