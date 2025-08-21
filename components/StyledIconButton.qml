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
    property string color: contentColor
    padding: 2

    Icon {
        id: iconComponent
        color: root.color
    }
}
