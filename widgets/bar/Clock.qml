pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

MinshWrapperRectangle {
  id: root

  RowLayout {
    MinshText {
      id: dateString

      color: Colorscheme.base04
      text: Qt.formatDateTime(clock.date, "dd MMM")
    }

    MinshText {
      id: timeString
      text: Qt.formatDateTime(clock.date, "hh:mm ddd")
    }
  }

  SystemClock {
    id: clock
  }
}
