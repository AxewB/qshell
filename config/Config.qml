pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.utils

Singleton {
    property alias appearance: adapter.appearance
    property alias borders: adapter.borders
    property alias fakeRounding: adapter.fakeRounding
    property alias weather: adapter.weather
    property alias wallpaper: adapter.wallpaper

    // /home/axewb/Pictures/wallpapers/Catppuccin Mocha/cat_leaves.png
    FileView {
        id: fileView
        path: `${Paths.config}/shell.json`
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()


        JsonAdapter {
            id: adapter

            property AppearanceConfig appearance: AppearanceConfig {}
            property BorderConfig borders: BorderConfig {}
            property FakeRoundingConfig fakeRounding: FakeRoundingConfig {}
            property WeatherConfig weather: WeatherConfig {}
            property WallpaperConfig wallpaper: WallpaperConfig {}
        }
    }

    function save() {
       fileView.writeAdapter()
    }
}
