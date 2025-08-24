pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import qs.components
import qs.modules
import qs.service
import qs.config
import "./modules" as Modules

Item {
    id: root
    property QtObject workingArea
    property list<Region> regions: []
    property int padding: Config.borders.margin

    x: workingArea.x - padding / 2
    y: workingArea.y - padding / 2
    height: workingArea.height + padding
    width: workingArea.width + padding

    WrapperRegion {
        id: mediaRegion
        property QtObject module: FrameWidgetAreaService.modules.mediaPlayer
        x: module.dependentPos.x
        y: 0
        active: mediaDrawer.active
        RoundedDrawer {
            id: mediaDrawer
            active: mediaRegion.module.enabled
            position { top: true }

            Component.onCompleted: mediaRegion.module.setDependentItem(mediaRegion)
            onHide: mediaRegion.module.closeByTimer()
            onShow: mediaRegion.module.open()

            MediaPlayer { }
        }
    }

    WrapperRegion {
        x: (root.width - implicitWidth) / 2
        y: 0
        RoundedDrawer {
            position { top: true }
        }
    }

    WrapperRegion {
        x: root.width - implicitWidth
        y: 0
        z: 20
        RoundedDrawer {
            active: true
            position { right: true; top: true }
            NotificationsList { }
        }
    }
    WrapperRegion {
        x: root.width - implicitWidth
        y: (root.height - implicitHeight) / 2
        active: osdDrawer.active

        RoundedDrawer {
            id: osdDrawer
            position { right: true }
            active: osdModule.shouldShowOsd

            Modules.OSD {
                id: osdModule
            }
        }
    }
    WrapperRegion {
        x: root.width - implicitWidth
        y: root.height - implicitHeight
        RoundedDrawer {
            position { right: true; bottom: true }
            active: osdModule.shouldShowOsd
        }
    }

    WrapperRegion {
        x: (root.width - implicitWidth) / 2
        y: root.height - implicitHeight

        RoundedDrawer {
            position { bottom: true }
        }
    }
    WrapperRegion {
        x: 0
        y: root.height - implicitHeight

        RoundedDrawer {
            position { left: true; bottom: true }
        }
    }
    WrapperRegion {
        x: 0
        y: (root.height - implicitHeight) / 2

        RoundedDrawer {
            position { left: true }
        }
    }


  //   PanelWindow {
		// anchors.right: true
		// exclusiveZone: 0
		// implicitWidth: 400
		// implicitHeight: root.height
		// color: "transparent"

		// Rectangle {
 	// 		anchors.fill: parent
		// }
  //   }


    // WrapperRegion {
    //     margin: Config.borders.margin
    //     anchors.right: root.right
    //     active: WidgetFocusService.frameControlPanel

    //     FocusPanel {
    //         id: controlPanelModule
    //         active: WidgetFocusService.frameControlPanel
    //         x: active ? 0 : width + Config.borders.margin * 4

    //         ControlPanel {
    //             // anchors.right: root.right
    //             // implicitHeight: root.height - Config.borders.margin * 2
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
