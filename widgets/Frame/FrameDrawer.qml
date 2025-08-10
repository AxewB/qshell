import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Particles
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.service
import qs.config
import qs.components

WrapperItem {
    id: root

    required property string position
    property bool hoverEnabled: true
    property bool opened: hoverTemp.hovered
    default property alias child: content.child
    property int extraLeftMargin: 0
    property int extraRightMargin: 0
    property int extraTopMargin: 0
    property int extraBottomMargin: 0


    HoverHandler {
        id: hoverTemp
        onHoveredChanged: console.log(hovered)
    }


    WrapperItem {
        id: content

        implicitHeight: (root.opened && child ? child.implicitHeight + topMargin : 0) + bottomMargin + 1 // adding 1 for the border
        implicitWidth: (root.opened && child ? child.implicitWidth + leftMargin : 0) + rightMargin + 1

        topMargin: BorderConfig.thickness + root.extraTopMargin
        bottomMargin: BorderConfig.thickness + root.extraBottomMargin
        rightMargin: BorderConfig.thickness + root.extraRightMargin
        leftMargin: BorderConfig.thickness + root.extraLeftMargin

        // opacity: root.opened && child ? 1 : 0

        Behavior on implicitWidth { Anim {} }
        Behavior on implicitHeight { Anim {} }
        Behavior on opacity { Anim {} }

        component Anim: NumberAnimation {
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }
    }

    Component.onCompleted: {
        if (["left", "top", "bottom"].includes(position)) anchors.left = parent.left
        if (["right", "top", "bottom"].includes(position)) anchors.right = parent.right
        if (["top", "right", "left"].includes(position)) anchors.top = parent.top
        if (["bottom", "right", "left"].includes(position)) anchors.bottom = parent.bottom
    }
}
