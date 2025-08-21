import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Mpris
import "root:/utils"
import "root:/service"
import "root:/components"

Rectangle {
    id: root
    property var areaModule: FrameWidgetAreaService.modules.mediaPlayer
    property MprisPlayer player: MediaService.currentPlayer
    property string trackArtUrl: player.trackArtUrl
    property string trackTitle: MediaService.trackTitle
    property int length: MediaService.length
    property bool isPlaying: player.isPlaying

    radius: Appearance.radius.small
    color: "transparent"

    visible: Mpris.players.values.length > 0 ? true : false
    opacity: Mpris.players.values.length > 0 ? 1 : 0
    clip: true

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: FrameWidgetAreaService.modules.mediaPlayer.open()
        onExited: FrameWidgetAreaService.modules.mediaPlayer.closeByTimer()

        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) {
                MediaService.switchPlayer("next")
            } else if (wheel.angleDelta.y < 0) {
                MediaService.switchPlayer("prev")
            }
        }
    }

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Flow {
        padding: Appearance.padding.normal
        id: content

        Rectangle {
            implicitHeight: layout.implicitHeight
            implicitWidth: layout.implicitWidth
            color: "transparent"

            RowLayout {
                id: layout
                spacing: Appearance.padding.huge


                CircularProgressBar {
                    min: 0
                    max: root.length
                    progress: root.player.position
                    looped: root.length > 100000
                    radius: Appearance.icon.small / 2

                    ClippingWrapperRectangle {
                        radius: Appearance.radius.full
                        implicitWidth: (parent.radius - parent.lineWidth) * 2
                        implicitHeight: (parent.radius - parent.lineWidth) * 2
                        x: parent.centerX / 2 - parent.lineWidth / 4
                        y: parent.centerY / 2

                        color: "transparent"
                        z: -1

                        SwappableImage {
                            image: root.trackArtUrl
                            anchors {
                                fill: parent
                                centerIn: parent
                            }
                        }
                    }

                    Icon {
                        visible: root.trackArtUrl.length < 1
                        x: parent.centerX - size / 2
                        y: parent.centerY - size / 2

                        icon: root.trackArtUrl.length < 1 ? "music_note" : ""
                        size: Appearance.icon.xsmall
                    }
                }

                WrapperItem {
                    Layout.alignment: Qt.AlignHCenter

                    StyledText {
                        text: trackTitleMetrics.elidedText
                        color: Colors.palette.m3onSurface
                    }
                }

                TextMetrics {
                    id: trackTitleMetrics
                    font.family: Appearance.font.family ?? ""
                    font.pixelSize: Appearance?.font.size.normal ?? 0
                    elide: Text.ElideRight
                    elideWidth: 160
                    text: root.trackTitle
                }
            }
        }
    }

    Timer {
        running: player.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: {
            root.player.positionChanged()
        }
    }


    // Behavior on implicitWidth {
    //     NumberAnimation {
    //         duration: Appearance.animation.durations.normal
    //         easing.type: Easing.BezierSpline
    //         easing.bezierCurve: Appearance.animation.curves.easeOutQuad
    //     }
    // }

    // Behavior on opacity {
    //     NumberAnimation {
    //         duration: Appearance.animation.durations.normal
    //         easing.type: Easing.BezierSpline
    //         easing.bezierCurve: Appearance.animation.curves.ease
    //     }
    // }
    // Behavior on visible {
    //     NumberAnimation {
    //         duration: Appearance.animation.durations.normal + 50
    //         easing.type: Easing.BezierSpline
    //         easing.bezierCurve: Appearance.animation.curves.ease
    //     }
    // }


    // TODO: Better to create another wrapper that will trigger update of module on changing it's child size/coords
    onImplicitWidthChanged: {
        areaModule.updateDependentPos()
    }


    Component.onCompleted: {
        areaModule.setItem(root)
    }
}
