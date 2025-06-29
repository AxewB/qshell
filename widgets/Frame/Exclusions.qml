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

Item {
    id: root
    property Item bar
    property Item borders
    property var screen
    property int padding: 0

    ExclusiveRegion {
        anchors.top: true
        exclusiveZone: root.padding - root.bar.padding + root.borders.thickness + root.bar.implicitHeight
    }

    ExclusiveRegion {
        anchors.right: true
    }

    ExclusiveRegion {
        anchors.bottom: true
    }

    ExclusiveRegion {
        anchors.left: true
    }

    component ExclusiveRegion: PanelWindow {
        screen: root.screen
        exclusiveZone: root.borders.thickness + root.padding
        color: "transparent"
        mask: Region {}
    }
}
