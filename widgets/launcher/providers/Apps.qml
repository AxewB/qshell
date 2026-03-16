pragma ComponentBehavior: Bound
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import QtQuick
import Quickshell

Provider {
  id: root
  entries: DesktopEntries.applications.values
  shortcutName: "open-apps-provider"
  promptHint: "Launch"

  function execute(entry) {
    entry.entry.execute();
  }
}
