
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "root:/config"
import "root:/utils"
import "root:/components"

Rectangle{
    id: root
    color: 'transparent'

    property string current
    anchors.fill: parent

    SwappableImage {
        anchors.fill: parent
        image: root.current
    }

    function apply(data: string) {
        console.log("updating wallpaper. Old: ", root.current)
        const jsonData = JSON.parse(data.trim())
        root.current = jsonData.path
        console.log("New: ", root.current)

        updateColors()
    }

    function updateColors() {
        if (Colors.sourceType == "image") {
            Colors.setWallpaper(root.current)
        }
    }

    // Обновляем палитру, если файл темы изменился
    FileView {
        path: `${Paths.wallpaper}`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.apply(text())
    }

    component Anim: NumberAnimation {
            duration: Appearance.animation.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.animation.curves.ease
    }
}
