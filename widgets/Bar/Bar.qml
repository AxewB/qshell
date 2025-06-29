
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
    property int padding: Appearance.padding.huge

    implicitHeight: contentWrapper.implicitHeight
    anchors.fill: parent

    WrapperItem {
        id: contentWrapper

        anchors.fill: parent
        margin: root.padding

        RowLayout {
            id: content
            anchors.fill: parent
            spacing: root.padding

            BarLeftSection {}
            BarCenterSection {}
            BarRightSection {}
        }
    }
}
