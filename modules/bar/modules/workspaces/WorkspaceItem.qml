pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.components
import qs.config
import qs.service
import qs.utils

WrapperItem {
    id: root

    required property var modelData

    property HyprlandWorkspace workspace: modelData.workspace ?? null
    property list<HyprlandToplevel> toplevels: Hyprland.toplevels.values.filter(
        tl => tl.workspace?.id == workspace?.id
    )
    property list<var> toplevelsIcons: toplevels.map((tl, index) => {
        const appId = tl.wayland.appId
        const entry = DesktopEntries.byId(appId)
        const iconPath = Quickshell.iconPath(entry.icon)

        return {
            "entry": entry,
            "icon": iconPath,
            "activated": tl.activated
        }
    })

    property list<string> iconsPaths: Quickshell.env("XDG_DATA_DIRS").split(":").map(str => str + "/")


    Loader {
        id: contentLoader
        sourceComponent: root.toplevelsIcons.length > 0 ? workspaceToplevelsIcons : workspacePlaceholder
    }

    Component {
        id: workspaceToplevelsIcons
        WrapperRectangle {
            radius: height / 2
            color: Colors.palette.m3surfaceContainerHighest
            WrapperMouseArea {
                onClicked: Hyprland.dispatch(`workspace ${root.modelData.id}`)
                Row {
                    spacing: 0

                    Repeater {
                        model: ScriptModel { values: root.toplevelsIcons }
                        delegate: WrapperItem {
                            id: wsButton
                            required property var modelData
                            implicitHeight: Config.appearance.icon.normal
                            implicitWidth: Config.appearance.icon.normal
                            // Center the scaling animation
                            transformOrigin: Item.Center
                            AppIcon {
                                toplevelActivated: modelData.activated
                                source: Qt.resolvedUrl(modelData.icon) ?? ""
                            }
                        }
                    }
                }
            }
        }
    }
    Component {
        id: workspacePlaceholder
        WrapperMouseArea {
            onClicked: Hyprland.dispatch(`workspace ${root.modelData.id}`)
            Item {
                implicitHeight: Config.appearance.icon.normal
                implicitWidth: Config.appearance.icon.normal
                StyledText {
                    x: parent.implicitWidth / 4
                    y: parent.implicitHeight / 4 - 1
                    color: root.workspace?.active ? Colors.palette.m3surfaceTint : Colors.palette.m3surfaceVariant
                    text: root.modelData.id
                }
            }
        }
    }

    component AppIcon: ClippingWrapperRectangle {
        id: appIconComponent
        property alias source: iconImage.source
        property bool toplevelActivated

        radius: height / 2
        color: root.workspace.active && toplevelActivated ? Colors.palette.m3surfaceTint : "transparent"
        margin: Config.appearance.padding.small

        IconImage {
            id: iconImage

            MultiEffect {
                source: parent
                anchors.fill: parent

                colorization: 0
                colorizationColor: Colors.palette.m3onSurface
            }
        }
    }

    component Anim: NumberAnimation {
        duration: Config.appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Config.appearance.animation.curves.ease
    }
}
