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
    property int maxRadius: root.implicitHeight / 2
    property int leftTopRadius
    property alias topLeftRadius: background.topLeftRadius
    property alias topRightRadius: background.topRightRadius
    property alias bottomLeftRadius: background.bottomLeftRadius
    property alias bottomRightRadius: background.bottomRightRadius
    property string tooltip: "test"
    property string contentColor: root.down ? Colors.palette.m3onPrimaryContainer
        : root.active ? Colors.palette.m3onPrimary
        : Colors.palette.m3onSurface

    signal leftClicked()
    signal rightClicked()
    signal activated()

    implicitWidth: childWrapper.implicitWidth
    implicitHeight: childWrapper.implicitHeight

    Rectangle {
        id: background
        anchors.fill: parent
        radius: (root.hovered || !root.active) && !root.down ? root.radius : root.maxRadius
        color: root.down ? Colors.palette.m3surfaceVariant
            : root.active ? Colors.palette.m3primary
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

        onClicked: (mouse) => {
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

    component ToolTipSettings: QtObject {
        property int delay: 150
        property string text: "test"
        property bool visible: true
    }

    // Item {
    //     id: tooltipWrapper
    //     property bool active: root.hovered && (root.tooltip.visible || root.tooltip.text.length > 0)
    //     anchors.fill: parent

    //     ToolTip {
    //         id: control
    //         visible: opacity > 0   // тултип видим только пока не полностью исчез
    //         text: root.tooltip.text
    //         delay: root.tooltip.delay

    //         // начальные значения
    //         opacity: active ? 1 : 0
    //         y: active ? 0 : 10

    //         Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
    //         Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

    //         contentItem: StyledText { text: control.text }

    //         background: Rectangle {
    //             color: Colors.palette.m3surface
    //             radius: Appearance.radius.normal
    //         }
    //     }
    // }

    ToolTip {
        id: control
        property bool active: root.hovered && root.tooltip.length > 0
        // visible: opacity > 0
        visible: false
        text: root.tooltip

        // начальные значения
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
            radius: Appearance.radius.normal
        }
    }
}
