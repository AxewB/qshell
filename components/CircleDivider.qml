import QtQuick
import Quickshell.Widgets
import qs.config

WrapperRectangle {
    id: root
    property int size: 4 * Config.appearance.scale

    radius: 1000
    implicitHeight: size
    implicitWidth: size
}
