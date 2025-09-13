import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.service
import qs.config
import qs.modules
import qs.utils
import qs.components
import qs.modules.bar.modules.tray
import qs.modules.bar.modules.workspaces


WrapperItem {
    id: root
    Item {
        id: layoutRoot
        implicitHeight: Math.max(leftSection.implicitHeight, centerSection.implicitHeight, rightSection.implicitHeight)

        CenterSection {
            id: centerSection
            anchors.centerIn: parent

            // Workspaces {}
        }

        LeftSection {
            id: leftSection
            anchors.left: parent.left
            anchors.right: centerSection.left
            anchors.verticalCenter: parent.verticalCenter

        }

        RightSection {
            id: rightSection
            anchors.left: centerSection.right
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Clock { }
            Tray { }
        }
    }


    component LeftSection: Item {
        default property alias children: leftLayout.children
        implicitHeight: leftLayout.implicitHeight
        implicitWidth: leftLayout.implicitWidth

        RowLayout {
            id: leftLayout
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: Config.appearance.padding.normal
            layoutDirection: Qt.LeftToRight
        }
    }
    component CenterSection: Item {
        default property alias children: centerLayout.children
        implicitWidth: centerLayout.implicitWidth
        implicitHeight: centerLayout.implicitHeight

        RowLayout {
            id: centerLayout
            anchors.centerIn: parent
            spacing: Config.appearance.padding.normal
        }
    }
    component RightSection: Item {
        default property alias children: rightLayout.children
        implicitHeight: rightLayout.implicitHeight
        implicitWidth: rightLayout.implicitWidth

        RowLayout {
            id: rightLayout
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: Config.appearance.padding.normal
            layoutDirection: Qt.RightToLeft
        }
    }
}
