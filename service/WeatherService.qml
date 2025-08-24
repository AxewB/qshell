import QtQuick
import Quickshell
import Quickshell.Io
import "root:/utils"
import "root:/config"
pragma Singleton

Singleton {
    id: root
    // maybe config loads faster because of this
    property real _weatherConfig: Config.weather.latitude

    property string unit
    property WeatherCurrent current: WeatherCurrent {}
    property WeatherWeekly weekly: WeatherWeekly {}
    property bool currentReady: false

    function applyWeekly(data: string) {
        let jsonData = null
        jsonData = JSON.parse(data.trim());

        root.weekly.date = jsonData.daily.date
        root.weekly.tempMax = jsonData.daily.temp_max
        root.weekly.tempMin = jsonData.daily.temp_min
        root.weekly.weatherCode = jsonData.daily.weather_code
        root.weekly.sunrise = jsonData.daily.sunrise
        root.weekly.daylightDuration = jsonData.daily.daylight_duration
    }

    function applyCurrent(data: string) {
        const jsonData = JSON.parse(data.trim());

        const current = jsonData.current

        root.current.time = current.time
        root.current.temp = current.temperature_2m
        root.current.rain = current.rain
        root.current.showers = current.showers
        root.current.snowfall = current.snowfall
        root.current.weatherCode = current.weather_code
        root.currentReady = true
    }

    function weathercodeToText(weathercode) {
        switch (weathercode) {
            case 0: return "Clear sky"
            case 1: return "Mainly clear"
            case 2: return "Partly cloudy"
            case 3: return "Overcast"
            case 45: return "Fog"
            case 48: return "Fog (Depositing rime)"
            case 51: return "Light Drizzle"
            case 53: return "Moderate Drizzle"
            case 55: return "Dense Drizzle"
            case 56: return "Light Freezing Drizzle"
            case 57: return "Dense Freezing Drizzle"
            case 61: return "Slight Rain"
            case 63: return "Moderate Rain"
            case 65: return "Heavy Rain"
            case 66: return "Light Freezing Rain"
            case 67: return "Heavy Freezing Rain"
            case 71: return "Slight Snowfall"
            case 73: return "Moderate Snowfall"
            case 75: return "Heavy Snowfall"
            case 77: return "Snow grains"
            case 80: return "Slight Rainshower"
            case 81: return "Moderate Rainshower"
            case 82: return "Violent Rainshower"
            case 85: return "Slight Snowshowers"
            case 86: return "Heavy Snowshowers"
            case 95: return "Thunderstorm"
            case 96: return "Thunderstorm with slight hail"
            case 99: return "Thunderstorm with heavy hail"
            default: return "Unknown weather"
        }
    }

    function weathercodeToIcon(weathercode) {
        switch (weathercode) {
            case 0: return "clear_day"
            case 1: return "cloud"
            case 2: return "cloud"
            case 3: return "cloud"
            case 45: return "foggy"
            case 48: return "foggy"
            case 51: return "rainy"
            case 53: return "rainy_light"
            case 55: return "rainy_heavy"
            case 56: return "rainy_light"
            case 57: return "rainy_heavy"
            case 61: return "rainy"
            case 63: return "rainy_light"
            case 65: return "rainy_heavy"
            case 66: return "rainy_light"
            case 67: return "rainy_heavy"
            case 71: return "weather_snowy"
            case 73: return "weather_snowy"
            case 75: return "weather_snowy"
            case 77: return "weather_snowy"
            case 80: return "rainy"
            case 81: return "rainy_light"
            case 82: return "rainy_light"
            case 85: return "rainy_heavy"
            case 86: return "rainy_heavy"
            case 95: return "thunderstorm"
            case 96: return "thunderstorm"
            case 99: return "thunderstorm"
            default: return "cloud_alert"
        }
    }

    FileView {
        path: `${Paths.weatherCache}`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.applyWeekly(text())
    }

    Process {
        id: updateDailyWeatherInfoProc
        running: true
        command: [
            "axewbshell",
            "weather",
            "-la", Config.weather.latitude,
            "-lo", Config.weather.longtitude,
            "-u", Config.weather.temperature_unit,
            "-z", Config.weather.timezone,
            "-t", "weekly"
        ]
    }


    Process {
        id: updateCurrentWeatherInfoProc
        running: false
        stdout: StdioCollector {
            onStreamFinished:  root.applyCurrent(this.text)
        }
    }

    function updateCurrentWeather() {
        const latitude = Config.weather.latitude;
        const longtitude = Config.weather.longtitude;
        const temperature_unit = Config.weather.temperature_unit;
        const timezone = Config.weather.timezone;

        if (latitude == 0 || longtitude == 0) {
            return
        }

        configWaiter.running = false
        configWaiter.repeat = false
        currentWeatherTimer.running = true


        updateCurrentWeatherInfoProc.command = [
            "axewbshell",
            "weather",
            "-la", latitude,
            "-lo", longtitude,
            "-u", temperature_unit,
            "-z", timezone,
            "-t", "current"
        ]

        updateCurrentWeatherInfoProc.running = true
    }

    Timer {
        id: currentWeatherTimer
        interval: 900000 // 15 min
        running: false
        repeat: true
        onTriggered: root.updateCurrentWeather()
    }

    Timer {
        id: configWaiter
        interval: 500 // 15 min
        running: true
        repeat: true
        onTriggered: root.updateCurrentWeather()
    }

    component WeatherCurrent: QtObject {
        property int time: 0
        property int temp: 0
        property int rain: 0
        property int showers: 0
        property int snowfall: 0
        property int weatherCode: 0
    }

    component WeatherWeekly: QtObject {
        property list<string> date: []
        property list<real> tempMax: []
        property list<real> tempMin: []
        property list<int> weatherCode: []
        property list<int> sunrise: []
        property list<real> daylightDuration: []
    }
}
