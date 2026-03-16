import QtQuick.Controls
import QtQuick.Layouts
import qs.components
import qs.services

MinshWrapperRectangle {
  id: actionHint
  required property Action action

  ColumnLayout {
    spacing: 2
    MinshWrapperRectangle {
      Layout.alignment: Qt.AlignHCenter
      margin: 4
      color: Colorscheme.base01

      MinshText {
        text: actionHint.action.text
      }
    }
    MinshText {
      Layout.alignment: Qt.AlignHCenter
      opacity: 0.6
      size: 10
      text: actionHint.action.shortcut
    }
  }
}
