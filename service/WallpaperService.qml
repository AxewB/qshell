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


    onBasePathChanged: console.log("basePath: ", basePath)
    onPreviewPathChanged: console.log("previewPath: ", previewPath)
    onPathChanged: console.log("path: ", path)
    onIsPreviewChanged: if (isPreview) {
        console.log('preview enabled')
        previewPath = basePath
    }

    Connections {
        target: Colors
        function onSaving() { root.save() }
    }

    function setWallpaper(newPath) {
        // console.log("newPaht", newPath)
        if (isPreview) {
            previewPath = newPath
        }
        else {
            basePath = newPath
        }
        // console.log("path after setting", path)
    }

    function save() {
        // console.log("---")
        // console.log("previewPath: ",path)
        // console.log("basePath: ",path)
        // console.log("path: ",path)
        basePath = previewPath
        jsData.path = previewPath
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
