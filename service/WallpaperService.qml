pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.utils
import qs.config
import qs.service

Singleton {
    id: root
    property bool isPreview: Colors.isPreview

    property string wallsDir: `${Paths.pictures}/wallpapers`

    property string previewPath: ""
    property string basePath: Config.wallpaper.path
    property string path: isPreview ? previewPath : basePath


    onIsPreviewChanged: if (isPreview) {
        previewPath = basePath
    }

    Connections {
        target: Colors
        function onSaving() { root.applyPreview() }
    }

    function setWallpaper(newPath) {
        previewPath = newPath
        if (!isPreview) {
            basePath = newPath
            save()
        }
    }

    function applyPreview() {
        basePath = previewPath
        save()
    }

    function save() {
        jsData.path = basePath
        adapter.writeAdapter()
    }

    FileView {
        id: adapter
        path: `${Paths.config}/wallpaper.json`

        onLoaded: {
            root.previewPath = jsData.path
            root.basePath = jsData.path
        }

        JsonAdapter {
            id: jsData
            property string path: ""
        }
    }
}
