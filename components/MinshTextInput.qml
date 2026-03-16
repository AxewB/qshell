import QtQuick
import Quickshell
import qs.components
import qs.services

TextInput {
  id: root
  property bool inverted: false
  property int size: 12

  color: inverted ? Colorscheme.base00 : Colorscheme.base05

  renderType: Text.NativeRendering

  font {
    family: "monospace"
    pixelSize: root.size
  }

}
