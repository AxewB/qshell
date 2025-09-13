pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import qs.components
import qs.service
import qs.config

Item {
    id: root
    property bool debug: false

    default property Item child
    property var workingArea

    property int fillActivationWidht: arcSize
    property int arcSize: 40
    property color color: Colors.palette.m3surface

    property int itemX: 0
    property int itemY: 0
    readonly property int itemHeight: mainRect.height
    readonly property int itemWidth: mainRect.width
    property bool itemXLimit: false
    property bool itemYLimit: false

    // Behavior on itemX { Anim {} }
    // Behavior on itemY { Anim {} }

    onItemXChanged: checkXLimit()
    onItemYChanged: checkYLimit()
    Component.onCompleted: {
        checkXLimit()
        checkYLimit()
    }

    function checkXLimit() {
        if (!workingArea) return

        if (itemXLimit) {
            const min = workingArea.x
            const max = min + workingArea.width - mainRect.width
            itemX = Math.min(max, Math.max(min, root.itemX))
        }
    }
    function checkYLimit() {
        if (itemYLimit)  {
            const min = root.workingArea.y
            const max = workingArea.y + workingArea.height - mainRect.height
            itemY = Math.min(max, Math.max(min, root.itemY))
        }

    }

    Rectangle {
        id: areaRectangle
        x: root.workingArea.x ?? 0
        y: root.workingArea.y ?? 0
        height: root.workingArea.height ?? 0
        width: root.workingArea.width ?? 0
        opacity: 0

        Rectangle {
            id: mainRect
            parent: root
            x: root.itemX
            y: root.itemY
            color: root.color
            // radius: Config.appearance.radius.normal
            height: componentChildWrapper.height
            width: componentChildWrapper.width

            WrapperItem {
                id: componentChildWrapper
                child: root.child
            }
        }
    }


    Rectangle {
        id: leftIndicator
        x: root.workingArea.x
        y: mainRect.y + mainRect.height / 2  - height/2
        color: root.debug ? 'green' : "transparent"
        height: 10;
        width: mainRect.x - root.workingArea.x;
        z: 1

        GapFill {
            active: leftIndicator.width <= root.fillActivationWidht
            x: leftIndicator.x
            y: mainRect.y
            position: "left"
            height: mainRect.height
            width: leftIndicator.width
        }
    }


    Rectangle {
        id: rightIndicator
        x: mainRect.x + mainRect.width
        y: mainRect.y + mainRect.height / 2  - height/2
        color: root.debug ? 'red' : "transparent"
        height: 10;
        width: root.workingArea.width - leftIndicator.width - mainRect.width;

        GapFill {
            active: rightIndicator.width <= root.fillActivationWidht
            x: rightIndicator.x
            y: mainRect.y
            position: "right"
            height: mainRect.height
            width: rightIndicator.width
        }

    }

    Rectangle {
        id: topIndicator
        x: mainRect.x + mainRect.width / 2 - width / 2
        y: root.workingArea.y
        color: root.debug ? 'orange' : "transparent"
        height: mainRect.y - root.workingArea.y;
        width: 10

        GapFill {
            active: topIndicator.height <= root.fillActivationWidht
            x: mainRect.x
            y: topIndicator.y
            position: "top"
            height: topIndicator.height
            width: mainRect.width
        }
    }

    Rectangle {
        id: bottomIndicator
        x: mainRect.x + mainRect.width / 2 - width / 2
        y: mainRect.y + mainRect.height
        color: root.debug ? 'blue' : "transparent"
        height: root.workingArea.height - topIndicator.height - mainRect.height
        width: 10

        GapFill {
            active: bottomIndicator.height <= root.fillActivationWidht
            x: mainRect.x
            y: bottomIndicator.y
            position: "bottom"
            height: bottomIndicator.height
            width: mainRect.width
        }
    }

    // Top Left
    CornerFiller {
        active: topIndicator.height <= root.fillActivationWidht && leftIndicator.width <= root.fillActivationWidht
        targetWidth: mainRect.x
        targetHeight: topIndicator.height
    }

    // Top Right
    CornerFiller {
        active: topIndicator.height <= root.fillActivationWidht && rightIndicator.width <= root.fillActivationWidht
        x: mainRect.x + mainRect.width
        targetWidth: rightIndicator.width
        targetHeight: topIndicator.height
    }

    // Bottom Left
    CornerFiller {
        active: bottomIndicator.height <= root.fillActivationWidht && leftIndicator.width <= root.fillActivationWidht
        x: root.workingArea.x
        y: mainRect.y + mainRect.height
        targetWidth: mainRect.x
        targetHeight: bottomIndicator.height
        z: -10
    }

    // Bottom Right
    CornerFiller {
        active: bottomIndicator.height <= root.fillActivationWidht && rightIndicator.width <= root.fillActivationWidht
        x: mainRect.x + mainRect.width
        y: mainRect.y + mainRect.height
        targetWidth: rightIndicator.width
        targetHeight: bottomIndicator.height
    }

    component CornerFiller: Rectangle {
        property bool active
        property int targetWidth
        property int targetHeight
        opacity: active
        color: root.color
        x: root.workingArea.x
        y: root.workingArea.y

        // width: active ? targetWidth : 0
        // height: active ? targetHeight : 0

        width: targetWidth
        height: targetHeight
        // Behavior on opacity {Anim {}}
        z: -10
    }


    component GapFill: Item {
        id: gapFillComponent
        property bool active: false
        parent: root
        z: -1
        opacity: active
        property string position: "left" // "right" | "top" | "bottom"

        property real progress: 1 - (position === "left" || position === "right" ? width : height) / root.fillActivationWidht
        rotation: position === "left" || position === "top" ? 0 : 180

        // Behavior on opacity {Anim {}}

        Shape {
            visible: gapFillComponent.position === "left" || gapFillComponent.position === "right"
            anchors.fill: parent
            antialiasing: true

            ShapePath {
                id: pathH
                strokeWidth: 0

                fillColor: root.color

                startX: 0
                startY: -root.arcSize
                PathArc {
                    id: firstArcH
                    radiusX: gapFillComponent.width + root.arcSize
                    radiusY: root.arcSize
                    x: gapFillComponent.width + root.arcSize
                    y: 0
                    direction: PathArc.Counterclockwise
                }

                PathLine {
                    x: gapFillComponent.width + root.arcSize
                    y: gapFillComponent.height
                }

                PathArc {
                    radiusX: firstArcH.radiusX
                    radiusY: root.arcSize
                    x: 0
                    y: gapFillComponent.height + root.arcSize
                    direction: PathArc.Counterclockwise
                }

                PathLine {
                    x: 0
                    y: -root.arcSize
                }
            }
        }

        Shape {
            visible: gapFillComponent.position === "top" || gapFillComponent.position === "bottom"
            anchors.fill: parent
            antialiasing: true

            ShapePath {
                id: path
                strokeWidth: 0

                fillColor: root.color

                startX: -root.arcSize
                startY: 0

                PathArc {
                    id: firstArc
                    radiusX: root.arcSize
                    radiusY: gapFillComponent.height + root.arcSize
                    x: 0
                    y: gapFillComponent.height + root.arcSize
                    direction: PathArc.Clockwise
                }
                PathLine {
                    x: gapFillComponent.width
                    y: gapFillComponent.height + root.arcSize
                }

                PathArc {
                    radiusX: firstArc.radiusX
                    radiusY: firstArc.radiusY
                    x: gapFillComponent.width + root.arcSize
                    y: 0
                    direction: PathArc.Clockwise
                }

                PathLine {
                    x: -root.arcSize
                    y: 0
                }
            }
        }
    }

    component Arc: Rectangle {
        id: arcComponent
        width: root.arcSize
        height: root.arcSize
        color: "transparent"
        opacity: 0
        Shape {
            antialiasing: true
            anchors.fill: parent
            layer.enabled: true
            layer.samples: 2
            ShapePath {
                strokeWidth: 0
                fillColor: root.color

                PathLine { x: 0; y: 0 }
                PathArc {
                    x: arcComponent.width; y: arcComponent.height
                    radiusX: arcComponent.width; radiusY: arcComponent.height
                    direction: PathArc.Counterclockwise
                }
                PathLine { x: arcComponent.width; y: arcComponent.height }
                PathLine { x: 0; y: arcComponent.height }
            }
        }
    }


    // component Anim: NumberAnimation {
    //     duration: Appearance.animation.durations.normal ?? 100
    //     easing.type: Easing.BezierSpline
    //     easing.bezierCurve: Appearance.animation.curves.bounce
    // }


    Loader {
        active: root.debug

        sourceComponent: Variants {
            model: Quickshell.screens

            PanelWindow {
                required property ShellScreen modelData
                screen: modelData
                color: "transparent"
                aboveWindows: true
                WlrLayershell.exclusionMode: ExclusionMode.Ignore
                WlrLayershell.layer: WlrLayer.Bottom
                // WlrLayershell.layer: WlrLayer.Overlay
                anchors {
                    top: true
                    bottom: true
                    right: true
                    left: true
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPositionChanged: {
                        root.itemX = mouse.x
                        root.itemY = mouse.y
                    }
                }
            }
        }
    }
}
