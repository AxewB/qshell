import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.service
import qs.config

Item {
    id: root
    property bool enabled: false
    implicitHeight: control.implicitHeight
    implicitWidth: control.implicitWidth

    StyledIconButton {
        id: control
        active: root.enabled
        icon: "fit_screen"
        size: Appearance.icon.xsmall
        padding: 4
        onLeftClicked: root.enabled = !root.enabled
    }




    Popup {
        id: tooltip
        visible: root.enabled
        popupType: Popup.Window
        parent: control

        x: (parent.width - implicitWidth) / 2
        y: parent.height  // сразу под control

        contentItem: WrapperRegion {
            id: popupContent
            margin: BorderConfig.margin
            anchors.right: root.right
            WrapperRectangle {
                margin: Appearance.padding.enormous
                color: Colors.palette.m3surface
                radius: Appearance.radius.normal
                // сделать "стрелочку", которая будет показывать на кнопку, как у подсказок
                ColumnLayout {
                    spacing: Appearance.padding.huge
                    WrapperRectangle {
                        Layout.alignment: Qt.AlignHCenter
                        margin: Appearance.padding.normal
                        leftMargin: Appearance.padding.large
                        rightMargin: Appearance.padding.large
                        radius: height/2
                        color: Colors.palette.m3surfaceContainer

                        RowLayout {
                            anchors.centerIn: parent
                            StyledIconButton {
                                padding: 4
                                size: Appearance.icon.xsmall
                                icon: "fit_screen"
                            }
                            StyledIconButton {
                                padding: 4
                                size: Appearance.icon.xsmall
                                icon: "fit_screen"
                            }
                            StyledIconButton {
                                padding: 4
                                size: Appearance.icon.xsmall
                                icon: "fit_screen"
                            }
                        }
                    }
                    WrapperItem {
                        implicitWidth: Math.max(parent.implicitWidth, child.implicitWidth)
                        RowLayout {
                            spacing: Appearance.padding.huge
                            StyledText { Layout.alignment: Qt.AlignLeft; Layout.fillWidth: true; text: "Clipboard only";  }
                            StyledSwitch { Layout.alignment: Qt.AlignRight }
                        }
                    }
                    WrapperItem {
                        implicitWidth: Math.max(parent.implicitWidth, child.implicitWidth)
                        RowLayout {
                            StyledText { Layout.alignment: Qt.AlignLeft; Layout.fillWidth: true; text: "Freeze output"}
                            StyledSwitch { Layout.alignment: Qt.AlignRight }
                        }
                    }
                }
            }
        }

        background: Rectangle {
            color: Colors.palette.m3surface
            radius: Appearance.radius.normal
        }

        onClosed: root.enabled = false
    }

}
