pragma ComponentBehavior: Bound
import QtQuick
pragma Singleton
import Quickshell
import Quickshell.Hyprland
import qs.service

Singleton {
    id: root
    property int minWorkspacesCount: 6

    readonly property list<HyprlandWorkspace> hyprWorkspaces: Hyprland.workspaces.values

    // Using only ids in models because it doesn't update whole model on every change
    // For example: Updating whole model caused sudden shift by x coord
    readonly property var wsIds: {
        let ids = hyprWorkspaces.map(ws => ws.id)
        for (let i = 1; i < minWorkspacesCount + 1; i++) {
            if (ids.find(id => id === i)) continue;
            if (ids.length >= minWorkspacesCount) break;
            ids.push(i)
        }
        ids = [...new Set(ids)]

        return ids.sort((a, b) => a - b)
    }
    readonly property var workspacesInfo: {
        let wsList = hyprWorkspaces.map(ws =>
            workspaceObject.createObject(root, {
                "wsId": ws.id,
                "workspace": ws,
            })
        );

        if (wsList.length >= minWorkspacesCount) return wsList;

        for (let i = 1; i < minWorkspacesCount + 1; i++) {
            if (wsList.length >= minWorkspacesCount) break;

            const exists = wsList.find(ws => ws.wsId === i)
            if (exists) continue;
            else wsList.push(workspaceObject.createObject(root, {"wsId": i}))
        }

        return wsList.sort((a, b) => a.wsId - b.wsId);
    }


    Component {
        id: workspaceObject
        Workspace {}
    }

    function getAppIconsByWorkspace(ws) {
        if (!ws || !ws.toplevels) return []


        return [...new Set(ws.toplevels.values.map(tl => {
            if (!tl) return ""
            const appId = tl?.wayland?.appId ?? ""
            const entry = DesktopEntries.byId(appId)
            const categories = entry?.categories ?? []
            const filteredCaterogies = IconMatcher.filterCategories(categories)
            const icon = IconMatcher.iconForCategory(filteredCaterogies)
            return icon
        }))]
    }

    function getWorkspaceById(wsId) {
        return root.hyprWorkspaces.find(ws => ws.id === wsId)
    }

    component Workspace: QtObject {
        id: workspaceComponent
        property int wsId: -1
        property HyprlandWorkspace workspace: null
        readonly property list<HyprlandToplevel> toplevels: workspace?.toplevels.values ?? []
        readonly property var categories: toplevels.map(tl => {
            return getToplevelCategories(tl)
        })
        property var wsLastIpcObject: workspace?.lastIpcObject ?? {}


        readonly property var lastObjectIcon: {
            const toplevel = Hyprland.toplevels?.values?.find(tl => tl?.title === wsLastIpcObject?.lastwindowtitle)
            if (!toplevel) return ""

            const categories = getToplevelCategories(toplevel)
            const filteredCategories = IconMatcher.filterCategories(categories)
            const icon = IconMatcher.firstIconForCategories(filteredCategories)
            return icon
        }

        readonly property Connections _connections: Connections {
            target: Hyprland
            function onRawEvent(event) {
                if (!event.name.includes("window")) {
                    return
                }
                workspaceComponent._updateTimer.restart()
            }
        }
        readonly property Timer _updateTimer: Timer {
            interval: 150
            onTriggered: {
                Hyprland.refreshWorkspaces()
            }
        }

        readonly property var icons: [...new Set(toplevels.map(tl => {
                const categories = getToplevelCategories(tl)
                const filteredCategories = IconMatcher.filterCategories(categories)
                const icon = IconMatcher.firstIconForCategories(filteredCategories)
                return icon
            })
        )]
        function getToplevelCategories(toplevel) {
            const appId = toplevel?.wayland?.appId ?? ""
            if (!appId) return []
            const entry = DesktopEntries.byId(appId)
            return entry.categories
        }

        Component.onCompleted: {
            Hyprland.refreshWorkspaces()
        }
    }
}
