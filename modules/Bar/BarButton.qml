import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.components
import qs.service
import qs.config

Button {
    id: control

    property bool active: false
    default property alias child: contentItemWrapper.child

    padding: Appearance.padding.small
    text: qsTr("Button")

    contentItem: RowLayout {
        WrapperItem {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            anchors.centerIn: control
            id: contentItemWrapper
        }
    }

    background: Rectangle {
        implicitHeight: control.implicitWidth > control.implicitHeight ? control.implicitWidth : control.implicitHeight
        implicitWidth: implicitHeight
        radius: (control.hovered || !control.active) && !control.down ? Appearance.radius.xsmall : 16

        color: control.down || control.active ? Colors.palette.m3primary
            : control.hovered ? Colors.palette.m3surfaceVariant
            : "transparent"

        Behavior on color { ColorAnimation { duration: 120 } }
        Behavior on radius { Anim {} }
    }

    onActiveChanged: nowActive()

    signal nowActive()

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }
}
