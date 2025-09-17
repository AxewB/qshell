pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell
import qs.service
import qs.config
import qs.components.material as MD

// TODO: move some settings to config
Rectangle {
    id: root

    property var workspaces: Hypr.workspaces

    implicitHeight: wrapper.implicitHeight
    implicitWidth: wrapper.implicitWidth

    color: Colors.palette.m3surfaceContainer
    radius: height / 2


    Rectangle {
        id: activeIndicator
        property Item target: null
        property int targetIndex: 0

        property int prevTargetIndex: 0
        property int movingDirection: 0
        onTargetIndexChanged: {
            if (targetIndex === prevTargetIndex) movingDirection = 0
            if (targetIndex > prevTargetIndex) movingDirection = 1
            if (targetIndex < prevTargetIndex) movingDirection = -1
            prevTargetIndex = targetIndex
        }



        visible: target ?? false
        anchors.verticalCenter: parent.verticalCenter
        clip: true

        color: Colors.palette.m3primary
        radius: height / 2

        implicitWidth: target?.targetWidth ?? 0
        implicitHeight: target?.targetHeight ?? 0

        x: targetIndex * 32 + wrapper.margin//target?.x + wrapper.margin

        Behavior on x {
            ExprAnim {
                speed: "normal"
                category: "spatial"
            }
        }
        Behavior on implicitWidth {
            ExprAnim {
                speed: "fast"
                category: "effects"
            }
        }

        Row {
            id: indicatorContent
            anchors.verticalCenter: parent.verticalCenter
            property var icons: activeIndicator.target?.icons ?? []
            leftPadding: Config.appearance.padding.medium * icons.length > 1
            rightPadding: Config.appearance.padding.medium * icons.length > 1
            spacing: 0

            add: Transition {
                ExprAnim {
                    speed: "fast"
                    category:"effects"
                    properties: "scale,opacity"; from: 0; to: 1
                }
            }

            Item {
                visible: indicatorContent.icons.length == 0
                implicitWidth: 32
                implicitHeight: 32

                MD.Icon {
                    anchors.centerIn: parent
                    icon: IconMatcher.placeholder
                    size: Config.appearance.icon.size.medium
                    color: Colors.palette.m3onPrimary
                }
            }

            Repeater {
                model: ScriptModel {
                    values: indicatorContent.icons
                }
                Item {
                    required property string modelData
                    implicitWidth: 32
                    implicitHeight: 32

                    MD.Icon {
                        anchors.centerIn: parent
                        icon: modelData
                        size: Config.appearance.icon.size.medium
                        color: Colors.palette.m3onPrimary
                        fill: 1
                    }
                }
            }
        }
        z: 1
    }

    WrapperItem {
        id: wrapper
        margin: Config.appearance.padding.medium

        RowLayout {
            id: layout
            spacing: 0

            Repeater {
                id: repeater
                model: Hypr.wsIds

                WorkspaceItem {
                    onFocused: {
                        activeIndicator.target = repeater.itemAt(index)
                        activeIndicator.targetIndex = index
                    }
                }
            }
        }
    }

    component ExprAnim: MD.M3SpringAnimation {
        category: "spatial"
    }
    component CAnim: MD.M3ColorAnimation { speed: "short" }
}
