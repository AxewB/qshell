pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.SystemTray
import "root:/service"
import "root:/utils"
import "root:/components"

MouseArea {
    id: root

    required property SystemTrayItem modelData

    anchors.verticalCenter: parent.verticalCenter
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth

    hoverEnabled:true

    StyledRectangle {
        id: icon

        implicitHeight: Appearance.icon.xsmall
        implicitWidth: Appearance.icon.xsmall
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

    onClicked: event => {
        if (event.button == Qt.LeftButton){
            modelData.activate()
        }
        else {
            menu.open()
        }

    }


    states: State {
        name: "hovered"
        when: root.containsMouse

        PropertyChanges {
            target: tooltip
            visible: true
        }
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
