pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Wayland

Singleton {
    id: root

    property bool isRecording: false
    property string outputFile: ""
    property var captureSource: null // будет установлен из UI

    signal screenshotTaken(string path)
    signal recordingStarted(string path)
    signal recordingStopped()

    ScreencopyView {
        id: screenView
        width: sourceSize.width || 1920
        height: sourceSize.height || 1080
        captureSource: root.captureSource
    }

    // ScreencopyView {
    //     id: screenView
    //     captureSource: root.captureSource
    //     paintCursor: true
    //     live: false
    // }

    function takeScreenshot(path) {
        if (!root.captureSource) {
            console.warn("Нет источника для скриншота!")
            return
        }

        if (!screenView.hasContent || screenView.sourceSize.width <= 0 || screenView.sourceSize.height <= 0) {
            console.warn("Источник ещё не готов, откладываем скриншот...")
            // Можно подождать через короткий таймер
            Qt.callLater(() => takeScreenshot(path))
            return
        }

        screenView.captureFrame()
        screenView.grabToImage(function(result) {
            result.saveToFile(path)
            screenshotTaken(path)
        })
    }

    Timer {
        id: recordTimer
        interval: 40 // ~25fps
        repeat: true
        onTriggered: {
            screenView.grabToImage(function(result) {
                console.log("Frame grabbed for video...")
            })
        }
    }

    function startRecording(path) {
        if (!root.captureSource) {
            console.warn("Нет источника для записи!")
            return
        }
        outputFile = path
        screenView.live = true
        recordTimer.start()
        isRecording = true
        recordingStarted(path)
    }

    function stopRecording() {
        recordTimer.stop()
        screenView.live = false
        isRecording = false
        recordingStopped()
    }
}
