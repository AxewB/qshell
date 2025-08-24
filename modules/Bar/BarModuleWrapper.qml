import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.service
import qs.config

WrapperMouseArea {
    id: root
    default property alias child: childPlacer.data
    property alias hovered: hoverHandler.hovered
    property bool clickable: false
    property int radius: Config.appearance.radius.small
    property string color: hoverHandler.hovered && clickable ? Colors.palette.m3surfaceBright : Colors.palette.m3surfaceContainer

    WrapperRectangle {
        color: root.color
        radius: root.radius
        leftMargin: Config.appearance.padding.normal
        rightMargin: Config.appearance.padding.normal
        RowLayout {
            id: childPlacer
            spacing: Config.appearance.padding.normal
        }
    }

    HoverHandler { id: hoverHandler }


    Behavior on color {ColorAnimation {duration: 150}}
    Behavior on implicitHeight { Anim {} }
    Behavior on leftMargin { Anim {} }
    Behavior on rightMargin { Anim {} }
    Behavior on implicitWidth { Anim {} }
    Behavior on scale { Anim {} }
    Behavior on opacity { Anim {} }
    Behavior on x { Anim {} }
    Behavior on y { Anim {} }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.fast
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.ease
    }
}
