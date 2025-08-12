import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.components
import qs.service
import qs.config


Item {
    id: root
    property bool active: false
    property bool hovered: false
    property bool down: false
    property alias padding: childWrapper.padding
    property alias leftPadding: childWrapper.leftPadding
    property alias rightPadding: childWrapper.rightPadding
    property alias topPadding: childWrapper.topPadding
    property alias bottomPadding: childWrapper.bottomPadding
    default property alias content: childWrapper.children
    property string idleColor: "transparent"

    property int radius: Appearance.radius.small

    signal leftClicked()
    signal rightClicked()
    signal activated()

    implicitWidth: childWrapper.implicitWidth
    implicitHeight: childWrapper.implicitHeight

    Rectangle {
        id: background
        anchors.fill: parent
        radius: (root.hovered || !root.active) && !root.down ? root.radius : root.implicitHeight / 2
        color: root.down ? Colors.palette.m3surfaceVariant
            : root.active ? Colors.palette.m3primary
            : root.hovered ? Colors.palette.m3surfaceVariant
            : idleColor

        Behavior on color { ColorAnimation { duration: 120 } }
        Behavior on radius { Anim {} }
    }

    Flow {
        id: childWrapper
        padding: root.padding
        anchors.centerIn: parent
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: root.hovered = true
        onExited: root.hovered = false

        onPressed: {
            root.down = true
        }
        onReleased: {
            root.down = false
            root.activated()
        }

        onClicked: {
            if (mouse.button === Qt.RightButton)
                root.rightClicked()
            else if (mouse.button === Qt.LeftButton)
                root.leftClicked()
        }
    }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.fast
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.easeOut
    }
}
