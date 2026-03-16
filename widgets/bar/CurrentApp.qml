import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell
import qs.components
import qs.services

WrapperItem {
  id: root
  readonly property var app: Hypr.activeApp ?? {}
  readonly property var desktopEntry: app?.appId ? DesktopEntries.byId(app.appId) : {}

  readonly property var appIcon: desktopEntry?.icon ?? ""
  readonly property string appName: desktopEntry?.name ?? ""
  readonly property string appTitle: app?.title ?? ""

  RowLayout {
    IconImage {
      height: 16
      width: 16
      asynchronous: true
      source: Quickshell.iconPath(root.appIcon, true)
    }

    WrapperItem {
      ColumnLayout {
        spacing: -2

        MinshText {
          Layout.maximumWidth: 120
          text: root.appName
          elide: Text.ElideRight
        }

        MinshText {
          Layout.maximumWidth: 100
          size: 10
          text: root.appTitle
          elide: Text.ElideRight
          opacity: 0.6
        }
      }
    }
  }
}
