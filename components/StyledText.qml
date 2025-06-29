import QtQuick
import "root:/service"

Text {
    id: root

    property string type: "text"

    color: Colors.palette.m3onSurface

    font {
        family: Appearance.font.family
        pixelSize: Appearance.font.size[root.type]
        weight: Appearance.font.weight
    }


    Behavior on color {
        ColorAnimation {
            duration: Appearance.animation.durations.turtle
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
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
