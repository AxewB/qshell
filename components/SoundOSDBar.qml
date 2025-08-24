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



    WrapperItem{
        id: content
        WrapperRectangle {
            margin: Config.appearance.padding.huge
            color: Colors.palette.m3surface
            radius: Config.appearance.radius.full

            ColumnLayout {
                spacing: Config.appearance.padding.huge
                StyledIconButton {
                    icon: root.icon
                    padding: Config.appearance.padding.normal
                    active: root.active
                    size: Config.appearance.icon.normal
                    onLeftClicked: root.topClicked()
                }
                Item {
                    height: barLength * Config.appearance.scale
                    Layout.fillWidth: true

                    Rectangle {
                        id: progressTrack
                        radius: Config.appearance.radius.full
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
                        radius: Config.appearance.radius.full
                        color: Colors.palette.m3primary
                        Behavior on height {
                            NumberAnimation {
                                duration: Config.appearance.animation.durations.normal
                                easing.type: Easing.BezierSpline
                                easing.bezierCurve: Config.appearance.animation.curves.easeOut
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
                    padding: Config.appearance.padding.normal
                    size: Config.appearance.icon.normal
                    onLeftClicked: root.bottomClicked()
                }
            }
        }
    }
}
