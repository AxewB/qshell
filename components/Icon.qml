import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"

IconImage {
    id: root

    property string icon: ""
    property string currentIcon: ""

    property string path: Paths.icons
    property int size: 24


    source: `${root.path}/${root.currentIcon}.svg`

    implicitHeight: root.size
    implicitWidth: root.size
    asynchronous: true

    function updateIcon(newIcon: string) {
        iconChangeAnimation.start()
    }

    onIconChanged: updateIcon(root.icon)

    Component.onCompleted: currentIcon = icon

    SequentialAnimation {
        id: iconChangeAnimation
        running: false

        NumberAnimation {
            target: root
            properties: "scale,opacity"
            from: 1
            to: 0.5
            duration: Appearance.animation.durations.fast
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }

        PropertyAction {
            target: root
            property: "currentIcon"
            value: root.icon
        }

        NumberAnimation {
            target: root
            properties: "scale,opacity"
            from: 0.5
            to: 1
            duration: Appearance.animation.durations.fast
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }
    }

    Behavior on implicitHeight { Anim {} }
    Behavior on implicitWidth { Anim {} }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }
}

// IconImage {
//     id: root

//     property string icon: ""
//     property string currentIcon: ""

//     property string path: Paths.icons
//     property int size: 24
//     state: "normal"

//     source: `${root.path}/${root.currentIcon}.svg`

//     implicitHeight: root.size
//     implicitWidth: root.size
//     asynchronous: true

//     function updateIcon(newIcon: string) {
//         root.state = "swap"
//         Qt.callLater(() => {
//             root.currentIcon = newIcon
//             root.state = "normal"
//         })
//     }

//     onIconChanged: updateIcon(root.icon)

//     Component.onCompleted: updateIcon(root.icon)

//     states: [
//         State {
//             name: "swap"
//             PropertyChanges {
//                 target: root
//                 scale: 0.5
//                 opacity: 0
//             }
//         },
//         State {
//             name: "normal"
//             PropertyChanges {
//                 target: root
//                 scale: 1
//                 opacity: 1
//             }
//         }
//     ]

//     transitions: [
//         Transition {
//             from: "normal";
//             to: "swap"
//             Anim {}
//         },
//         Transition {
//             from: "swap";
//             to: "normal"
//             Anim {}
//         }
//     ]

//     Behavior on scale { Anim {} }
//     Behavior on opacity { Anim {} }
//     Behavior on implicitHeight { Anim {} }
//     Behavior on implicitWidth { Anim {} }

//     component Anim: NumberAnimation {
//         duration: Appearance.animation.durations.normal
//         easing.type: Easing.BezierSpline
//         easing.bezierCurve: Appearance.animation.curves.ease
//     }
// }
