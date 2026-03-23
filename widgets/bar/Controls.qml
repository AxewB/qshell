pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.components
import qs.services
import QtQuick.Layouts
import Quickshell.Widgets

BarGroup {
  color: Colorscheme.base01
  BarButton {
    MinshText {
      text: InputLanguage.lang
    }
    onClicked: InputLanguage.next()
  }
  BarButton {
    // TODO: make window for controlling bluetooth
    MinshIcon {
      icon: "bluetooth"
    }
    onClicked: Quickshell.execDetached(["sh", "-c", "minsh-launch-tui bluetui"])
  }
  BarButton {
    // TODO: make visualization of current state of intenet (on/off)
    MinshIcon {
      icon: "wifi"
    }
    onClicked: Quickshell.execDetached(["sh", "-c", "minsh-launch-tui nmtui"])
  }
  BarButton {
    // TODO: add visualization of current volume
    MinshIcon {
      icon: "volume_down"
    }
    onClicked: Quickshell.execDetached(["sh", "-c", "minsh-launch-tui wiremix"])
  }
  BarButton {
    MinshIcon {
      icon: "memory"
    }
    onClicked: Quickshell.execDetached(["sh", "-c", "minsh-launch-tui-small-font btop"])
  }
}
