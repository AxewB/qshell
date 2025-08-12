pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.service

Item {
    id: root
    required property bool active
    default property alias content: contentItem.data
    property alias margin: contentItem.margin

    x: contentItem.x
    y: contentItem.y
    implicitHeight: contentItem.height
    implicitWidth: contentItem.width

    Behavior on opacity { Anim {} }
    Behavior on y { Anim {} }
    Behavior on x { Anim {} }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }

    WrapperItem {
        id: contentItem
    }

    Rectangle {
        id: background
        anchors.fill: contentItem
        opacity: 1
        color: Colors.palette.m3surface
        radius: Appearance.radius.small
    }

    MultiEffect {
        source: background
        anchors.fill: background
        shadowEnabled: true
        blurMax: 32
        shadowColor: Colors.palette.m3shadow
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root
        onClicked: console.log("hello")
        hoverEnabled: true

        states: [
            State {
                name: 'hovered'
                when: mouseArea.containsMouse

                PropertyChanges {
                    target: focusTimer
                    running: false
                }
            },
            State {
                name: 'notHovered'
                when: !mouseArea.containsMouse

                PropertyChanges {
                    target: focusTimer
                    running: root.active
                }
            }
        ]

        onStateChanged: console.log(state)
    }

    Timer {
        id: focusTimer
        interval: 3000 // 3 secs before closing
        repeat: false
        running: false

        onTriggered: {
            console.log("panel timed out")

            root.timedOut()
            root.closed()
        }
    }

    signal timedOut()
    signal closed()
    signal opened()
}
