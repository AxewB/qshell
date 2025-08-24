pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.service
import qs.config
import qs.utils
import qs.components

StyledText {
    id: root

    property string icon: "indeterminate_question_box"
    property string color: Colors.palette.m3onSurface
    property real fill: 0
    property int grade: Colors.isDark ? -25 : 0

    font.family: Config.appearance.font.family.icons
    font.variableAxes: ({
        'FILL': root.fill,
        'GRAD': root.grade,
        'opsz': fontInfo.pixelSize,
        'wght': fontInfo.weight,
    })

    text: icon
}
