import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Particles
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.service
import qs.config
import qs.components
import "root:/modules/Bar"

Variants {
    model: Quickshell.screens

    Scope {
        id: scope
        property ShellScreen modelData

        PanelWindow {
            screen: modelData
            id: window
            focusable: true
            color: "transparent"
            WlrLayershell.exclusionMode: ExclusionMode.Ignore

            QtObject {
                id: clickThroughRegionBorders
                property int x: borders.thickness + frameLeft.implicitWidth
                property int y: borders.thickness + frameTop.implicitHeight
                property int width: window.width - borders.thickness * 2 - frameLeft.implicitWidth - frameRight.implicitWidth
                property int height: window.height - borders.thickness * 2 - frameBottom.implicitHeight - frameTop.implicitHeight
            }

            mask: Region {
                id: regionMask
                x: clickThroughRegionBorders.x
                y: clickThroughRegionBorders.y
                width: clickThroughRegionBorders.width
                height: clickThroughRegionBorders.height
                intersection: Intersection.Xor

                // regions: widgetBorders.instances
                regions: maskRegions.instances


            }

            Variants {
                id: maskRegions
                model: moduleArea.regions

                delegate: Region {
                    required property Region modelData

                    x: modelData.x
                    y: modelData.y
                    width: modelData.width
                    height: modelData.height
                    intersection: Intersection.Subtract
                }
            }

            ModuleArea {
                id: moduleArea
                workingArea: clickThroughRegionBorders
            }


            anchors {
                left: true
                right: true
                top: true
                bottom: true
            }

            Borders {
                id: borders
                screen: modelData
                topContent: frameTop
                rightContent: frameRight
                bottomContent: frameBottom
                leftContent: frameLeft
            }

            MultiEffect {
                source: borders
                anchors.fill: borders
                shadowEnabled: true
                blurMax: 16
                shadowColor: Colors.palette.m3shadow
            }

            FrameDrawer {
                id: frameTop
                position: "top"
                opened: true

                Bar {}
            }
            FrameDrawer {
                id: frameBottom
                position: "bottom"
            }
            FrameDrawer {
                id: frameRight
                position: "right"
            }
            FrameDrawer {
                id: frameLeft
                position: "left"
            }


            // component FrameDrawer: WrapperItem {
            //     id: drawer
            //     required property string position
            //     property bool hoverEnabled: true
            //     property bool opened: hoverEnabled ? drawerHoverHandler.hovered : false

            //     BorderHoverHandler {
            //         id: drawerHoverHandler
            //         position: drawer.position
            //         onPositionChanged: console.log(position)
            //         onHoveredChanged: {
            //             console.log(position, "hovered: ", hovered)
            //         }
            //     }

            //     implicitHeight: opened ? child.implicitHeight : 0
            //     implicitWidth: opened ? child.implicitWidth : 0

            //     clip: true

            //     Behavior on implicitWidth {
            //         NumberAnimation {
            //             duration: Appearance.animation.durations.normal
            //             easing.type: Easing.BezierSpline
            //             easing.bezierCurve: Appearance.animation.curves.ease
            //         }
            //     }

            //     Behavior on implicitHeight {
            //         NumberAnimation {
            //             duration: Appearance.animation.durations.normal
            //             easing.type: Easing.BezierSpline
            //             easing.bezierCurve: Appearance.animation.curves.ease
            //         }
            //     }

            //     Component.onCompleted: {
            //         margin: BorderConfig.thickness

            //         if (position == "right" || position == "left") {
            //             bottomMargin: frameBottom.implicitHeight + BorderConfig.thickness + BorderConfig.panelsPadding
            //             topMargin: frameTop.implicitHeight + BorderConfig.thickness + BorderConfig.panelsPadding
            //         } else if (position == "top" || position == "bottom") {
            //             leftMargin: frameLeft.implicitWidth + BorderConfig.thickness + BorderConfig.panelsPadding
            //             rightMargin: frameRight.implicitWidth + BorderConfig.thickness + BorderConfig.panelsPadding
            //         }

            //         if (["left", "top", "bottom"].includes(position)) drawer.anchors.left = drawer.parent.left;
            //         if (["right", "top", "bottom"].includes(position)) drawer.anchors.right = drawer.parent.right;
            //         if (["top", "right", "left"].includes(position)) drawer.anchors.top = drawer.parent.top;
            //         if (["bottom", "right", "left"].includes(position)) drawer.anchors.bottom = drawer.parent.bottom;
            //     }
            // }

            // component FrameDrawer: WrapperItem {
            //     id: drawer
            //     required property string position
            //     property bool hoverEnabled: true
            //     property bool opened: hoverEnabled ? drawerHoverHandler.hovered : false

            //     BorderHoverHandler {
            //         id: drawerHoverHandler
            //         position: drawer.position
            //         onPositionChanged: console.log(position)
            //         onHoveredChanged: {
            //             console.log(position, "hovered: ", hovered)
            //         }
            //     }

            //     implicitHeight: opened ? child.implicitHeight : 0
            //     implicitWidth: opened ? child.implicitWidth : 0

            //     clip: true

            //     Behavior on implicitWidth {
            //         NumberAnimation {
            //             duration: Appearance.animation.durations.normal
            //             easing.type: Easing.BezierSpline
            //             easing.bezierCurve: Appearance.animation.curves.ease
            //         }
            //     }

            //     Behavior on implicitHeight {
            //         NumberAnimation {
            //             duration: Appearance.animation.durations.normal
            //             easing.type: Easing.BezierSpline
            //             easing.bezierCurve: Appearance.animation.curves.ease
            //         }
            //     }

            //     Component.onCompleted: {
            //         topMargin: BorderConfig.thickness
            //         rightMargin: BorderConfig.thickness
            //         bottomMargin: BorderConfig.thickness
            //         leftMargin: BorderConfig.thickness

            //         if (position == "right" || position == "left") {
            //             bottomMargin: frameBottom.implicitHeight + BorderConfig.thickness + BorderConfig.panelsPadding
            //             topMargin: frameTop.implicitHeight + BorderConfig.thickness + BorderConfig.panelsPadding
            //         } else if (position == "top" || position == "bottom") {
            //             leftMargin: frameLeft.implicitWidth + BorderConfig.thickness + BorderConfig.panelsPadding
            //             rightMargin: frameRight.implicitWidth + BorderConfig.thickness + BorderConfig.panelsPadding
            //         }

            //         if (["left", "top", "bottom"].includes(position)) drawer.anchors.left = drawer.parent.left;
            //         if (["right", "top", "bottom"].includes(position)) drawer.anchors.right = drawer.parent.right;
            //         if (["top", "right", "left"].includes(position)) drawer.anchors.top = drawer.parent.top;
            //         if (["bottom", "right", "left"].includes(position)) drawer.anchors.bottom = drawer.parent.bottom;
            //     }
            // }

            // BorderHoverHandler {
            //     position: 'top'
            //     onHoveredChanged: frameTop.implicitHeight = hovered ? frameTop.child.implicitHeight : 0
            //     height: BorderConfig.thickness * 2 + frameTop.implicitHeight
            // }

            // BorderHoverHandler {
            //     position: 'bottom'
            //     onHoveredChanged: frameBottom.implicitHeight = hovered ? frameBottom.child.implicitHeight : 0
            //     height: BorderConfig.thickness * 2 + frameTop.implicitHeight
            // }

            // BorderHoverHandler {
            //     position: 'left'
            //     onHoveredChanged: frameLeft.implicitWidth = hovered ? frameLeft.child.implicitWidth : 0
            //     width: BorderConfig.thickness * 2 + frameLeft.implicitWidth
            // }

            // BorderHoverHandler {
            //     position: 'right'
            //     onHoveredChanged: frameRight.implicitWidth = hovered ? frameRight.child.implicitWidth : 0
            //     width: BorderConfig.thickness * 2 + frameRight.implicitWidth
            // }
        }

        Exclusions {
            id: frameExclusions
            screen: modelData
            topContent: frameTop
            rightContent: frameRight
            bottomContent: frameBottom
            leftContent: frameLeft
            leftContentGrowExclusions: false
            rightContentGrowExclusions: false
            bottomContentGrowExclusions: false
        }
    }
    // }
}
