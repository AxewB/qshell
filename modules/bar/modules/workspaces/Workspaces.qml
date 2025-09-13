import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.config
import qs.service
import qs.components

Item {
    id: root
    property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
    property int minWorkspacesCount: 8
    property var workspacesIds: {
        let wsList = workspaces.map(ws => ({
                "id": ws.id,
                "workspace": ws
            }));

        if (wsList.length > minWorkspacesCount) return;

        for (let i = 1; i < minWorkspacesCount + 1; i++) {
            if (wsList.find(ws => ws.id === i)) continue;
            else wsList.push({
                "id": i,
                "workspace": null
            });
        }

        return wsList.sort((a, b) => a.id - b.id);
    }

    implicitHeight: content.height
    implicitWidth: content.width

    WrapperRectangle {
        id: content
        color: Colors.palette.m3surfaceContainer
        radius: height / 2
        margin: Config.appearance.padding.smaller
        Row {
            spacing: Config.appearance.padding.normal

            Repeater {
                id: listView
                model: root.workspacesIds

                delegate: WorkspaceItem {}
            }
        }
    }
}
