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
    property int maxShortTitleLength: 16
    property int maxTitleLength: 48
    property string displayTitle
    property string shortDisplayTitle

    color: Colors.palette.m3surfaceContainer
    clip: true

    radius: Appearance.radius.small
    onTitleChanged: updateDisplayTitle()
    onTrackArtistChanged: updateDisplayTitle()

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
                target: titleText
                text: root.displayTitle
            }
            PropertyChanges {
                target: root
                color: Colors.palette.m3surfaceBright
            }
        }

        onClicked: root.player.togglePlaying()
    }

    function updateDisplayTitle() {
        const trackArtist = root.player.trackArtist
        const trackTitle = root.player.trackTitle
        const titleAndArtistExtists = trackTitle.length > 0 && trackArtist.length > 0

        let newTitle = ""
        if (root.player == null || !titleAndArtistExtists) {
            newTitle = "Nothing playing"
        } else {
            newTitle = `${root.player.trackTitle} ${titleAndArtistExtists ? "-" : ""} ${root.player.trackArtist}`
        }

        if (newTitle.length > maxShortTitleLength + 3)
            root.shortDisplayTitle = newTitle.slice(0, maxShortTitleLength) + "..."
        else
            root.shortDisplayTitle = newTitle

        if (newTitle.length > maxTitleLength + 3)
            root.displayTitle = newTitle.slice(0, maxTitleLength) + "..."
        else
            root.displayTitle = newTitle
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

                Rectangle {
                    implicitWidth: titleText.implicitWidth
                    implicitHeight: titleText.implicitHeight
                    color: "transparent"

                    StyledText {
                        id: titleText
                        color: Colors.palette.m3onSurface
                        text: root.shortDisplayTitle
                    }
                }
            }
        }
    }
}
