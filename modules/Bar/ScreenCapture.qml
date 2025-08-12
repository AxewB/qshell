import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import qs.components
import qs.utils
import qs.config
import qs.service

Item {
    id: root
    property var screen: Quickshell.screens.length > 0 ? Quickshell.screens[0] : null
    property string fileName: Qt.formatDateTime(clock.date, "dd-mm-yyyy_hh-mm-ss") + "_screenshot.png"
    property string savePath: Paths.screenshots

    implicitWidth: screenShotButton.implicitWidth
    implicitHeight: screenShotButton.implicitHeight

    StyledIconButton {
        padding: 4
        id: screenShotButton
        onLeftClicked: root.takeScreenShot()
        size: Appearance.icon.xsmall
        icon: "fit_screen"
    }

    function getCroppedPath() {
        return savePath.replace("file://", "")
    }

    function getPath() {
        return getCroppedPath() + "/" + fileName
    }

    function sendNotification(title, message, icon = "notifications") {
        const notifIcon = Paths.icons + "/" + icon + ".svg"
        notifySendProc.title = title
        notifySendProc.message = message
        notifySendProc.icon = notifIcon
        notifySendProc.startDetached()
    }

    function takeScreenShot() {
        if (!screen) {
            sendNotification("Ошибка скриншота", "Нет доступных экранов для захвата", "broken_image")
            return
        }

        if (!capture.hasContent) {
            sendNotification("Ошибка скриншота", "Экран ещё не готов для захвата", "broken_image")
            return
        }

        const path = getPath()
        capture.captureFrame()

        capture.grabToImage(function(result) {
            if (result.saveToFile(path)) {
                sendNotification("Скриншот сохранён", path, "image")
            } else {
                sendNotification("Ошибка скриншота", "Не удалось сохранить файл", "broken_image")
            }
        })
    }

    // Скрытый компонент, прикреплённый к UI, чтобы grabToImage работал
    ScreencopyView {
        id: capture
        visible: false
        captureSource: root.screen
        paintCursor: true
        live: false
        width: sourceSize.width || 1920
        height: sourceSize.height || 1080
    }


    Process {
        id: notifySendProc
        running: false
        property string title: ""
        property string message: ""
        property string icon: ""
        property int timeout: 4000
        command: [
            "notify-send",
            "-i", icon,
            "-t", timeout.toString(),
            title,
            message
        ]
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
