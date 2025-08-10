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

Item {
    id: root
    required property Item topContent
    required property Item rightContent
    required property Item bottomContent
    required property Item leftContent
    property bool topContentGrowExclusions: true
    property bool rightContentGrowExclusions: true
    property bool bottomContentGrowExclusions: true
    property bool leftContentGrowExclusions: true
    required property ShellScreen screen

    readonly property int borderMargin: BorderConfig.margin
    readonly property int borderThickness: BorderConfig.thickness

    ExclusiveRegion {
        id: regionTop
        anchors.top: true
        exclusiveZone: BorderConfig.thickness + BorderConfig.margin + (root.topContent.implicitHeight - BorderConfig.thickness) * root.topContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionBottom
        anchors.bottom: true
        exclusiveZone: BorderConfig.thickness + BorderConfig.margin + (root.bottomContent.implicitHeight - BorderConfig.thickness) * root.bottomContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionRight
        anchors.right: true
        exclusiveZone: BorderConfig.thickness + BorderConfig.margin + (root.rightContent.implicitWidth - BorderConfig.thickness) * root.rightContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionLeft
        anchors.left: true
        exclusiveZone: BorderConfig.thickness + BorderConfig.margin + (root.leftContent.implicitWidth - BorderConfig.thickness) * root.leftContentGrowExclusions
    }

    component ExclusiveRegion: PanelWindow {
        screen: root.screen
        color: "transparent"
        mask: Region {}
    }
}
