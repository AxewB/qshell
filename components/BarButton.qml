import qs.components
import Quickshell.Widgets
import QtQuick

MinshRectangle {
  id: controlButton
  property alias hovered: controlButtonMouseArea.containsMouse
  default property alias content: controlButtomItem.data

  signal clicked

  height: 20
  width: 20
  radius: 4

  color: hovered ? Colorscheme.base03 : "transparent"

  WrapperItem {
    id: controlButtomItem
    anchors.centerIn: parent
  }

  MouseArea {
    id: controlButtonMouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: controlButton.clicked()
  }
}
