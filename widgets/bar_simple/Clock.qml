pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

MinshWrapperRectangle {
  id: root

  property int textSize: 13

  RowLayout {
    MinshText {
      id: dateString

      color: Colorscheme.base04
      size: root.textSize
      text: Qt.formatDateTime(clock.date, "dd MMM")
    }

    MinshText {
      id: timeString

      size: root.textSize
      text: Qt.formatDateTime(clock.date, "hh:mm ddd")
    }
  }

  SystemClock {
    id: clock
  }
}
