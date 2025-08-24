import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.config
import qs.components

StyledButton {
    id: root
    property alias icon: iconComponent.icon
    property alias size: iconComponent.size
    property string color: contentColor

    implicitWidth: implicitHeight

    Icon {
        id: iconComponent
        color: root.color
    }
}
