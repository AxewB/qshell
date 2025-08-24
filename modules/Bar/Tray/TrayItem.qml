pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.SystemTray
import qs.config
import qs.service
import qs.components

Item {
    id: root

    required property SystemTrayItem modelData

    anchors.verticalCenter: parent.verticalCenter

    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth

    StyledButton {
        id: icon
        padding: 4
        StyledRectangle {

            implicitHeight: Config.appearance.icon.xsmall
            implicitWidth: Config.appearance.icon.xsmall
            color: 'transparent'

            IconImage {

                source: {
                    let icon = root.modelData.icon;
                    if (icon.includes("?path=")) {
                        const [name, path] = icon.split("?path=");
                        icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                    }
                    return icon;
                }
                asynchronous: true
                anchors.fill: parent
            }
        }

        onRightClicked: menu.open()
        onLeftClicked: modelData.onlyMenu ? null : modelData.activate()
    }

    // TrayItemMenu {
    //     menu: root.modelData.menu
    //     x: root.x
    //     y: root.y
    // }

    QsMenuAnchor {
        id: menu

        menu: root.modelData.menu
        anchor.window: this.QsWindow.window
    }

    // ToolTip {
    //     id: tooltip
    //     delay: 1000
    //     popupType: Qt.Window

    //     background: Rectangle {
    //         anchors.fill: parent
    //         color: 'red'
    //     }
    // }
}
