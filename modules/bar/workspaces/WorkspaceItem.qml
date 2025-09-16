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

    property var ws: Hypr.hyprWorkspaces?.find(ws => ws.id === modelData)
    property var wsInfo: Hypr.workspacesInfo?.find(ws => ws.wsId === modelData)
    property bool wsFocused: ws?.focused ?? false
    property var icons: wsInfo?.icons ?? []
    // onIconsChanged: console.log(icons)

    signal focused(component: Item)

    onWsFocusedChanged: {
        if (wsFocused) focused(root);
        updateActiveComponent()
    }

    // opacity: !wsFocused
    // scale: !wsFocused ? 1 : 0.6
    Behavior on opacity {ExprAnim {}}
    Behavior on scale {ExprAnim {}}
    color: "#00FFFFFF"
    readonly property string lastObjectIcon: wsInfo?.lastObjectIcon ?? ""
    readonly property int targetWidth: stack.implicitWidth
    readonly property int targetHeight: stack.implicitHeight

    implicitHeight: stack.implicitHeight
    implicitWidth: stack.implicitWidth
    Behavior on implicitWidth {ExprAnim {}}
    clip: true

    StackView {
        id: stack
        initialItem: emptyWorkspace
        implicitWidth: currentItem?.implicitWidth ?? 0
        implicitHeight: currentItem?.implicitHeight ?? 0

        pushExit: Transition {
            NumberAnimation {
                properties: "scale,opacity"
                from: 1
                to: 0.4
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
        const transition = StackView.PushTransition //StackView.Immediate
        if (!ws || root.ws?.toplevels?.values.length === 0) {
            if (stack.currentItem != emptyWorkspace) {
                stack.clear(transition)
                stack.push(emptyWorkspace);
            }
        }
        else if (ws.focused) {
            if (stack.currentItem != allCategoryIcons) {
                stack.clear(transition)
                stack.push(allCategoryIcons);
            }
        }
        else {
            if (stack.currentItem != lastObjectIcon) {
                stack.clear(transition)
                stack.push(lastObjectIcon);
            }
        }
    }

    Component.onCompleted: {
        updateActiveComponent()
    }

    Component {
        id: emptyWorkspace
        Item {
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
        id: lastObjectIcon
        Item {
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
            leftMargin: Config.appearance.padding.medium * root.icons.length > 0
            rightMargin: Config.appearance.padding.medium * root.icons.length > 0
            RowLayout {
                id: layout
                spacing: 0
                Repeater {
                    model: root.icons
                    Rectangle {
                        required property string modelData
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                        opacity: 0
                    }
                }
            }
        }
    }
    component ExprAnim: MD.M3SpringAnimation { speed: "fast"; category: "effects" }
}
