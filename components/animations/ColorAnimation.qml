import QtQuick

ColorAnimation {
  duration: 250
  easing.type: Easing.BezierSpline
  // easing.bezierCurve: Config.appearance.motion.curves[curve].decelerate ?? Config.appearance.motion.curves.linear
}
