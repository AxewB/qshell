pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property list<string> activeVpnConnections: []

  function disconnectAllVpns() {
    console.log("disconnecting all vpns")

    for (const con of root.activeVpnConnections) {
      console.log(`disconnecting ${con} vpn`)
      Quickshell.execDetached(["sh", "-c", `nmcli connection down ${con}`])
    }

    activeVpnConnectionsProcess.running = true;
  }

  Process {
    id: activeVpnConnectionsProcess
    running: true
    command: ["sh", "-c", "nmcli --mode tabular --terse connection show --active | grep vpn | cut -d ':' -f1"]

    stdout: StdioCollector {
      onStreamFinished: {
        const lines = text.split('\n').filter(line => line.trim());
        root.activeVpnConnections = lines
      }
    }
  }

  Timer {
    id: activeVpnConnectionsTimer
    interval: 1000
    running: true
    repeat: true

    onTriggered: {
      activeVpnConnectionsProcess.running = true
    }
  }
}
