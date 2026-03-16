pragma ComponentBehavior: Bound
import Quickshell.Widgets
import QtQuick.Layouts
import qs.components
import qs.services
import QtQuick
import Quickshell

MinshWrapperRectangle {
  id: root
  required property var modelData
  readonly property DesktopEntry entry: modelData.entry
  required property int index
  margin: 8

  signal clicked

  RowLayout {
    spacing: 16
    IconImage {
      Layout.preferredHeight: 32
      Layout.preferredWidth: 32
      asynchronous: true
      source: Quickshell.iconPath(root.entry.icon, true)
    }

    WrapperMouseArea {
      id: marea
      Layout.fillWidth: true
      clip: true
      ColumnLayout {
        MinshText {
          id: entryName
          Layout.maximumWidth: marea.width
          text: entry.name
          size: 14
        }
        MinshText {
          id: entryDescription
          visible: entry.comment
          Layout.maximumWidth: marea.width
          text: entry.comment
          size: 12
          opacity: 0.6
        }
      }
    }
  }
}
