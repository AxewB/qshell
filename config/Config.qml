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
        }
    }

    function save() {
       fileView.writeAdapter()
    }
}
