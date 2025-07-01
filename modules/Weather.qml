import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"

WrapperItem {
    id: root
    property int time: WeatherService.current.time
    property int temp: WeatherService.current.temp
    property int weatherCode: WeatherService.current.weatherCode

    opacity:  WeatherService.currentReady ? 1 : 0
    visible: WeatherService.currentReady


    RowLayout {
        spacing: Appearance.padding.normal
        Icon {
            icon: WeatherService.weathercodeToIcon(root.weatherCode)
            size: Appearance.icon.small
        }
        WrapperItem {
            ColumnLayout {
                spacing: -4
                StyledText {
                    text: WeatherService.weathercodeToText(root.weatherCode)
                    color: Colors.palette.m3onSurface
                    type: "subtext"
                }
                StyledText {
                    text: root.temp
                    color: Colors.palette.m3onSurfaceVariant
                    font.pixelSize: 10
                }
            }
        }
    }

    Behavior on implicitHeight { Anim {} }
    Behavior on implicitWidth { Anim {} }
    Behavior on opacity {Anim {} }
    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.slow
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }
}
