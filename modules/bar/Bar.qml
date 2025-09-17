import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.service
import qs.config
import qs.modules
import qs.utils
import qs.components
import qs.components.material as MD
import qs.modules.bar.modules.tray
import "./workspaces" as WS
import "./clock" as ClockModule
import "./media" as Media


WrapperItem {
    id: root
    Item {
        id: layoutRoot
        implicitHeight: Math.max(leftSection.implicitHeight, centerSection.implicitHeight, rightSection.implicitHeight)


        LeftSection {
            id: leftSection
            anchors.left: parent.left
            anchors.right: centerSection.left
            anchors.verticalCenter: parent.verticalCenter

        }


        CenterSection {
            id: centerSection
            anchors.centerIn: parent

            MD.Button {
                id: button
                text: ""
                size:"xsmall"
                type:"text"
                smallPadding: true
                Media.Media {}
            }

            WS.Workspaces {}

            MD.Button {
                text: ""
                size:"xsmall"
                type:"text"
                smallPadding: true
                ClockModule.Clock {}
            }
        }

        RightSection {
            id: rightSection
            anchors.left: centerSection.right
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
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
            spacing: Config.appearance.padding.enormous
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
            spacing: Config.appearance.padding.medium
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
            spacing: Config.appearance.padding.enormous
            layoutDirection: Qt.RightToLeft
        }
    }
}
