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
    property int padding: BorderConfig.margin

    x: workingArea.x - padding / 2
    y: workingArea.y - padding / 2
    height: workingArea.height + padding
    width: workingArea.width + padding

    // WrapperRegion {
    //     margin: BorderConfig.margin
    //     anchors.right: root.right
    //     z: 20
    //     NotificationsList { }
    // }


    // WrapperRegion {
    //     margin: BorderConfig.margin
    //     anchors.right: root.right
    //     z: 20
    //     OSD {}
    // }


    WrapperRegion {
        x: 0
        y: 0
        RoundedDrawer {
            id: drawer
            position { left: true; top: true }
        }
    }

    WrapperRegion {
        x: (root.width - implicitWidth) / 2

        RoundedDrawer {
            position { top: true }
        }
    }

    WrapperRegion {
        x: root.width - implicitWidth
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

        RoundedDrawer {
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
            position {
                right: true
                bottom: true
            }
            active: osdModule.shouldShowOsd
        }
    }

    WrapperRegion {
        x: (root.width - implicitWidth) / 2
        y: root.height - implicitHeight

        RoundedDrawer {
            position.bottom: true
        }
    }
    WrapperRegion {
        x: 0
        y: root.height - implicitHeight

        RoundedDrawer {
            position {
                left: true
                bottom: true
            }
        }
    }
    WrapperRegion {
        x: 0
        y: (root.height - implicitHeight) / 2

        RoundedDrawer {
            id: leftDrawer
            position.left: true
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
