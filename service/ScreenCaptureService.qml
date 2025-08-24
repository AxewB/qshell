pragma Singleton
import QtQuick
import Quickshell.Io
import Quickshell
import qs.utils

Singleton {
    id: root

    // --- настройки ---
    property string savePath: Paths.screenshots
    property string fileName: Qt.formatDateTime(clock.date, "dd-MM-yyyy_hh-mm-ss") + "_screenshot.png"

    property bool freeze: false
    property bool clipboardOnly: false
    property string currentMode: ""

    signal captureStarted(string mode)
    signal captureFinished(string mode, bool success, string path)

    function captureAll()     { capture("all") }
    function captureOutput()  { capture("output") }
    function captureWindow()  { capture("window") }
    function captureRegion()  { capture("region") }

    function capture(mode) {
        var args = []
        var path = ""

        switch(mode) {
        case "all":
            args = ["-m", "output"] // hyprshot сам возьмёт все мониторы
            break
        case "output":
            args = ["-m", "output"]
            break
        case "window":
            args = ["-m", "window"]
            break
        case "region":
            args = ["-m", "region"]
            break
        }

        if (freeze)
            args.push("-z")

        if (clipboardOnly) {
            args.push("--clipboard-only")
        } else {
            path = root.savePath.replace("file://", "")
            args.push("-o", path)
            args.push("-f", root.fileName)
        }

        currentMode = mode
        console.log("[ScreenCaptureService] run:", ["hyprshot"].concat(args).join(" "))

        hyprshotProc.command = ["hyprshot"].concat(args)
        hyprshotProc.running = true
        root.captureStarted(mode)
    }

    Process {
        id: hyprshotProc
        running: false

        onStarted: {
            console.log("[ScreenCaptureService] started:", command)
        }

        onExited: (exitCode, exitStatus) => {
            const ok = (exitCode === 0)
            const fullPath = clipboardOnly ? "" : savePath + "/" + fileName
            root.captureFinished(currentMode, ok, fullPath)
        }
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
