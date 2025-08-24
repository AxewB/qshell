pragma Singleton
import QtQuick
import Quickshell
import qs.config

Singleton {
    id: root
    property Modules modules: Modules {}

    component Modules: QtObject {
        property Module mediaPlayer: Module {}
    }

    component Module: QtObject {
        id: moduleObject
        property bool enabled: false
        property Item item: null
        property Item dependentItem: null
        property point dependentPos: Qt.point(0, 0)
        property Timer closingTimer: Timer {
            interval: Config.appearance.animation.durations.fast
            running: false
            onTriggered: enabled = false
        }
        property Connections itemConnections: Connections {
            target: moduleObject.item
            enabled: target ? true : false

            onXChanged: { moduleObject.updateByTimer() }
            onYChanged: { moduleObject.updateByTimer() }
            onWidthChanged: { moduleObject.updateByTimer() }
            onHeightChanged: { moduleObject.updateByTimer() }
        }

        signal updated()


        function open() {
            closingTimer.stop()
            updateDependentPos()
            enabled = true
        }
        function close() { enabled = false }
        function closeByTimer() { closingTimer.start() }
        function toggle() { enabled = !enabled; }
        function setItem(parentItem) { item = parentItem }
        function setDependentItem(item) { dependentItem = item }
        // should be called only by `connections` property
        function updateDependentPos() {
            if (!item || !dependentItem) return

            dependentPos = item.mapToGlobal(0, 0)
            dependentPos.x = dependentPos.x + (item.width - dependentItem.width) / 2
            dependentPos.y = dependentPos.y + (item.height - dependentItem.height) / 2
        }

        function updateByTimer() {
            updateTimer.restart()
        }

        onEnabledChanged: updateByTimer()
        onItemChanged: updateByTimer()
        onDependentItemChanged: updateByTimer()


        property Timer updateTimer: Timer {
            interval: 20 // adding some to not call multiple times onTriggered() when multiple props changing
            onTriggered: {
                moduleObject.updateDependentPos()
            }
        }
    }

}
