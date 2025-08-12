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

// TODO: сделать таймер на то, чтобы плеер не "прыгал" от смены трека, когда ничего в промежутке не играет

StyledRectangle {
    id: root
    property MprisPlayer player: MediaService.player

    property var title: player.trackTitle
    property var isPlaying: player.isPlaying
    property var trackArtist: player.trackArtist

    radius: Appearance.radius.small

    visible: Mpris.players.values.length > 0 ? true : false
    opacity: Mpris.players.values.length > 0 ? 1 : 0
    clip: true


    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: root.player.togglePlaying()

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
                    max: root.player.length
                    progress: root.player.position
                    looped: root.player.length > 100000
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
                            image: root.player.trackArtUrl
                            anchors {
                                fill: parent
                                centerIn: parent
                            }
                        }
                    }

                    Icon {
                        visible: root.player.trackArtUrl.length < 1
                        x: parent.centerX - size / 2
                        y: parent.centerY - size / 2

                        icon: root.player.trackArtUrl.length < 1 ? "music_note" : ""
                        size: Appearance.icon.xsmall
                    }
                }

                // CircleDivider {
                //     color: Colors.palette.m3surfaceBright
                // }

                WrapperItem {
                    RowLayout {
                        spacing: 0

                        WrapperItem {
                            Layout.alignment: Qt.AlignHCenter

                            StyledText {
                                text: trackTitleMetrics.elidedText
                                color: Colors.palette.m3onSurface
                            }
                        }
                    }
                }

                TextMetrics {
                    id: trackTitleMetrics
                    font.family: Appearance.font.family ?? ""
                    font.pixelSize: Appearance?.font.size.normal ?? 0
                    elide: Text.ElideRight
                    elideWidth: 160
                    text: root.title
                }

                TextMetrics {
                    id: trackArtistMetrics
                    font.family: Appearance?.font.family ?? ""
                    font.pixelSize: Appearance?.font.size.normal ?? 0
                    elide: Text.ElideRight
                    elideWidth: 100
                    text: root.trackArtist
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


    Behavior on implicitWidth {
        NumberAnimation {
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.easeOut
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }
    }
    Behavior on visible {
        NumberAnimation {
            duration: Appearance.animation.durations.normal + 50
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
        }
    }
}
