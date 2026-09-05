//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
// import qs.widgets.bar
import qs.widgets.bar_simple
import qs.widgets.launcher
import qs.widgets.wallpaper
import qs.widgets.rightpanel
import qs.widgets.osd
import qs.widgets.notifications
import qs.services

Scope {
  Component.onCompleted: {
    console.log("Loaded configuration at:", Qt.formatDateTime(new Date(), "hh:mm:ss"))
    console.log(Colorscheme.base00)
  }

  Bar {
    id: bar_component
  }
  Launcher {}
  Wallpaper {}
  OSD {}
  RightPanel {}
  Notifications {}
}
