pragma Singleton

import Quickshell
import Quickshell.Io
import Qt.labs.platform

Singleton {
    id: root

    // generic directories
    readonly property url home: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
    readonly property url pictures: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]

    // config directories
    readonly property url config: `${StandardPaths.standardLocations(StandardPaths.GenericConfigLocation)[0]}/axewbshell`
    readonly property url icons: `${StandardPaths.standardLocations(StandardPaths.GenericConfigLocation)[0]}/axewbshell/icons`

    // config files
    readonly property url theme: `${StandardPaths.standardLocations(StandardPaths.GenericConfigLocation)[0]}/axewbshell/theme.json`
    readonly property url wallpaper: `${StandardPaths.standardLocations(StandardPaths.GenericConfigLocation)[0]}/axewbshell/wallpaper.json`

    function mkdir(path: url): void {
        mkdirProc.path = path.toString().replace("file://", "");
        mkdirProc.startDetached();
    }

    Process {
        id: mkdirProc

        property string path

        command: ["mkdir", "-p", path]
    }
}
