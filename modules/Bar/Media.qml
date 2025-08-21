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
    property int length: MediaService.length
    property bool isPlaying: player.isPlaying

    radius: Appearance.radius.small
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
        margin: Appearance.padding.normal
        implicitWidth: 200 * Appearance.scale

        RowLayout {
            id: layout
            spacing: 0

            CircularProgressBar {
                progress: MediaService.progress
                looped: MediaService.length > 3600 || root.length === 0
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
                        image: MediaService.trackArtUrl
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
                elideWidth: 140 * Appearance.scale
                text: (MediaService.trackArtist ? MediaService.trackArtist + " - " : "") + MediaService.trackTitle
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

    // TODO: Better to create another wrapper that will trigger update of module on changing it's child size/coords
    onImplicitWidthChanged: {
        areaModule.updateDependentPos()
    }

    Behavior on opacity { Anim {} }

    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }

    Component.onCompleted: {
        areaModule.setItem(root)
    }
}
