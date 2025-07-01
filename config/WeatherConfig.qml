// reference: https://open-meteo.com/en/docs
pragma ComponentBehavior
pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import "root:/service"
import "root:/config"
import "root:/utils"

Singleton {
    id: root
    property real latitude: 0
    property real longtitude: 0
    property string temperature_unit: "celsius"
    property string timezone: "GMT"

    function apply(data: string) {
        const jsonData = JSON.parse(data.trim());

        root.latitude = jsonData.latitude
        root.longtitude = jsonData.longtitude
        root.temperature_unit = jsonData.temperature_unit
        root.timezone = jsonData.timezone
    }

    FileView {
        path: `${Paths.weatherConfig}`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.apply(this.text())
    }
}
