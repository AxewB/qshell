import QtQuick as QQ
import qs.components.material as MD
import qs.service
import qs.config

MD.CircularProgressBar {
    id: root
    readonly property real progress: {
        if (!MediaService?.progress || MediaService?.progress === "Infinity") return 1
        else return MediaService?.progress
    }
    readonly property bool playing: MediaService?.currentPlayer?.isPlaying ?? false

    min: 0
    max: 1
    value: root.progress
    wave: root.playing

    PlayingIcon {
        opacity: !root.playing
        scale: !root.playing ? 1 : 0.6
        icon: "play_arrow"
    }
    PlayingIcon {
        opacity: root.playing
        scale: root.playing ? 1 : 0.6
        icon: "pause"
    }

    component PlayingIcon: MD.Icon {
        anchors.centerIn: parent
        fill: 1
        QQ.Behavior on scale {
            MD.M3SpringAnimation {
                speed: "fast"
                category: "spatial"
            }
        }
        QQ.Behavior on opacity {
            MD.M3SpringAnimation { }
        }
    }
}
