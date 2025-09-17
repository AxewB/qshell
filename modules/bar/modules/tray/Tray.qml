
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import qs.config


Item {
    id: root

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Row {
        id: content
        spacing: Config.appearance.padding.medium

        Repeater {
            id: items
            model: SystemTray.items

            TrayItem {}
        }
    }
}
