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
    }

    // WrapperRegion {
    //     margin: BorderConfig.margin
    //     anchors.right: root.right

    //     RightDrawer {
    //         id: rightDrawer
    //         implicitHeight: root.height - parent.margin * 2
    //         implicitWidth: 400
    //     }
    // }


    function updateRegions() {
        root.regions = children.map(child => child.region)
    }

    onChildrenChanged: updateRegions()
    Component.onCompleted: updateRegions()
}
