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
        exclusiveZone: root.borderThickness + root.topContent.implicitHeight * root.topContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionBottom
        anchors.bottom: true
        exclusiveZone: root.borderThickness + root.bottomContent.implicitHeight * root.bottomContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionRight
        anchors.right: true
        exclusiveZone: root.borderThickness + root.rightContent.implicitWidth * root.rightContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionLeft
        anchors.left: true
        exclusiveZone: root.borderThickness + root.leftContent.implicitWidth * root.leftContentGrowExclusions
    }

    component ExclusiveRegion: PanelWindow {
        screen: root.screen
        color: "transparent"
        mask: Region {}
    }
}
