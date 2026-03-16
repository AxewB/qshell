import QtQuick.Controls 
import qs.components
import qs.services

Button {
  id: control
  hoverEnabled: true

  contentItem: MinshText {
    text: control.text
    font: control.font
    opacity: enabled ? 1.0 : 0.3
    horizontalAlignment: MinshText.AlignHCenter
    verticalAlignment: MinshText.AlignVCenter
    elide: MinshText.ElideRight
  }

  background: MinshRectangle {
    implicitWidth: 80
    opacity: enabled ? 1 : 0.3
    color: control.hovered ? Colorscheme.base02 : Colorscheme.base01
  }
}
