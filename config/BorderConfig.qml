pragma ComponentBehavior
pragma Singleton
import Quickshell
import QtQuick
import "root:/service"
import "root:/config"

Singleton {
    property int thickness: Appearance.padding.normal * AppConfig.modules.borders
    property int radius: Appearance.radius.normal
    property int panelsPadding: Appearance.padding.enormous * AppConfig.modules.borders
    property int margin: Appearance.padding.huge
}
