import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/modules"
import "root:/utils"
import "root:/components"

StyledButton {
    id: root
    property alias icon: iconComponent.icon
    property alias size: iconComponent.size
    property string color:  root.down ? Colors.palette.m3onPrimaryContainer
        : root.active ? Colors.palette.m3onPrimary
        : Colors.palette.m3onSurface
    padding: 2

    Icon {
        id: iconComponent
        color: root.color
    }
}
