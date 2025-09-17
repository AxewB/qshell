import QtQuick
import QtQuick.Layouts
import Qt.labs.animation
import qs.config
import qs.service

Item {
    id: root
    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true

        property int pressedButton: -1
        property real pressX: 0

        cursorShape: pressedButton === Qt.LeftButton || pressedButton === Qt.RightButton ? Qt.ClosedHandCursor : Qt.OpenHandCursor

        onPressed: (mouse) => {
            pressedButton = mouse.button
            pressX = mouse.x
        }

        onPositionChanged: (mouse) => {
            if (pressedButton !== -1) {
                content.x = mouse.x - pressX
            }
        }

        onReleased: (mouse) => {
            if (pressedButton === Qt.LeftButton) {
                const player = MediaService.currentPlayer
                if (player) {
                    if (content.x > xbr.minimumOvershoot / 2 && player.canGoPrevious)
                        player.previous()
                    else if (content.x < -xbr.maximumOvershoot / 2 && player.canGoNext)
                        player.next()
                }
            } else if (pressedButton === Qt.RightButton) {
                if (content.x > xbr.minimumOvershoot / 2)
                    MediaService.switchPlayer("prev")
                else if (content.x < -xbr.maximumOvershoot / 2)
                    MediaService.switchPlayer("next")
            }

            xbr.returnToBounds()
            pressedButton = -1
        }

        onCanceled: {
            pressedButton = -1
            xbr.returnToBounds()
        }
    }

    RowLayout {
        id: content
        spacing: Config.appearance.padding.huge

        // TODO: add here loading indicator when track info switching (bind to timer in media service)
        TrackInfo {}
        PlayerProgress {}

        BoundaryRule on x {
            id: xbr
            minimum: -0
            maximum: 0
            minimumOvershoot: 4
            maximumOvershoot: 4
            overshootScale: 0.05       // регулирует сопротивление после барьера
            returnDuration: 250
            easing: BoundaryRule.OutQuad
        }
    }
}
