
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

WrapperItem {
    id: root

    RowLayout {
        id: content
        anchors.fill: parent
        spacing: Appearance.padding.huge

        BarLeftSection {
            Layout.minimumHeight: 32
        }
        BarCenterSection {
            Layout.minimumHeight: 32
        }
        BarRightSection {
            Layout.minimumHeight: 32
        }
    }
}
