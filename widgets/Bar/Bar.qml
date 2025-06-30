
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"
import "./Tray"

WrapperItem {
    id: root
    implicitHeight: contentWrapper.implicitHeight

    RowLayout {
        id: content
        anchors.fill: parent
        spacing: root.padding

        BarLeftSection {}
        BarCenterSection {}
        BarRightSection {}
    }
}
