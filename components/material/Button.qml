import QtQuick.Controls as Controls
import QtQuick.Layouts as Layouts
import QtQuick as QQ
import QtQuick.Effects as Effects
import qs.components.common
import qs.service


Controls.Button {
    id: root
    text: qsTr("Button")
    focusPolicy: Qt.TabFocus
    clip: true

    default property alias content: layout.children
    property bool showOnlyIcon: false

    property string prependIcon: ""
    property string appendIcon: ""
    property int iconSize: {
        if (size === "xsmall") return 20
        if (size === "medium") return 24
        if (size === "large") return 32
        if (size === "xlarge") return 40
        return 20
    }

    property string type: "filled" // elevated | filled | tonal | outlined | text
    property string size: "small"  // xsmall | small | medium | large | xlarge
    property string shape: "round" // round | square
    property bool smallPadding: false

    property bool togglable: false
    property bool selected: false

    property string containerColor: {
        if (!enabled) return Colors.palette.m3onSurface

        if (togglable) {
            if (selected) {
                if (type === "elevated") { return Colors.palette.m3primary }
                if (type === "tonal") { return Colors.palette.m3secondary }
                if (type === "outlined") { return Colors.palette.m3inverseSurface }
                if (type === "text") { return "transparent" }

                return Colors.palette.m3primary // filled
            } else {
                if (type === "elevated") { return Colors.palette.m3surfaceContainerLow }
                if (type === "tonal") { return Colors.palette.m3secondaryContainer }
                if (type === "outlined") { return "transparent" }
                if (type === "text") { return "transparent" }

                return Colors.palette.m3surfaceContainerLow // filled
            }
        }

        if (type === "elevated") { return Colors.palette.m3surfaceContainerLow }
        if (type === "tonal") { return Colors.palette.m3secondaryContainer }
        if (type === "outlined") { return "transparent" }
        if (type === "text") { return "transparent" }
        return Colors.palette.m3primary // filled
    }
    property string labelColor: {
        if (!enabled) return Colors.palette.m3onSurface


        if (togglable) {
            if (selected) {
                if (type === "elevated") { return Colors.palette.m3onPrimary }
                if (type === "tonal") { return Colors.palette.m3onSecondary }
                if (type === "outlined") { return Colors.palette.m3inverseOnSurface }
                if (type === "text") { return Colors.palette.m3primary }
                return Colors.palette.m3onPrimary // filled
            } else {
                if (type === "elevated") { return Colors.palette.m3primary }
                if (type === "tonal") { return Colors.palette.m3onSecondaryContainer }
                if (type === "outlined") { return Colors.palette.m3onSurfaceVariant }
                if (type === "text") { return Colors.palette.m3primary }
                return Colors.palette.m3onSurface // filled
            }
        }

        if (type === "elevated") { return Colors.palette.m3primary }
        if (type === "tonal") { return Colors.palette.m3onSecondaryContainer }
        if (type === "outlined") { return Colors.palette.m3onSurfaceVariant }
        if (type === "text") { return Colors.palette.m3primary }
        return Colors.palette.m3onPrimary // filled
    }
    property string stateLayerColor: labelColor // repeats label color in docs



    property real containerOpacity: {
        if (!enabled) return 0.1;
        return 1
    }
    property real stateLayerOpacity: {
        if (!enabled) return 0
        if (hovered) return 0.08;
        if (down || focus) return 0.1
        return 0
    }
    property real labelOpacity: {
        if (!enabled) return 0.38;
        return 1
    }

    leftPadding: {
        if (size === "xsmall") return 12;
        if (size === "medium") return 24;
        if (size === "large") return 48;
        if (size === "xlarge") return 64;
        return 16
    }
    rightPadding: leftPadding

    // default return value is for `small` button size
    property string layoutSpacing: {
        if (size === "xsmall") return 4;
        if (size === "medium") return 8;
        if (size === "large") return 12;
        if (size === "xlarge") return 16;
        return 8
    }

    property int inactiveRadius: {
        if (shape === "square") {
            if (size === "xsmall") return 12;
            if (size === "medium") return 16;
            if (size === "large") return 28;
            if (size === "xlarge") return 28;
            return 12
        }
        else return height / 2
    }

    property int activeRadius: {
        if (size === "xsmall") return 8;
        if (size === "medium") return 12;
        if (size === "large") return 16;
        if (size === "xlarge") return 16;
        return 8
    }

    property int outlineWidth: {
        if (size === "xsmall") return 1;
        if (size === "medium") return 1;
        if (size === "large") return 2;
        if (size === "xlarge") return 3;
        return 1
    }
    property int contentHeight: {
        if (size === "xsmall") return 32;
        if (size === "medium") return 56;
        if (size === "large")  return 96;
        if (size === "xlarge") return 136;
        return 40
    }

    QQ.Behavior on labelColor { CAnim {} }
    QQ.Behavior on containerColor { CAnim {} }
    QQ.Behavior on stateLayerColor { CAnim {} }
    QQ.Behavior on stateLayerOpacity { EffectAnim {} }

    contentItem: QQ.Item {
        anchors.centerIn: parent
        implicitWidth: layout.implicitWidth
        implicitHeight: root.contentHeight
        QQ.Behavior on implicitWidth { ExprAnim {} }
        QQ.Behavior on implicitHeight { ExprAnim {} }

        Layouts.RowLayout {
            id: layout
            anchors.centerIn: parent
            spacing: root.layoutSpacing
            opacity: root.labelOpacity
            Icon {
                visible: root.prependIcon
                icon: root.prependIcon
                color: root.labelColor
                size: root.iconSize
            }

            Text {
                text: root.text
                color: root.labelColor
                centered: true
                visible: !root.showOnlyIcon && root.text.length > 0
                type: {
                    if (root.size === "xsmall") return "body";
                    if (root.size === "medium") return "title";
                    if (root.size === "large") return "headline";
                    if (root.size === "xlarge") return "headline";
                    return "body"
                }
                size: {
                    if (root.size === "xsmall") return "medium";
                    if (root.size === "medium") return "medium";
                    if (root.size === "large") return "small";
                    if (root.size === "xlarge") return "large";
                    return "medium"
                }
            }

            Icon {
                visible: root.appendIcon && !root.showOnlyIcon
                icon: root.appendIcon
                color: root.labelColor
                size: root.iconSize
            }
        }
    }

    background: QQ.Rectangle {
        id: container
        color: root.containerColor
        radius: root.down ? root.activeRadius : root.inactiveRadius
        opacity: root.containerOpacity

        border {
            color: root.type === "outlined" ? Colors.palette.m3outlineVariant : "transparent"
            width: root.type === "outlined" ? root.outlineWidth : 0
        }

        QQ.Behavior on radius { ExprAnim {} }

        QQ.Rectangle {
            id: stateLayer
            anchors.fill: parent
            opacity: root.stateLayerOpacity
            color: root.stateLayerColor
            radius: parent.radius
        }

        layer.enabled: root.type === "elevated"
        layer.effect: ElevationEffect {
            target: root
            level: 1
            z: -2
        }
    }

    component ExprAnim: M3SpringAnimation {
        speed: "fast"
        category: "spatial"
    }
    component CAnim: M3ColorAnimation { speed: "short" }
    component EffectAnim: M3NumberAnimation { speed: "short" }
}
