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
// WrapperRectangle {
//   id: root
//   color: Colorscheme.base01
//   margin: 2
//   radius: 4
//
//   RowLayout {
//     id: layout
//     spacing: 2
//     ControlButton {
//       MinshText {
//         text: InputLanguage.lang
//       }
//       onClicked: InputLanguage.next()
//     }
//     ControlButton {
//       // TODO: make window for controlling bluetooth
//       MinshIcon {
//         icon: "bluetooth"
//       }
//       onClicked: Quickshell.execDetached(["sh", "-c", "minsh-launch-tui bluetui"])
//     }
//     ControlButton {
//       // TODO: make visualization of current state of intenet (on/off)
//       MinshIcon {
//         icon: "wifi"
//       }
//       onClicked: Quickshell.execDetached(["sh", "-c", "minsh-launch-tui nmtui"])
//     }
//     ControlButton {
//       // TODO: add visualization of current volume
//       MinshIcon {
//         icon: "volume_down"
//       }
//       onClicked: Quickshell.execDetached(["sh", "-c", "minsh-launch-tui wiremix"])
//     }
//     ControlButton {
//       MinshIcon {
//         icon: "memory"
//       }
//       onClicked: Quickshell.execDetached(["sh", "-c", "minsh-launch-tui-small-font btop"])
//     }
//   }
//
//   component ControlButton: MinshRectangle {
//     id: controlButton
//     property alias hovered: controlButtonMouseArea.containsMouse
//     default property alias content: controlButtomItem.data
//
//     signal clicked
//
//     height: 20
//     width: 20
//     radius: 4
//
//     color: hovered ? Colorscheme.base03 : "transparent"
//
//     WrapperItem {
//       id: controlButtomItem
//       anchors.centerIn: parent
//     }
//
//     MouseArea {
//       id: controlButtonMouseArea
//       anchors.fill: parent
//       hoverEnabled: true
//       cursorShape: Qt.PointingHandCursor
//       onClicked: controlButton.clicked()
//     }
//   }
// }
