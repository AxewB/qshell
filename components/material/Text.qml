import QtQuick as QQ
import qs.service
import qs.config

QQ.Text {
    id: root

    property string type: "body"  // display | headline | title | body | label
    property string size: "medium" // large | medium | small
    property bool emphasized: false
    property bool centered: true // used for buttons and similar controls to place text in the center
    property bool animate: false // if behavior controlled

    readonly property var style: {
        const typography = Config.appearance.typography
        if (emphasized && typography.emphasized[type] && typography.emphasized[type][size]) {
            return typography.emphasized[type][size]
        }
        return typography[type][size]
    }

    renderType: Text.NativeRendering
    textFormat: Text.PlainText

    lineHeightMode: Text.FixedHeight
    lineHeight: centered ? style.size : style.lineHeight

    font {
        family: style.family
        pixelSize: style.size
        weight: style.weight
        letterSpacing: style.tracking
    }

    color: Colors.palette.m3onSurface ?? "black"

    QQ.Behavior on color {
        enabled: root.animate
        CAnim {}
    }
    component CAnim: M3ColorAnimation { speed: "short" }
}
