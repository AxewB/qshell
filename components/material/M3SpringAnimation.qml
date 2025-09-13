import QtQuick as QQ
import qs.config

QQ.SpringAnimation {
    property string speed: "normal"      // fast | normal | slow
    property string category: "effects"  // spatial | effects

    readonly property real stiffness: Config.appearance.motion.springs[speed][category].stiffness ?? 5.0

    spring: Math.sqrt(stiffness) / 5
    damping: Config.appearance.motion.springs[speed][category].damping
}
