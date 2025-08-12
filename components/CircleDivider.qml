import QtQuick
import Quickshell.Widgets
import "root:/service"

WrapperRectangle {
    id: root
    property int size: 4 * Appearance.scale

    radius: 1000
    implicitHeight: size
    implicitWidth: size
}
