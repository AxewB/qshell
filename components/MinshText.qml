import QtQuick
import qs.services

Text {
  id: root
  property bool inverted: false
  property int size: 12

  color: inverted ? Colorscheme.base00 : Colorscheme.base05

  renderType: Text.NativeRendering
  textFormat: Text.PlainText

  elide: Text.ElideRight

  font {
    family: "CaskaydiaCove Nerd Font"
    pixelSize: root.size
  }
}
