import QtQuick
import "root:/service"
import qs.config

Text {
    id: root

    property string type: "text"
    property int size: Config.appearance.font.size[root.type]

    color: Colors.palette.m3onSurface

    renderType: Text.NativeRendering
    textFormat: Text.PlainText

    font.family: Config.appearance.font.family.sans
    font.pixelSize: root.size

    Behavior on color {
        ColorAnimation {
            duration: Config.appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.appearance.animation.curves.ease ?? [0,0,1,1]
        }
    }
}
