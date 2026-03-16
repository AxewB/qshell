import Quickshell
import QtQuick.Layouts
import qs.components
import qs.services

MinshWrapperRectangle {
  id: root
  color: Colorscheme.base00
  implicitWidth: 600
  margin: 16

  ColumnLayout {
    Mixer {}
  }
}
