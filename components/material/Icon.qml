pragma ComponentBehavior: Bound
import QtQuick as QQ
import qs.service
import qs.config
import qs.components.common

Text {
    id: root

    property string icon: "indeterminate_question_box"
    property real fill: 0
    property int grade: Colors.isDark ? -25 : 0
    property real truncatedFill: Math.round(fill * 100) / 100
    property int size

    color: Colors.palette.m3onSurface

    font {
        hintingPreference: QQ.Font.PreferFullHinting
        family: Config.appearance.icon.family
        pixelSize: root.size

        variableAxes: ({
            'FILL': truncatedFill,
            'GRAD': grade,
            "wght": fontInfo.weight
        })
    }

    text: icon
}
