
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

WrapperItem {
    id: root
    margin: Appearance.padding.huge
    implicitHeight: contentWrapper.implicitHeight
    anchors.fill: parent

    RowLayout {
        id: content
        anchors.fill: parent
        spacing: root.padding

        BarLeftSection {}
        BarCenterSection {}
        BarRightSection {}
    }
}
