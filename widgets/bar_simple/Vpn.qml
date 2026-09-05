import QtQuick.Controls
import QtQuick.Layouts
import QtQuick
import Quickshell
import qs.components
import qs.services

MinshWrapperRectangle {
  id: root
  property list<string> activeVpns: NetworkService.activeVpnConnections
  property bool vpnActive: activeVpns.length > 0

  MinshRectangle {
    id: rect
    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth

    MouseArea {
      id: ma
      anchors.fill: parent
      hoverEnabled: true
      onClicked: {
        NetworkService.disconnectAllVpns()
      }
    }

    MinshIcon {
      visible: root.vpnActive
      id: icon
      size: 18
      icon: "vpn_key"
    }

    PopupWindow {
      anchor {
        item: rect
        gravity: Edges.Bottom
        margins {
          top: rect.height + 8
          left: rect.width
        }
      }

      color: "transparent"

      implicitHeight: layout.implicitHeight

      MinshWrapperRectangle {
        id: layout
        color: Colorscheme.base00
        border.width: 2
        border.color: Colorscheme.base07
        margin: 8

        ColumnLayout {
          Repeater {
            model: root.activeVpns
            MinshText {
              text: modelData
            }
          }
        }
      }

      visible: ma.containsMouse
    }
  }
}
