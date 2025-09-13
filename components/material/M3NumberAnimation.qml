import QtQuick as QQ
import qs.config

QQ.NumberAnimation {
    property string speed: "medium"      // short | medium | long | xlong
    property string curve: "standard"    // standard | emphasized | legacy | linear

    duration: Config.appearance.motion.durations[speed] ? Config.appearance.motion.durations[speed][1] ?? 300 : 300
    easing.type: QQ.Easing.BezierSpline
    easing.bezierCurve: Config.appearance.motion.curves[curve].decelerate ?? Config.appearance.motion.curves.linear
}
