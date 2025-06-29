import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/config"
import "root:/utils"
import "root:/components"
import "./Tray"

Flow {
    id: root
    padding: 4
    property bool clicked: false

    Icon {
        icon: "sort"
    }
    Icon {
        icon: root.clicked? "volume_down" : "volume_mute"
    }
    Icon {
        icon: "volume_mute"
    }
    Icon {
        icon: "volume_off"
    }
    Button {
        onClicked: {
            root.clicked = !root.clicked
        }
    }
}
