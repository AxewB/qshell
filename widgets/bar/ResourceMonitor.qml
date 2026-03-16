import QtQuick.Layouts
import Quickshell.Widgets
import qs.services
import qs.components

MinshWrapperRectangle {
  id: root
  readonly property string cpu: ResourceMonitorService.cpu
  readonly property string ram: ResourceMonitorService.ram
  margin: 2
  radius: 4

  RowLayout {
    spacing: 4
    WrapperItem {
      RowLayout {
        spacing: 2
        MinshIcon {
          icon: "memory"
        }
        MinshText {
          text: Math.round(root.cpu * 100) + "%"
        }
      }
    }
    WrapperItem {
      RowLayout {
        spacing: 2
        MinshIcon {
          icon: "memory_alt"
        }
        MinshText {
          text: root.ram * 100 + "%"
        }
      }
    }
  }
}
