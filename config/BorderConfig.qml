pragma ComponentBehavior
pragma Singleton
import Quickshell
import QtQuick
import "root:/service"

Singleton {
    property int thickness: Appearance.padding.normal
    property int margin: Appearance.padding.huge
}
