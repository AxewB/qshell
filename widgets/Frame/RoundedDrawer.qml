import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.modules
import qs.service
import qs.config

Rectangle {
    id: root
    property Position position: Position {}
    property bool active: false
    property int radius: Appearance.radius.normal
    property int arcSize: active ? 32 : 0
    default property alias child: childWrapper.data

    // changing only for TOP and BOTTOM sides
    implicitHeight: if (position.top || position.bottom) {
        if (active) return childWrapper.implicitHeight
        else return 0
    } else return childWrapper.implicitHeight

    // changing only for LEFT and RIGHT sides
    implicitWidth: if (position.right || position.left && (!position.bottom && !position.top)) {
        if (active) return childWrapper.implicitWidth
        else return 0
    } else return childWrapper.implicitWidth

    color: Colors.palette.m3surface

    Behavior on scale { Anim {} }
    Behavior on implicitWidth { Anim {} }
    Behavior on implicitHeight { Anim {} }
    Behavior on arcSize { Anim {} }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.easeOut
    }

    component Position: QtObject {
        property bool top: false
        property bool right: false
        property bool bottom: false
        property bool left: false
    }

    topLeftRadius: (position.right || position.bottom) && !position.top && !position.left ? radius : 0
    topRightRadius: (position.left || position.bottom) && !position.top && !position.right ? radius : 0
    bottomLeftRadius: (position.right || position.top) && !position.bottom && !position.left ? radius : 0
    bottomRightRadius: (position.left || position.top) && !position.bottom && !position.right ? radius : 0

    Item {
        implicitHeight: childWrapper.implicitHeight
        implicitWidth: childWrapper.implicitWidth
        // changing only for LEFT and RIGHT sides
        x: if (active) return 0
            else if (position.left && (!position.top && !position.bottom)) return -implicitWidth
            else if (position.right && (!position.top && !position.bottom)) return implicitWidth
            else return 0

        // changing only for TOP and BOTTOM sides
        y: if (active) return 0
            else if (position.top) return -implicitHeight
            else if (position.bottom) return implicitHeight
            else return 0

        Behavior on x { Anim {} }
        Behavior on y { Anim {} }

        WrapperItem {
            id: childWrapper
        }
    }

    Rectangle {
        id: primary
        color: "transparent"
        height: root.implicitHeight > root.arcSize && root.implicitWidth > root.arcSize ? root.arcSize : 0
        width: height
        y: position.top ? 0
            : position.bottom ? root.height - height
            : -height
        x: position.top || position.bottom ? (position.right ? -width : root.width )
            : (position.right ? root.width - width : 0 )

        rotation: {
            if (position.top) {
                if (position.right) 180
                else return 90
            }
            else if (position.right) {
                return 270
            }
            else return 0
        }
        layer.enabled: true
        layer.samples: 8

        Arc {}
    }
    Rectangle {
        id: secondary
        height: root.implicitHeight > root.arcSize && root.implicitWidth > root.arcSize ? root.arcSize : 0
        width: height
        y: position.bottom ? (position.right || position.left ? -height : root.height - height)
            : position.top ? (position.right || position.left ? root.height : 0)
            : root.height

        x: position.right ? root.width - width
            : position.left ? 0
            : -width

        rotation: {
            if (position.left && !position.bottom) return 90
            if ((position.top || position.right) && !position.bottom) return 180
            if (position.bottom && !position.left) return 270
            else return 0
        }

        color: "transparent"
        layer.enabled: true
        layer.samples: 8
        Arc {}
    }

    component Arc: Shape {
        antialiasing: true
        ShapePath {
            strokeWidth: 0
            fillColor: root.color

            PathLine { x: 0; y: 0 }
            PathArc {
                x: parent.width; y: parent.height
                radiusX: parent.width; radiusY: parent.height
                direction: PathArc.Counterclockwise
            }
            PathLine { x: parent.width; y: parent.height }
            PathLine { x: 0; y: parent.height }
        }
    }
}
