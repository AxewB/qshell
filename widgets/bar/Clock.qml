pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.components
import qs.services

MinshWrapperRectangle {
  id: root

  MinshText {
    id: timeString
    text: Qt.formatDateTime(clock.date, "hh:mm dddd, dd MMM")
  }

  SystemClock {
    id: clock
  }
}
