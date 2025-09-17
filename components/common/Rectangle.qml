import QtQuick
import qs.components.material as MD
Rectangle {
    id: root
    color: "transparent"
    property bool animate: true
    property Animation colorAnimation: CAnim {}

    Behavior on color {
        enabled: root.animate
        animation: root.colorAnimation
    }

    component CAnim: MD.M3ColorAnimation { curve: "emphasized" }
}
