pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/config"
import "root:/utils"
import "root:/components"

Item {
    id: root

    property string icon: ""
    property string previous: ""
    property string color: Colors.palette.m3onSurface

    property var currentContainer: one
    property string path: Paths.icons
    property int size: Appearance.icon.normal

    implicitHeight: size
    implicitWidth: size

    IconContainer { id: one }
    IconContainer { id: two }

    ColorizeEffect {source: one}
    ColorizeEffect {source: two}

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

    component IconContainer: IconImage {
        property string iconName: ""

        source: `${path}/${iconName}.svg`
        implicitHeight: root.size
        implicitWidth: root.size
        asynchronous: true

        Behavior on scale { Anim {} }
        Behavior on opacity { Anim {} }
        Behavior on implicitHeight { Anim {} }
        Behavior on implicitWidth { Anim {} }
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

    component ColorizeEffect: MultiEffect {
        anchors.fill: source
        colorization: 1
        colorizationColor: root.color
    }
}
