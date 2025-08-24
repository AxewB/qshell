pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import qs.service
import qs.components
import qs.config

Item {
    id: root
    property list<MprisPlayer> players: MediaService.players
    property MprisPlayer player: MediaService.currentPlayer
    property bool isPlaying: player.isPlaying
    property real progress: MediaService.progress
    property int position: MediaService.position
    property int length: MediaService.length
    property int contentPadding: Config.appearance.padding.enormous

    signal close()

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    HoverHandler { id: hoverHandler }

    WrapperItem {
        id: content
        margin: root.contentPadding / 2

        RowLayout {
            spacing: root.contentPadding / 2
            WrapperItem {
                LeftColumn { }
            }
            WrapperRectangle {
                Layout.fillHeight: true
                margin: root.contentPadding / 2
                color: Colors.palette.m3surfaceContainer
                radius: Config.appearance.radius.normal

                RightColumn {
                    Layout.fillHeight: true
                }
            }
        }
    }

    function focusWindow() {
        const entryName = root.player.desktopEntry?.toLowerCase() ?? ""
        const identity = root.player.identity?.toLowerCase() ?? ""
        Hyprland.refreshToplevels()

        const topLevels = Hyprland.toplevels.values
        const topLevel = topLevels.filter(tl =>{
            if (!tl.workspace) return false
            const tlName = tl.title.toLowerCase()
            const words = [];
            if (entryName) words.push(entryName)
            if (identity) words.push(identity)
            if (words.length === 0) return false

            const value = new RegExp(words.join('|')).test(tlName);
            return value
        } )[0]
        if (topLevel) {
            Hyprland.dispatch(`focuswindow address:0x${topLevel.address}`)
            root.close()
        } else {
            console.log("Window not found")
        }
    }

    function getTime(value) {
        const totalSeconds = Math.floor(value)

        const hours = Math.floor(totalSeconds / 3600)
        const minutes = Math.floor((totalSeconds % 3600) / 60)
        const seconds = totalSeconds % 60

        let result = ""

        if (hours > 0) result += hours.toString().padStart(2, '0') + ":"

        result += minutes.toString().padStart(2, '0') + ":"
        result += seconds.toString().padStart(2, '0')

        return result
    }

    component LeftColumn: WrapperItem {
        RowLayout {
            spacing: root.contentPadding
            Layout.fillHeight: true
            AdditionalControls {}
        }
    }

    component RightColumn: WrapperItem {
        RowLayout {
            spacing: root.contentPadding
            WrapperItem{
                ColumnLayout  {
                    // PlayersMenu { Layout.alignment: Qt.AlignTop }
                    PlayersSwapper { Layout.alignment: Qt.AlignTop }
                    TrackImage { Layout.alignment: Qt.AlignBottom }
                }
            }
            WrapperItem {
                Layout.alignment: Qt.AlignVCenter
                ColumnLayout {
                    spacing: root.contentPadding
                    WrapperItem {
                        Layout.alignment: Qt.AlignHCenter
                        ColumnLayout {
                            spacing: 0
                            StyledText {
                                Layout.alignment: Qt.AlignHCenter
                                type: "h1"
                                text: titleTM.elidedText
                            }
                            StyledText {
                                Layout.alignment: Qt.AlignHCenter
                                opacity: 0.6
                                text: artistTM.elidedText
                            }

                            TextMetrics {
                                id: titleTM
                                font.family: Config.appearance.font.family.sans ?? ""
                                font.pixelSize: Config.appearance.font.size.h1 ?? 0
                                elide: Text.ElideRight
                                elideWidth: 200 * Config.appearance.scale
                                text: MediaService.trackTitle
                            }
                            TextMetrics {
                                id: artistTM
                                font.family: Config.appearance.font.family.sans ?? ""
                                font.pixelSize: Config.appearance.font.size.subtext ?? 0
                                elide: Text.ElideRight
                                elideWidth: 200 * Config.appearance.scale
                                text: MediaService.trackArtist
                            }
                        }
                    }
                    WrapperItem {
                        Layout.fillWidth: true

                        RowLayout {
                            StyledText {
                                Layout.alignment: Qt.AlignVCenter
                                type: "subtext"
                                opacity: 0.6
                                text: root.getTime(root.position)
                            }

                            Progress {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.fillWidth: true
                            }
                            StyledText {
                                visible: root.length < 3600
                                Layout.alignment: Qt.AlignVCenter
                                type: "subtext"
                                opacity: 0.6
                                text: root.getTime(root.length)
                            }
                        }
                    }
                    MainControls {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    }

                }
            }

        }
    }


    component AdditionalControls: WrapperItem {
        WrapperItem {
            ColumnLayout {
                spacing: Config.appearance.padding.large
                ControlButton {
                    disabled: !root.player.shuffleSupported
                    active: root.player.shuffle
                    icon: "shuffle"
                    color: contentColor
                    onLeftClicked: root.player.shuffle = !root.player.shuffle
                }
                ControlButton {
                    disabled: !root.player.loopSupported
                    active: root.player.loopState !== MprisLoopState.None
                    icon: root.player.loopState === MprisLoopState.Track ? "repeat_one" : "repeat"
                    onLeftClicked: MediaService.switchLoopState()
                }
                ControlButton {
                    disabled: !root.player.volumeSupported || !root.player.canControl
                    active: root.player.volume == 0
                    icon: root.player.volume > 0 ? "volume_up" : "volume_off"
                    onScrolledUp: MediaService.shiftVolume(0.05)
                    onScrolledDown: MediaService.shiftVolume(-0.05)
                    onLeftClicked: root.player.volume ? MediaService.shiftVolume(-1) : MediaService.shiftVolume(0.2)
                }
                ControlButton {
                    icon: "speed"
                    onScrolledUp: MediaService.shiftRate("inc")
                    onScrolledDown: MediaService.shiftRate("dec")
                    onLeftClicked: MediaService.resetRate()
                }
            }
        }
    }


    component MainControls: WrapperItem {
        RowLayout {
            spacing: root.contentPadding

            ControlButton {
                disabled: !root.player.canGoPrevious
                icon: "skip_previous"
                onLeftClicked: root.player.previous()
            }
            ControlButton {
                disabled: !root.player.canSeek
                icon: "replay_5"
                onLeftClicked: root.player.seek(-5)
            }
            ControlButton {
                disabled: !root.player.canTogglePlaying
                icon: root.isPlaying ? "pause" : "play_arrow"
                onLeftClicked: root.isPlaying ? root.player.pause() : root.player.play()
            }
            ControlButton {
                disabled: !root.player.canSeek
                icon: "forward_5"
                onLeftClicked: root.player.seek(5)
            }
            ControlButton {
                disabled: !root.player.canGoNext
                icon: "skip_next"
                onLeftClicked: root.player.next()
            }
        }
    }

    component ControlButton: StyledIconButton {
        padding: Config.appearance.padding.normal
        size: Config.appearance.icon.normal
    }

    component Progress: WrapperRectangle {
        color: 'transparent'
        Item {
            id: progressItem
            property real progress: progressMouseArea.pressed ? newProgress : root.progress
            property real newProgress: 0
            property bool looped: root.length > 3600
            MouseArea {
                id: progressMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onPressed: mouse => {
                    progressItem.newProgress = mouse.x / parent.width
                }
                onPositionChanged: mouse => {
                    if (!pressed) return
                    const pos = mouse.x / parent.width
                    progressItem.newProgress = Math.max(0, Math.min(1, pos))
                }
                onReleased: MediaService.setPosition(progressItem.newProgress)
            }
            implicitHeight: MediaPlayerConfig.barHeight

            Rectangle {
                height: parent.height
                width: parent.width
                anchors.right: parent.right
                color: Colors.palette.m3surface
                radius: height / 2
            }
            Rectangle {
                id: progressBar_progressing
                height: parent.height
                width: progressItem.looped ? parent.width : parent.width * progressItem.progress
                color: !breathingAnimation.running ? Colors.palette.m3primary : 'transparent'
                Behavior on color {
                    ColorAnimation {
                        duration: Config.appearance.animation.durations.normal
                    }
                }
                radius: height / 2


                SequentialAnimation {
                    id: breathingAnimation
                    loops: Animation.Infinite
                    running: progressItem.looped

                    ColorAnimation {
                        target: progressBar_progressing;
                        property: "color";
                        from: Colors.palette.m3surface;
                        to: Colors.palette.m3primary;
                        duration: 1200;
                        easing.type: Easing.InOutQuad
                    }
                    ColorAnimation {
                        target: progressBar_progressing;
                        property: "color";
                        from: Colors.palette.m3primary;
                        to: Colors.palette.m3surface;
                        duration: 1200;
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }


    component TrackImage: ClippingWrapperRectangle {
        radius: Config.appearance.radius.normal
        margin: 1

        color: "transparent"
        implicitWidth: 160
        implicitHeight: 160

        Item {
            anchors.fill: parent

            Rectangle {
                anchors.fill: parent
                opacity: 1
                color: Colors.palette.m3surfaceVariant
                Icon {
                    size: Config.appearance.icon.large
                    anchors.centerIn: parent
                    icon: "music_note"
                }
            }

            SwappableImage {
                opacity: root.player.trackArtUrl.length > 0
                Behavior on opacity { Anim {}}
                source: root.player.trackArtUrl
                implicitWidth: 160
                implicitHeight: 160
            }
        }
    }

    component PlayersSwapper: WrapperRectangle  {
        id: menu
        Layout.fillWidth: true
        color: 'transparent'

        RowLayout {
            spacing: 0
            Layout.fillWidth: true

            StyledIconButton {
                icon: "arrow_left"
                size: Config.appearance.icon.small
                radius: Config.appearance.radius.xsmall
                topRightRadius: Config.appearance.radius.xsmall
                bottomRightRadius: Config.appearance.radius.xsmall
                onLeftClicked: MediaService.switchPlayer("prev")
            }
            StyledButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: Config.appearance.radius.xsmall

                onScrolledUp: MediaService.switchPlayer("next")
                onScrolledDown: MediaService.switchPlayer("prev")
                onLeftClicked: root.focusWindow()

                StyledText {
                    text: playerIdentiryTM.elidedText
                }
            }
            TextMetrics {
                id: playerIdentiryTM
                font.family: Config.appearance.font.family.sans ?? ""
                font.pixelSize: Config.appearance.font.size.subtext ?? 0
                elide: Text.ElideRight
                elideWidth: 80 * Config.appearance.scale
                text: root.player.identity
            }
            StyledIconButton {
                icon: "arrow_right"
                size: Config.appearance.icon.small
                radius: Config.appearance.radius.xsmall
                topLeftRadius: Config.appearance.radius.xsmall
                bottomLeftRadius: Config.appearance.radius.xsmall
                onLeftClicked: MediaService.switchPlayer("next")
            }
        }
    }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.easeOutQuad
    }

}
