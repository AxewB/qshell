pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell
import qs.components.material as MD
import qs.config
import qs.service

Rectangle {
    id: root
    required property var modelData // ws id
    required property int index     // repeater index

    readonly property var ws: Hypr.hyprWorkspaces?.find(ws => ws.id === modelData)
    readonly property var wsInfo: Hypr.workspacesInfo?.find(ws => ws.wsId === modelData)
    readonly property var toplevels: wsInfo?.toplevels ?? []
    readonly property bool wsFocused: ws?.focused ?? false
    readonly property var icons: wsInfo?.icons ?? []

    readonly property string lastObjectIcon: wsInfo?.lastObjectIcon ?? ""
    readonly property int targetWidth: stack.implicitWidth
    readonly property int targetHeight: stack.implicitHeight

    onWsChanged: updateActiveComponent()
    onToplevelsChanged: updateActiveComponent()
    onWsInfoChanged: updateActiveComponent()


    signal focused(component: Item)

    opacity: !wsFocused
    scale: !wsFocused ? 1 : 0.6
    color: "#00FFFFFF"
    implicitHeight: stack.implicitHeight
    implicitWidth: stack.implicitWidth
    clip: true

    onWsFocusedChanged: {
        if (wsFocused) focused(root);
        updateActiveComponent()
    }

    Behavior on opacity {ExprAnim {}}
    Behavior on scale {ExprAnim {}}
    // onImplicitWidthChanged: console.log(implicitWidth)

    // content

    Behavior on implicitWidth {
        id: widthBehavior
        ExprAnim {}
    }
    StackView {
        id: stack
        initialItem: initComponent
        implicitWidth: currentItem?.implicitWidth ?? 0
        implicitHeight: currentItem?.implicitHeight ?? 0

        pushEnter: Transition {
            ExprAnim {
                properties: "opacity"
                from: 0.4
                to: 1
            }
        }

        pushExit: Transition {
            ExprAnim {
                properties: "opacity"
                from: 0.4
                to: 1
            }
        }
    }

    MouseArea {
        anchors.fill: root
        onClicked: {
            Hyprland.dispatch(`workspace ${root.modelData}`)
        }
    }

    function updateActiveComponent() {
        const transition = stack?.currentItem?.objectName === initComponent.objectName ? StackView.Immediate : StackView.PushTransition
        if (!ws || root.icons?.length === 0) {
            if (stack?.currentItem?.objectName !== emptyWorkspace?.objectName) {
                stack.clear(transition)
                stack.push(emptyWorkspace);
            }
        }
        else if (wsFocused) {
            if (stack?.currentItem?.objectName !== allCategoryIcons?.objectName) {
                stack.clear(transition)
                stack.push(allCategoryIcons);
            }
        }
        else {
            if (stack?.currentItem?.objectName !== lastObjectIconComponent?.objectName) {
                stack.clear(transition)
                stack.push(lastObjectIconComponent);
            }
        }
    }


    Component {
        id: initComponent
        Item {
            objectName: "initComponent"
            implicitHeight: 32
            implicitWidth: 32
        }
    }

    Component {
        id: emptyWorkspace
        Item {
            objectName: "emptyWorkspace"
            implicitHeight: 32
            implicitWidth: 32

            Rectangle {
                height: 8
                width: 8
                radius: height / 2
                anchors.centerIn: parent
                color: Colors.palette.m3surfaceVariant
            }
        }
    }

    Component {
        id: lastObjectIconComponent
        Item {
            objectName: "lastObjectIconComponent"
            implicitHeight: 32
            implicitWidth: 32

            MD.Icon {
                size: Config.appearance.icon.size.medium
                color: Colors.palette.m3onSurface
                anchors.centerIn: parent
                icon: root.lastObjectIcon
                animate: true
            }
        }
    }

    Component {
        id: allCategoryIcons
        WrapperItem {
            objectName: "allCategoryIcons"
            leftMargin: Config.appearance.padding.medium * root.icons.length > 1
            rightMargin: Config.appearance.padding.medium * root.icons.length > 1

            RowLayout {
                id: layout
                spacing: 0
                Repeater {
                    model: root.icons.length
                    Item {
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        updateActiveComponent()
    }

    component ExprAnim: MD.M3SpringAnimation { speed: "fast"; category: "effects" }
}
