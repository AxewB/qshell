pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.SystemTray
import qs.components.material as MD
import qs.components.common as Common
import qs.config
import qs.service
import qs.components

Item {
    id: root

    required property SystemTrayItem modelData

    anchors.verticalCenter: parent.verticalCenter

    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth

    MD.Button {
        id: icon
        padding: 0
        size: "xsmall"
        text: ""
        type: "outlined"

        Common.Rectangle {

            implicitHeight: 16
            implicitWidth: 16
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

        onClicked:  {
            doubleClickTimer.start()
        }
        onDoubleClicked: {
            root.modelData.activate()
            doubleClickTimer.stop()
        }
    }


    Timer {
        id: doubleClickTimer
        interval: 150
        onTriggered: menu.open()
    }

    QsMenuAnchor {
        id: menu

        menu: root.modelData.menu
        anchor.window: this.QsWindow.window
    }
}
