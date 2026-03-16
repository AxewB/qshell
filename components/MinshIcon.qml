import QtQuick

MinshText {
  id: root
  property real size: 16
  property real fill: 1
  property real truncatedFill: fill.toFixed(1) 
  property string icon: "help"

  text: icon
  renderType: Text.NativeRendering

  font {
    hintingPreference: Font.PreferNoHinting
    family: "Material Symbols Rounded"
    pixelSize: size
    variableAxes: {
      "FILL": truncatedFill,
      "opsz": size
    }
  }
}
