import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.service
import qs.config
import qs.utils
import qs.components

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

    readonly property int borderMargin: Config.borders.margin
    readonly property int borderThickness: Config.borders.thickness

    ExclusiveRegion {
        id: regionTop
        anchors.top: true
        exclusiveZone: Config.borders.thickness + Config.borders.margin + (root.topContent.implicitHeight - Config.borders.thickness) * root.topContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionBottom
        anchors.bottom: true
        exclusiveZone: Config.borders.thickness + Config.borders.margin + (root.bottomContent.implicitHeight - Config.borders.thickness) * root.bottomContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionRight
        anchors.right: true
        exclusiveZone: Config.borders.thickness + Config.borders.margin + (root.rightContent.implicitWidth - Config.borders.thickness) * root.rightContentGrowExclusions
    }

    ExclusiveRegion {
        id: regionLeft
        anchors.left: true
        exclusiveZone: Config.borders.thickness + Config.borders.margin + (root.leftContent.implicitWidth - Config.borders.thickness) * root.leftContentGrowExclusions
    }

    component ExclusiveRegion: PanelWindow {
        screen: root.screen
        color: "transparent"
        mask: Region {}
    }
}
