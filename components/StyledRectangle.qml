import QtQuick
import "root:/service"

Rectangle {
    id: root

    color: "transparent"

    Behavior on color {
        ColorAnimation {
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.standard
        }
    }

    Behavior on implicitHeight { Anim {} }
    Behavior on implicitWidth { Anim {} }
    Behavior on scale {Anim {} }
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

    transitions: [
        Transition {
            from: "normal";
            to: "hovered"
            NumberAnimation { properties: "width,height"; duration: Appearance.animation.durations.normal }
        },
        Transition {
            from: "hovered";
            to: "normal"
            NumberAnimation { properties: "width,height"; duration: Appearance.animation.durations.normal; easing.type: Easing.OutBounce }
        },
        Transition {
            from: "pressed";
            to: "released"
            NumberAnimation { properties: "width,height"; duration:Appearance.animation.durations.normal ; easing.type: Easing.OutBounce }
        }
    ]

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.slow
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }
}
