import QtQuick as QQ
import qs.config

QQ.ColorAnimation {
    property string speed: "medium"
    property string curve: "standard"

    duration: Config.appearance.motion.durations[speed] ? Config.appearance.motion.durations[speed][1] ?? 300 : 300
    easing.type: QQ.Easing.BezierSpline
    easing.bezierCurve: Config.appearance.motion.curves[curve].decelerate ?? Config.appearance.motion.curves.linear
}
