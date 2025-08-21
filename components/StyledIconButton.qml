import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.service
import qs.components

StyledButton {
    id: root
    property alias icon: iconComponent.icon
    property alias size: iconComponent.size
    property string color: contentColor
    padding: Appearance.padding.small

    Icon {
        id: iconComponent
        color: root.color
    }
}
