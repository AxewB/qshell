import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"

Rectangle {
    id: root

    property string image: ""
    property string current: ""
    property string previous: ""

    property var currentImageContainer: one

    color: 'transparent'

    ImageContainer {
        id: one
    }

    ImageContainer {
        id: two
    }

    component ImageContainer: Image {
        id: imageComponent
        anchors.fill: parent
        opacity: root.currentImageContainer === this ? 1 : 0
        scale: root.currentImageContainer === this ? 1.0 : 1.05
        // scale: root.currentImageContainer === this ? 1.0 : 1.2
        source: root.currentImageContainer == this ? root.current : root.previous
        fillMode: Image.PreserveAspectCrop

        Behavior on opacity {Anim{}}
        Behavior on scale {Anim{}}

    }

    function updateImage() {
        root.previous = root.current
        root.current = root.image
        if (wallpaperChangeAnimation.finished) {
            imageScaleAnimation.start()
            wallpaperChangeAnimation.start()
        } else {
            imageScaleAnimation.restart()
            wallpaperChangeAnimation.restart()
        }

        if (root.currentImageContainer == one)
            root.currentImageContainer = two
        else if (root.currentImageContainer == two)
            root.currentImageContainer = one
    }


    MultiEffect {
        id: blurEffect
        source: root
        anchors.fill: root
        autoPaddingEnabled: true
        blurEnabled: true
        blur: 0
        blurMax: 48
        z: 3
    }


    SequentialAnimation {
        id: imageScaleAnimation
        running: false

        ScaleAnimator {
            target: root;
            from: 1;
            to: 1.025;
            duration: Appearance.animation.durations.slow
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }

        ScaleAnimator {
            target: root;
            from: 1.025;
            to: 1;
            duration: Appearance.animation.durations.slow
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }
    }


    SequentialAnimation {
        id: wallpaperChangeAnimation
        running: false

        NumberAnimation {
            target: blurEffect
            properties: "blur"
            from: blurEffect.blur
            to: 0.6
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }

        NumberAnimation {
            target: blurEffect
            properties: "blur"
            from: 0.6
            to: 0
            duration: Appearance.animation.durations.turtle
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.easeOut
        }
    }

    component Anim: NumberAnimation {
         duration: Appearance.animation.durations.slow
         easing.type: Easing.BezierSpline
         easing.bezierCurve: Appearance.animation.curves.ease
    }

    onImageChanged: updateImage()
}
