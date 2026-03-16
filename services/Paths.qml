pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Qt.labs.platform

Singleton {
  id: root

  // directories
  property url home: `${StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]}`
  property url cache: `${StandardPaths.standardLocations(StandardPaths.CacheLocation)[0]}/minsh`
  property url config: `${home}/.config/quickshell/minsh`
  property url wallpapers: `${home}/Pictures/Wallpapers`

  // files
  property url colorscheme: `${cache}/colorscheme.json`
  property url current: `${cache}/wallpaper`
}
