import QtQuick.Layouts
import qs.services

MinshWrapperRectangle {
  id: root
  default property alias content: layout.data

  margin: 2
  radius: 4

  RowLayout {
    id: layout
    spacing: 2
  }
}
