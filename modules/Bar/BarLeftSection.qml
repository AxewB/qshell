import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"
import "root:/modules"


Item {
    implicitHeight: content.implicitHeight
    Layout.fillHeight: true
    Layout.fillWidth: true

    RowLayout {
        id: content
        anchors.fill: parent
        height: parent.height
        layoutDirection: Qt.LeftToRight
        spacing: Appearance.padding.huge


        Item {
            id: leftContent
            implicitHeight: leftContentLeft.implicitHeight
            Layout.fillWidth: true

            RowLayout {
                id: leftContentLeft
                anchors.left: parent.left
                layoutDirection: Qt.LeftToRight
                spacing: Appearance.padding.huge

                BarModuleWrapper {
                    color: "transparent"
                    visible: WeatherService.currentReady
                    StyledButton {
                        implicitHeight: root.implicitHeight
                        leftPadding: Appearance.padding.huge
                        rightPadding: Appearance.padding.huge
                        Weather { }
                    }
                }
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
                spacing: Appearance.padding.huge

                BarModuleWrapper {
                    clickable: false
                    Media { }
                }
            }
        }
    }
}
