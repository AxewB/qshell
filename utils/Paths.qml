pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Qt.labs.platform

Singleton {
    id: root
    property string shellName: "axewbshell"

    property url home:      `${StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]}`
    property url config:    `${StandardPaths.standardLocations(StandardPaths.GenericConfigLocation)[0]}/${shellName}`
    property url pictures:  `${StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]}`
    property url data:      `${StandardPaths.standardLocations(StandardPaths.GenericDataLocation)[0]}`
    property url cache:      `${StandardPaths.standardLocations(StandardPaths.GenericCacheLocation)[0]}`
}
