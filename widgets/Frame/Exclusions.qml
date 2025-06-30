import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/config"
import "root:/utils"
import "root:/components"
import "./Tray"

Item {
    id: root
    required property Item topContent
    required property Item rightContent
    required property Item bottomContent
    required property Item leftContent
    required property ShellScreen screen

    readonly property int borderMargin: BorderConfig.margin
    readonly property int borderThickness: BorderConfig.thickness

    ExclusiveRegion {
        anchors.top: true
        exclusiveZone: root.borderThickness + root.borderMargin + root.topContent.implicitHeight
    }

    ExclusiveRegion {
        anchors.right: true
        exclusiveZone: root.borderMargin + root.borderThickness + root.rightContent.implicitWidth
    }

    ExclusiveRegion {
        anchors.bottom: true
        exclusiveZone: root.borderMargin + root.borderThickness + root.bottomContent.implicitHeight
    }

    ExclusiveRegion {
        anchors.left: true
        exclusiveZone: root.borderMargin + root.borderThickness + root.leftContent.implicitWidth
    }

    component ExclusiveRegion: PanelWindow {
        screen: root.screen
        color: "transparent"
        mask: Region {}
    }
}
