pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import qs.components
import qs.services
import QtQuick.Layouts
import Quickshell.Widgets

WrapperRectangle {
  id: root
  property int desiredWsDisplayCount: 5
  readonly property var workspaces: Hypr.desiredWorkspacesList
  readonly property var focusedWorkspace: Hypr.focusedWorkspace

  color: Colorscheme.base01
  margin: 2
  radius: 4

  RowLayout {
    id: layout
    spacing: 2

    Repeater {
      model: root.workspaces
      Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

      MinshRectangle {
        id: wsBg
        required property var modelData
        property alias hovered: wsMouseArea.containsMouse

        height: 20
        width: wsName.width > 20 ? wsName.width + 8 : 20
        radius: 4
        color: modelData.focused ? Colorscheme.base07 : (hovered ? Colorscheme.base03 : "transparent") 
        MinshText {
          id: wsName
          anchors.centerIn: parent
          inverted: parent.modelData?.focused ?? false
          opacity: parent.modelData.isEmpty ? 0.6 : 1
          text: `${parent.modelData.name}`
        }

        MouseArea {
          id: wsMouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor
          onClicked: {
            Hypr.goToWorkspace(wsBg.modelData.id)
          }
        }
      }
    }
  }
}
