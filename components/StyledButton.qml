import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.components
import qs.config
import qs.service

Item {
    id: root
    property bool active: false
    property bool hovered: false
    property bool down: false
    property bool disabled: false
    property alias padding: childWrapper.padding
    property alias leftPadding: childWrapper.leftPadding
    property alias rightPadding: childWrapper.rightPadding
    property alias topPadding: childWrapper.topPadding
    property alias bottomPadding: childWrapper.bottomPadding
    default property alias content: childWrapper.children
    property string idleColor: "transparent"
    property int radius: Config.appearance.radius.small
    property int maxRadius: root.implicitHeight / 2
    property alias topLeftRadius: background.topLeftRadius
    property alias topRightRadius: background.topRightRadius
    property alias bottomLeftRadius: background.bottomLeftRadius
    property alias bottomRightRadius: background.bottomRightRadius
    property string tooltip: "test"

    property string contentColor: disabled ? Colors.palette.m3onSurface
        : root.active ? Colors.palette.m3onPrimary
        : root.down ? Colors.palette.m3onPrimaryContainer
        : Colors.palette.m3onSurface

    signal leftClicked()
    signal rightClicked()
    signal activated()
    signal scrolledUp()
    signal scrolledDown()

    implicitWidth: childWrapper.implicitWidth
    implicitHeight: childWrapper.implicitHeight

    opacity: root.disabled ? 0.4 : 1

    Rectangle {
        id: background
        anchors.fill: parent
        radius: disabled ? root.radius
            : (root.hovered || !root.active) && !root.down ? root.radius : root.maxRadius

        color: disabled ? idleColor
            : root.active ? Colors.palette.m3primary
            : root.down ? Colors.palette.m3surfaceVariant
            : root.hovered ? Colors.palette.m3surfaceVariant
            : idleColor;

        Behavior on color { ColorAnimation { duration: 120 } }
        Behavior on radius { Anim {} }
        Behavior on bottomLeftRadius { Anim {} }
        Behavior on bottomRightRadius { Anim {} }
        Behavior on topLeftRadius { Anim {} }
        Behavior on topRightRadius { Anim {} }
    }

    Flow {
        id: childWrapper
        padding: 0
        anchors.centerIn: parent
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }

    MouseArea {
        hoverEnabled: !root.disabled
        enabled: !root.disabled

        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: root.disabled ? Qt.ArrowCursor : Qt.PointingHandCursor

        onEntered: if (!root.disabled) root.hovered = true
        onExited: if (!root.disabled) root.hovered = false

        onPressed: if (!root.disabled) root.down = true
        onReleased: if (!root.disabled) {
            root.down = false
            root.activated()
        }

        onClicked: (mouse) => {
            if (root.disabled) return
            if (mouse.button === Qt.RightButton)
                root.rightClicked()
            else if (mouse.button === Qt.LeftButton)
                root.leftClicked()
        }

        onWheel: (wheel) => {
            if (root.disabled) return
            if (wheel.angleDelta.y > 0)
                root.scrolledUp()
            else if (wheel.angleDelta.y < 0)
                root.scrolledDown()
        }
    }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.fast
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.easeOut
    }

    ToolTip {
        id: control
        property bool active: root.hovered && root.tooltip.length > 0 && !root.disabled
        visible: false
        text: root.tooltip

        opacity: active ? 1 : 0
        y: active ? 0 : root.height / 2
        Behavior on opacity { NumberAnimation { duration: 200} }
        Behavior on y { NumberAnimation { duration: 200 } }

        contentItem: Text {
            text: control.text
            font: control.font
            color: Colors.palette.m3onSurface
        }

        background: Rectangle {
            color: Colors.palette.m3surface
            radius: Config.appearance.radius.normal
        }
    }
}
