pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Singleton {
  id: root
  property string cpu: ""
  property string ram: ""

  Process {
    id: cpuProc
    running: true
    command: ["sh", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print $2/100}' | cut -d'%' -f1"]
    stdout: StdioCollector {
      onStreamFinished: root.cpu = this.text
    }
  }
  Process {
    id: ramProc
    running: true
    command: ["sh", "-c", "free -m | awk '/Mem/{printf \"%.1f\", $3/$2}'"]
    stdout: StdioCollector {
      onStreamFinished: root.ram = this.text
    }
  }
  Timer {
    running: true
    repeat: true
    interval: 1000
    onTriggered: {
      ramProc.running = true
      cpuProc.running = true
    }
  }
}
// cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
// ram=$()
