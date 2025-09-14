import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

JsonObject {
    property bool enabled: true
    property int thickness: Config.appearance.padding.normal * enabled
    property int radius: Config.appearance.radius.medium
    property int panelsPadding: Config.appearance.padding.large * enabled
    property int margin: Config.appearance.padding.normal

    property int activationAreaWidth: 1
    property int borderItemPadding: 4
    property int openTimerInterval: 150
    property int closeTimerInterval: 150
}
