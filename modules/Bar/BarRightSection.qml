import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import qs.service
import qs.modules
import qs.utils
import qs.components
import "./Tray"

Item {
    Layout.fillWidth: true
    Layout.fillHeight: true
    implicitHeight: left.implicitHeight


    RowLayout {
        id: content
        anchors.fill: parent
        height: parent.height
        layoutDirection: Qt.LeftToRight
        spacing: 0

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
                    implicitHeight: root.implicitHeight
                    NightLight { }

                    ScreenCapture { }
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
                    implicitHeight: root.implicitHeight
                    color: "transparent"
                    StyledButton {
                        implicitHeight: root.implicitHeight
                        leftPadding: 8
                        rightPadding: 8
                        Clock { }
                    }
                }
                BarModuleWrapper {
                    implicitHeight: root.implicitHeight
                    Tray { }
                }
            }
        }
    }
}
