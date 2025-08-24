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
import qs.modules


Item {
    implicitHeight: content.implicitHeight
    Layout.fillHeight: true
    Layout.fillWidth: true

    RowLayout {
        id: content
        anchors.fill: parent
        height: parent.height
        layoutDirection: Qt.LeftToRight
        spacing: Config.appearance.padding.huge


        Item {
            id: leftContent
            implicitHeight: leftContentLeft.implicitHeight
            Layout.fillWidth: true

            RowLayout {
                id: leftContentLeft
                anchors.left: parent.left
                layoutDirection: Qt.LeftToRight
                spacing: Config.appearance.padding.huge

                StyledIconButton {
                    icon: "save"
                    size: Config.appearance.icon.small
                    onLeftClicked: Config.save()
                }

                // BarModuleWrapper {
                //     color: "transparent"
                //     visible: WeatherService.currentReady
                //     StyledButton {
                //         implicitHeight: root.implicitHeight
                //         leftPadding: Config.appearance.padding.huge
                //         rightPadding: Config.appearance.padding.huge
                //         Weather { }
                //     }
                // }
            }
        }
        Item {
            id: rightContent
            implicitHeight: leftContentRight.implicitHeight
            Layout.fillWidth: true

            RowLayout {
                id: leftContentRight
                anchors.right: parent.right
                layoutDirection: Qt.RightToLeft
                spacing: Config.appearance.padding.huge

                BarModuleWrapper {
                    clickable: false
                    Media { }
                }
            }
        }
    }
}
