import QtQuick
import qs.service

Rectangle {
    id: root

    color: "transparent"

    Behavior on color {
        ColorAnimation {
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.easeOut
        }
    }

    Behavior on implicitHeight { Anim {} }
    Behavior on implicitWidth { Anim {} }
    Behavior on scale {Anim {} }
    Behavior on opacity {Anim {} }
    Behavior on x { Anim {} }
    Behavior on y { Anim {} }

    states: [
        State {
            name: "pressed"
            PropertyChanges {
                target: root
                scale: 0.8
            }
        },
        State {
            name: "released"
            PropertyChanges {
                target: root
            }
        }
    ]

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.slow
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.easeOut
    }
}
