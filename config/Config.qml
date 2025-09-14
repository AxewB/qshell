pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.utils
import qs.config.appearance as App
import qs.config.modules as Modules
import qs.config.service as Service

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

            property App.AppearanceConfig appearance: App.AppearanceConfig {}
            property Modules.Borders borders: Modules.Borders {}
            property Modules.FakeRounding fakeRounding: Modules.FakeRounding {}
            property Service.Weather weather: Service.Weather {}
        }
    }

    function save() {
       fileView.writeAdapter()
    }
}
