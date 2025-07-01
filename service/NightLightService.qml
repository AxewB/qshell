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

    property bool auto: true
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

    function isTimeInRange(startHour, startMinute, endHour, endMinute) {
        const now = new Date();
        const currentTime = now.getHours() * 60 + now.getMinutes();  // В минутах

        const startTime = startHour * 60 + startMinute;
        const endTime = endHour * 60 + endMinute;

        if (startTime <= endTime) {
            return currentTime >= startTime && currentTime < endTime;
        } else {
            return currentTime >= startTime || currentTime < endTime;
        }
    }

    function autoFunction() {
        if (root.isTimeInRange(root.startTime[0], root.startTime[1], root.endTime[0], root.endTime[1])) {
            console.log("FIRST")
            root.enabled = true
        } else {
            console.log("LAST")
            root.enabled = false
        }
    }

    Timer {
        interval: 60000 // 1 min
        running: root.auto
        repeat: true
        triggeredOnStart: true
        onTriggered: root.autoFunction()
    }
}
