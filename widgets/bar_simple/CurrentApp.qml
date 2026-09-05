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
    WrapperItem {
      RowLayout {

        MinshText {
          Layout.maximumWidth: 120
          text: root.appName
          size: 13
          elide: Text.ElideRight
        }

        MinshText {
          Layout.maximumWidth: 140
          size: 12
          text: root.appTitle
          elide: Text.ElideRight
          opacity: 0.6
        }
      }
    }
  }
}
