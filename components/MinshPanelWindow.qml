import Quickshell
import Quickshell.Wayland
import qs.services

PanelWindow {
  visible: true
  color: "transparent"
  WlrLayershell.namespace: Variables.namespace
}
