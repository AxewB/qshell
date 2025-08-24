import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.config
import qs.service
import qs.components
import qs.utils

Rectangle {
    id: root
    property var areaModule: FrameWidgetAreaService.modules.mediaPlayer
    property MprisPlayer player: MediaService.currentPlayer
    property int length: MediaService.length
    property bool isPlaying: player.isPlaying

    radius: Config.appearance.radius.small
    color: "transparent"

    visible: opacity > 0
    opacity: MediaService.players?.length > 0 ? 1 : 0
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

    WrapperRectangle {
        id: content
        color: "transparent"
        margin: Config.appearance.padding.normal
        implicitWidth: 200 * Config.appearance.scale

        RowLayout {
            id: layout
            spacing: 0

            CircularProgressBar {
                progress: MediaService.progress
                looped: MediaService.length > 3600 || root.length === 0
                radius: Config.appearance.icon.small / 2

                ClippingWrapperRectangle {
                    radius: Config.appearance.radius.full
                    implicitWidth: (parent.radius - parent.lineWidth) * 2
                    implicitHeight: (parent.radius - parent.lineWidth) * 2
                    x: parent.centerX / 2 - parent.lineWidth / 4
                    y: parent.centerY / 2

                    color: "transparent"
                    z: -1

                    SwappableImage {
                        source: MediaService.trackArtUrl
                        anchors {
                            fill: parent
                            centerIn: parent
                        }
                    }
                }

                Icon {
                    visible: !MediaService.trackArtUrl
                    x: parent.centerX - size / 2
                    y: parent.centerY - size / 2

                    icon: !MediaService.trackArtUrl ? "music_note" : ""
                    size: Config.appearance.icon.xsmall
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
                font.family: Config.appearance.font.family.sans ?? ""
                font.pixelSize: Config.appearance.font.size.normal ?? 0
                elide: Text.ElideRight
                elideWidth: 140 * Config.appearance.scale
                text: MediaService.trackTitle + (MediaService.trackArtist ? " - " + MediaService.trackArtist : "")
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

    Behavior on opacity { Anim {} }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.ease
    }

    Component.onCompleted: {
        areaModule.setItem(root)
    }
}
