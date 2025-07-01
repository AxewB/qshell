pragma ComponentBehavior
pragma Singleton
import Quickshell
import QtQuick
import "root:/service"
import "root:/config"

Singleton {
    id: root
    property bool enabled: false

    property int temp: 1000
    readonly property int tempMax: 20000
    readonly property int tempMin: 1000

    property real intensity: 0.05
    readonly property real intensityMax: 0.1
    readonly property real intensityMin: 0.01

    property bool auto: false
    property list<int> startTime: [20, 0] // [hours, minutes]
    property list<int> endTime: [8, 0]

    property color color: temperatureToColor(temp)

    function temperatureToColor(kelvin) {
        kelvin = Math.max(root.tempMin, Math.min(root.tempMax, kelvin));

        let temp = kelvin / 100;

        let red, green, blue;

        // RED
        if (temp <= 66) {
            red = 255;
        } else {
            red = temp - 60;
            red = 329.698727446 * Math.pow(red, -0.1332047592);
            red = Math.max(0, Math.min(255, red));
        }

        // GREEN
        if (temp <= 66) {
            green = temp;
            green = 99.4708025861 * Math.log(green) - 161.1195681661;
        } else {
            green = temp - 60;
            green = 288.1221695283 * Math.pow(green, -0.0755148492);
        }
        green = Math.max(0, Math.min(255, green));

        // BLUE
        if (temp >= 66) {
            blue = 255;
        } else if (temp <= 19) {
            blue = 0;
        } else {
            blue = temp - 10;
            blue = 138.5177312231 * Math.log(blue) - 305.0447927307;
            blue = Math.max(0, Math.min(255, blue));
        }

        return Qt.rgba(red/255, green/255, blue/255, 1.0);
    }

    Timer {
        interval: 60000 // 1 min
        running: root.auto
        repeat: true
        onTriggered: {
            const date = Date.now()
            const hours = date.hours()
            const minutes = date.minutes()

            const moreThanStartTime = hours > root.startTime[0] && minutes > root.startTime[1]
            const lessThanEndTime = hours < root.endTime[0] && minutes < root.endTime[1]

            if (moreThanStartTime && lessThanEndTime) {
                root.enabled = true
            } else {
                root.enabled = false
            }
        }
    }
}
