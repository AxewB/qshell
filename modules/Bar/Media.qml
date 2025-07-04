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

StyledRectangle {
    id: root
    property var player: Mpris.players.values[0]

    property var title: Mpris.players.values[0].trackTitle
    property var isPlaying: player.isPlaying
    property var trackArtist: Mpris.players.values[0].trackArtist

    color: Colors.palette.m3surfaceContainer
    clip: true

    radius: Appearance.radius.small

    visible: Mpris.players.values.length > 0 ? true : false
    opacity: Mpris.players.values.length > 0 ? 1 : 0

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

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        states: State {
            name: 'hovered'
            when: mouseArea.containsMouse

            PropertyChanges {
                target: trackArtistMetrics
                elideWidth: 180
            }
            PropertyChanges {
                target: trackTitleMetrics
                elideWidth: 180
            }
            PropertyChanges {
                target: root
                color: Colors.palette.m3surfaceBright
            }
        }

        onClicked: root.player.togglePlaying()
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

                ClippingWrapperRectangle {
                    radius: Appearance.radius.small
                    implicitWidth: Appearance.icon.normal
                    implicitHeight: Appearance.icon.small
                    Layout.alignment: Qt.AlignCenter
                    color: "transparent"

                    SwappableImage {
                        image: root.player.trackArtUrl
                        anchors {
                            fill: parent
                            centerIn: parent
                        }
                    }
                }

                Rectangle {
                    implicitWidth: Appearance.padding.normal
                    implicitHeight: Appearance.padding.normal

                    color: 'transparent'
                    Rectangle {
                        implicitHeight: 4
                        implicitWidth: 4
                        anchors.centerIn: parent
                        radius: Appearance.radius.full
                        color: Colors.palette.m3surfaceBright
                    }
                }

                WrapperItem {
                    RowLayout {
                        spacing: 0
                        StyledText {
                            text: trackTitleMetrics.elidedText
                            color: Colors.palette.m3onSurface
                        }

                        StyledText {
                            text: " — "
                            visible: root.trackArtist.length > 0 && root.title.length > 0
                            color: Colors.palette.m3onSurface
                        }

                        StyledText {
                            text: trackArtistMetrics.elidedText
                            color: Colors.palette.m3onSurface
                        }
                    }
                }

                TextMetrics {
                    id: trackTitleMetrics
                    font.family: Appearance.font.family
                    font.pixelSize: Appearance.font.size.normal
                    elide: Text.ElideRight
                    elideWidth: 100
                    text: root.title
                }

                TextMetrics {
                    id: trackArtistMetrics
                    font.family: Appearance.font.family
                    font.pixelSize: Appearance.font.size.normal
                    elide: Text.ElideRight
                    elideWidth: 100
                    text: root.trackArtist
                }
            }
        }
    }
}
