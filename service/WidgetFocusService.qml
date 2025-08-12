pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland

Singleton {
    readonly property var widgets: [
        "frameControlPanel",
        "weatherPanel",
        "musicPanel",
        "notificationsPanel"
    ]

    property bool frameControlPanel: false
    property bool weatherPanel: false
    property bool musicPanel: false
    property bool notificationsPanel: false

    function focusOnly(widgetName) {
        for (let i = 0; i < widgets.length; i++) {
            let name = widgets[i]
            if (name === widgetName) {
                this[name] = true
            } else {
                this[name] = false
            }
        }
    }

    function enable(widgetName) {
        if (widgets.indexOf(widgetName) !== -1) {
            this[widgetName] = true
        }
    }

    function disable(widgetName) {
        if (widgets.indexOf(widgetName) !== -1) {
            this[widgetName] = false
        }
    }

    function disableAll() {
        for (let i = 0; i < widgets.length; i++) {
            this[widgets[i]] = false
        }
    }
}
