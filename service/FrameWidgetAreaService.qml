pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root
    property Modules modules: Modules {}
    property bool debug: false

    component Modules: QtObject {
        property Module mediaPlayer: Module {}
    }

    component Module: QtObject {
        id: moduleObject
        property bool enabled: false
        property Item item: Item {}
        property Item dependentItem: Item {}
        property point dependentPos: Qt.point(0, 0)
        property Timer timer: Timer {
            interval: Appearance.animation.durations.fast
            running: false
            onTriggered: enabled = false
        }

        signal updated()

        function open() {
            timer.stop()
            enabled = true
        }
        function close() { enabled = false }
        function closeByTimer() { timer.start() }
        function toggle() { enabled = !enabled; updateDependentPos() }
        function setItem(parentItem) {
            item = parentItem
            updateDependentPos()
        }
        function setDependentItem(item) {
            dependentItem = item
            updateDependentPos()
        }
        // can be called outside, because onItemChange doesn't activates when item's props are updating
        function updateDependentPos() {
            if (!item || !dependentItem) return
            Qt.callLater(() => {
                dependentPos = item.mapToGlobal(0, 0)
                debugLog()
            })
        }
        function debugLog() {
            if (!root.debug) return

            console.log("enabled: ", enabled)
            console.log("item: ", item)
            console.log("dependentItem: ", dependentItem)
            console.log("dependentPos: ", dependentPos)
        }

        onItemChanged: updateDependentPos()
        onDependentItemChanged: updateDependentPos()

    }
}
