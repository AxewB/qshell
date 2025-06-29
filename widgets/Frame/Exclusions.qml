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
    required property WrapperItem topContent
    required property WrapperItem rightContent
    required property WrapperItem bottomContent
    required property WrapperItem leftContent
    required property Item borders
    required property ShellScreen screen
    property int padding: 0

    ExclusiveRegion {
        anchors.top: true
        exclusiveZone: root.padding + root.borders.thickness + root.topContent.implicitHeight - root.topContent.margin
    }

    ExclusiveRegion {
        anchors.right: true
        exclusiveZone: root.padding + root.borders.thickness + root.rightContent.implicitWidth - root.rightContent.margin
    }

    ExclusiveRegion {
        anchors.bottom: true
        exclusiveZone: root.padding + root.borders.thickness + root.bottomContent.implicitHeight - root.bottomContent.margin
    }

    ExclusiveRegion {
        anchors.left: true
        exclusiveZone: root.padding + root.borders.thickness + root.leftContent.implicitWidth - root.leftContent.margin
    }

    component ExclusiveRegion: PanelWindow {
        screen: root.screen
        color: "transparent"
        mask: Region {}
    }
}
