import Quickshell
import Quickshell.Io
import QtQuick

JsonObject {
    property bool enabled: true
    property int thickness: Config.appearance.padding.normal * Config.borders.enabled
    property int radius: Config.appearance.radius.normal
    property int panelsPadding: Config.appearance.padding.enormous * Config.borders.enabled
    property int margin: Config.appearance.padding.huge
}
