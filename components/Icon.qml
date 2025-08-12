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

Item {
    id: root

    property string icon: "indeterminate_question_box"
    property string previous: ""
    property string color: Colors.palette.m3onSurface
    property int margin: 0

    property var currentContainer: one
    property string path: Paths.icons
    property int size: Appearance.icon.small

    implicitHeight: size
    implicitWidth: size

    IconContainer { id: one }
    IconContainer { id: two }

    onIconChanged: {
        const nextContainer = currentContainer === one ? two : one
        currentContainer.scale = 0.5
        currentContainer.opacity = 0

        nextContainer.scale = 1
        nextContainer.opacity = 1

        nextContainer.iconName = root.icon
        currentContainer.iconName = root.previous

        currentContainer = nextContainer

        previous = icon
    }

    component IconContainer: Item {
        property string iconName: ""

        implicitHeight: root.size
        implicitWidth: root.size

        IconImage {
            id: iconImg
            source: `${path}/${iconName}.svg`
            asynchronous: true
            anchors.fill: parent
        }

        MultiEffect {
            anchors.fill: iconImg
            source: iconImg
            colorization: 1
            colorizationColor: root.color
        }

        Behavior on scale { Anim {} }
        Behavior on opacity { Anim {} }
    }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }

    Component.onCompleted: {
        previous = icon
        one.iconName = icon
        two.iconName = icon
    }
}
