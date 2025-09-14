import QtQuick
import QtQuick.Layouts
import qs.components
import Quickshell.Widgets
import Quickshell
import qs.modules
import qs.components
import qs.service


Item {
    id: root
    required property var workingArea

    // Drawer {
    //     id: mediaRegion
    //     // module: FrameWidgetAreaService.modules.mediaPlayer
    //     // active: module.enabled

    //     itemX: 200
    //     itemY: active ? workingArea.y : -itemHeight
    //     itemXLimit: true
    //     // WrapperRegion {
    //     //     id: mediaModuleWrapper
    //     //     margin: 10
    //     //     ColumnLayout {
    //     //         MediaPlayer {}
    //     //     }
    //     // }
    // }

    component Drawer: Item {
        id: drawerWrapper
        default property alias child: drawer.child

        property QtObject module: null
        property bool active: false

        property alias itemX: drawer.itemX
        property alias itemY: drawer.itemY
        property alias itemHeight: drawer.itemHeight
        property alias itemWidth: drawer.itemWidth
        property alias itemXLimit: drawer.itemXLimit
        property alias itemYLimit: drawer.itemYLimit

        FloatingDrawer {
            id: drawer
            parent: root
            workingArea: root.workingArea
        }

        HoverHandler {
            parent: drawer.child
            onHoveredChanged: {
                if (hovered) drawerWrapper.module.open()
                else drawerWrapper.module.closeByTimer()
            }
        }
    }
}
