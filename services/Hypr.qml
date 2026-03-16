pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import qs.services
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland

// Hyprland service to have everything custom in one place
Singleton {
  id: root
  readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
  readonly property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace

  property int desiredWsDisplayCount: 5
  readonly property var desiredWorkspacesList: updateDesiredWorkspaces(workspaces)

  readonly property var activeApp: ToplevelManager.activeToplevel ?? {}
  readonly property string activeAppTitle: activeApp?.title ?? ""

  function updateDesiredWorkspaces(workspaces) {
    const desiredSizeArray = Array.from({
      length: desiredWsDisplayCount
    }, (_, index) => index + 1);

    const workspacesOutsideRange = workspaces.filter(ws => !desiredSizeArray.includes(ws.id));

    let result = [];
    for (const id of desiredSizeArray) {
      const matchingWorkspace = workspaces.find(ws => ws.id === id);
      if (matchingWorkspace) {
        result.push(matchingWorkspace);
      } else {
        result.push({
          name: id.toString(),
          id: id,
          isEmpty: true
        });
      }
    }
    for (const ws of workspacesOutsideRange) {
      result.push(ws);
    }
    return result;
  }

  function goToWorkspace(id) {
    Hyprland.dispatch(`workspace ${id}`);
  }
}
