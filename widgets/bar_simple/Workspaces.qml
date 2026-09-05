pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import qs.components
import qs.services
import QtQuick.Layouts
import Quickshell.Widgets

MinshWrapperRectangle {
  id: root
  property int desiredWsDisplayCount: 5
  readonly property var workspaces: Hypr.desiredWorkspacesList
  readonly property var focusedWorkspace: Hypr.focusedWorkspace

  RowLayout {
    id: layout
    spacing: 0

    Repeater {
      model: root.workspaces
      Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

      MinshRectangle {
        id: wsBg
        required property var modelData
        property alias hovered: wsMouseArea.containsMouse

        height: 24
        width: wsName.width > 32 ? wsName.width + 8 : 32
        radius: 0
        color: if (hovered) {
          return Colorscheme.base02
        } else if (modelData.focused) {
          return Colorscheme.base01
        } else {
          return  Colorscheme.base00
        }

        // color: modelData.focused ? Colorscheme.base07 : (hovered ? Colorscheme.base03 : "transparent")

        MinshText {
          id: wsName
          anchors.centerIn: parent
          opacity: parent.modelData.isEmpty ? 0.6 : 1
          text: `${parent.modelData.name}`
          size: 13
        }

        MouseArea {
          id: wsMouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            Hypr.focus_ws(wsBg.modelData.id)
          }
        }

        MinshRectangle {
          visible: parent.modelData.focused ?? false
          radius: 0
          anchors.bottom: parent.bottom
          height: 4
          width: parent.width
          color: Colorscheme.base07
        }
      }
    }
  }
}
