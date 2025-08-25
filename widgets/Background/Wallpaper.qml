import QtQuick
import qs.config
import qs.components

Rectangle{
    id: root
    color: 'transparent'

    property string current: Config.wallpaper.source

    anchors.fill: parent

    SwappableImage {
        anchors.fill: parent
        source: root.current
    }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.ease
    }
}
