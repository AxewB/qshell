import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import qs.components
import qs.service
import qs.config

Item {
   	id: root
    property string icon: ""
    property real barLength: 200
    property real min: 0
    property real max: 1
    property real progress: 0
    property bool active: false

    signal topClicked()
    signal bottomClicked()
    signal wheelUp()
    signal wheelDown()

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth


    MultiEffect {
        id: shadowEffect
        source: content
        anchors.fill: content
        shadowEnabled: true
        blurMax: Appearance.padding.large
        shadowColor: Colors.palette.m3shadow
    }

    WrapperItem{
        id: content
        margin: shadowEffect.blurMax * 2
        WrapperRectangle {
            margin: Appearance.padding.huge
            color: Colors.palette.m3surface
            radius: Appearance.radius.full

            ColumnLayout {
                spacing: Appearance.padding.huge
                StyledIconButton {
                    icon: root.icon
                    padding: Appearance.padding.normal
                    active: root.active
                    size: Appearance.icon.normal
                    onLeftClicked: root.topClicked()
                }
                Item {
                    height: barLength * Appearance.scale
                    Layout.fillWidth: true

                    Rectangle {
                        id: progressTrack
                        radius: Appearance.radius.full
                        height: parent.height - progressBar.width
                        width: 4
                        anchors.centerIn: parent
                        color: Colors.palette.m3primaryContainer
                    }

                    Rectangle {
                        id: progressBar
                        width: parent.width
                        height: Math.max(parent.height * root.progress, width)
                        // anchors.bottom: parent.bottom
                        anchors.verticalCenter: parent.verticalCenter
                        radius: Appearance.radius.full
                        color: Colors.palette.m3primary
                        Behavior on height {
                            NumberAnimation {
                                duration: Appearance.animation.durations.normal
                                easing.type: Easing.BezierSpline
                                easing.bezierCurve: Appearance.animation.curves.easeOut
                            }
                        }

                        StyledText {
                            anchors.centerIn: parent
                            type: "subtext"
                            text: Math.round(root.progress * 100)
                            color: Colors.palette.m3onPrimary
                            opacity: 0.6
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onWheel: (wheel) => {
                                if (wheel.angleDelta.y > 0) {
                                    root.wheelUp()
                                } else if (wheel.angleDelta.y < 0) {
                                    root.wheelDown()
                                }
                            }
                        }
                    }
                }
                StyledIconButton {
                    icon: "more_horiz"
                    padding: Appearance.padding.normal
                    size: Appearance.icon.normal
                    onLeftClicked: root.bottomClicked()
                }
            }
        }
    }
}
