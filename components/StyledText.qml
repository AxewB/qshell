import QtQuick
import "root:/service"
import qs.service

Text {
    id: root

    property string type: "text"

    color: Colors.palette.m3onSurface
    
    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    
    font.family: Appearance.font.family
    font.pixelSize: Appearance.font.size[root.type]

    Behavior on color {
        ColorAnimation {
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease ?? [0,0,1,1]
        }
    }

    Behavior on scale { Anim {} }
    Behavior on font { Anim {} }
    Behavior on x { Anim {} }
    Behavior on y { Anim {} }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }
}
