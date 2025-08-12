import QtQuick
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.modules
import qs.service
import qs.config
import "./modules"

Item {
    id: root
    property QtObject workingArea
    property list<Region> regions: []

    x: workingArea.x
    y: workingArea.y
    height: workingArea.height
    width: workingArea.width

    WrapperRegion {
        margin: BorderConfig.margin
        anchors.right: root.right
        NotificationsList {
            id: notificationModule
        }
        z: 20
    }


    WrapperRegion {
        margin: BorderConfig.margin
        anchors.right: root.right
        OSD {}
        z: 20
    }


    // WrapperRegion {
    //     margin: BorderConfig.margin
    //     anchors.right: root.right
    //     active: WidgetFocusService.frameControlPanel

    //     FocusPanel {
    //         id: controlPanelModule
    //         active: WidgetFocusService.frameControlPanel
    //         x: active ? 0 : width + BorderConfig.margin * 4

    //         ControlPanel {
    //             // anchors.right: root.right
    //             // implicitHeight: root.height - BorderConfig.margin * 2
    //             // implicitWidth: 200
    //         }
    //     }
    // }

    function updateRegions() {
        root.regions = children.map(child => child.region)
    }

    onChildrenChanged: updateRegions()
    Component.onCompleted: updateRegions()
}
