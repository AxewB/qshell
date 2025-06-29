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
    required property Item topContent
    required property Item rightContent
    required property Item bottomContent
    required property Item leftContent
    required property Item borders
    required property ShellScreen screen
    property int padding: 0

    ExclusiveRegion {
        anchors.top: true
        exclusiveZone: root.padding + root.borders.thickness + root.topContent.implicitHeight
    }

    ExclusiveRegion {
        anchors.right: true
        exclusiveZone: root.padding + root.borders.thickness + root.rightContent.implicitWidth
    }

    ExclusiveRegion {
        anchors.bottom: true
        exclusiveZone: root.padding + root.borders.thickness + root.bottomContent.implicitHeight
    }

    ExclusiveRegion {
        anchors.left: true
        exclusiveZone: root.padding + root.borders.thickness + root.leftContent.implicitWidth
    }

    component ExclusiveRegion: PanelWindow {
        screen: root.screen
        color: "transparent"
        mask: Region {}
    }
}
