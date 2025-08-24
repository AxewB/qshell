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

Item {
    id: root
    property Position position: Position {}
    property bool active: false
    property int arcSize: active ? 32 : 0
    property int radius: Config.appearance.radius.normal
    property string color: Colors.palette.m3surface
    default property alias child: childWrapper.data

    signal hide()
    signal show()

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Behavior on scale { Anim {} }
    Behavior on arcSize { Anim {} }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.easeOutQuad
    }

    component Position: QtObject {
        property bool top: false
        property bool right: false
        property bool bottom: false
        property bool left: false
    }



    Rectangle {
        id: content

        implicitHeight: childWrapper.implicitHeight // Middle TOP, BOTTOM and also CORNERS
        implicitWidth: childWrapper.implicitWidth // Middle LEFT and RIGHT

        topLeftRadius: (position.right || position.bottom) && !position.top && !position.left ? root.radius : 0
        topRightRadius: (position.left || position.bottom) && !position.top && !position.right ? root.radius : 0
        bottomLeftRadius: (position.right || position.top) && !position.bottom && !position.left ? root.radius : 0
        bottomRightRadius: (position.left || position.top) && !position.bottom && !position.right ? root.radius : 0

        color: root.color

        // changing only for LEFT and RIGHT sides
        x: if (active) return 0
            else if (position.left && (!position.top && !position.bottom)) return -implicitWidth
            else if (position.right && (!position.top && !position.bottom)) return implicitWidth
            else return 0

        // changing only for TOP and BOTTOM sides (with corners)
        y: if (active) return 0
            else if (position.top) return -implicitHeight
            else if (position.bottom) return implicitHeight
            else return 0

        Behavior on x { Anim {} }
        Behavior on y { Anim {} }
        Behavior on implicitWidth { Anim {} }
        Behavior on implicitHeight { Anim {} }

        clip: true

        HoverHandler {
            id: hoverHandler
            onHoveredChanged: {
                if (!hovered) root.hide()
                else root.show()
            }
        }

        WrapperItem {
            id: childWrapper
        }
    }

    Rectangle {
        id: primary
        color: "transparent"
        height: content.implicitHeight > root.arcSize && content.implicitWidth > root.arcSize ? root.arcSize : 0
        width: height
        y: position.top ? 0
            : position.bottom ? root.height - height
            : -height

        // subtracted 1 because, i guess, it rounds to lower value and because of that creates gap between arc and content
        x: position.top || position.bottom ? (position.right ? -width : root.width - 1 )
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
        height: content.implicitHeight > root.arcSize && content.implicitWidth > root.arcSize ? root.arcSize : 0
        width: height
        y: position.bottom ? (position.right || position.left ? -height : root.height - height)
            : position.top ? (position.right || position.left ? root.height : 0)
            : root.height

        x: position.right ? root.width - width
            : position.left ? 0
            : -width + 1 // added 1 to get rid of unnecessary gap because of the same thing as on primary rectangle

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
