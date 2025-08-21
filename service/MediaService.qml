pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    property list<MprisPlayer> players: Mpris.players.values
    property MprisPlayer currentPlayer: players[0]
    property int position: currentPlayer.position
    property int length: currentPlayer.length
    property real progress: (position / length).toFixed(2)
    property string trackArtist: ""
    property string trackTitle: ""
    property string trackArtUrl: ""
    property real rate: currentPlayer.rate
    property real rateSupported: currentPlayer.minRate < 1 && currentPlayer.maxRate > 1

    onPlayersChanged: currentPlayer = players ? currentPlayer[0] : null

    onCurrentPlayerChanged: updateTrackData()


    Connections {
        target: currentPlayer

        function onTrackChanged() {
            updateTrackData()
        }
    }

    function switchLoopState() {
        if (!currentPlayer.loopSupported) return

        switch (currentPlayer.loopState) {
            case MprisLoopState.None:
                currentPlayer.loopState = MprisLoopState.Track
                return
            case MprisLoopState.Track:
                currentPlayer.loopState = MprisLoopState.Playlist
                return
            default:
                currentPlayer.loopState = MprisLoopState.None
                return
        }
    }

    // direction: "inc" | "dec"
    function shiftRate(direction) {
        if (direction !== "inc" && direction !== "dec") {
            console.log("Wrong rate shift direction in media player")
            return
        }
        const minRate = 0.25
        const maxRate = 5
        const shift = direction === "inc" ? 0.25 : -0.25
        const shiftedRate = currentPlayer.rate + shift
        const newRate = Math.max(minRate, Math.min(maxRate, shiftedRate))
        root.currentPlayer.rate = newRate
    }
    function resetRate() {root.currentPlayer.rate = 1}

    function shiftVolume(value) {
        const shiftedValue = root.currentPlayer.volume + value
        const newVolume = Math.max(0, Math.min(1, shiftedValue))
        root.currentPlayer.volume = newVolume
    }

    function updateTrackData() {
        if (players?.length === 0) {
            trackArtist = "Playing"
            trackTitle = "Nothing"
            return
        }
        Qt.callLater(() => {
            if (!currentPlayer.trackArtist && !currentPlayer.trackTitle) {
                trackArtist = currentPlayer.trackArtist ? currentPlayer.trackArtist : "-"
                trackTitle = currentPlayer.trackTitle ? currentPlayer.trackTitle : currentPlayer.identity
            }
            else {
                trackArtist = currentPlayer.trackArtist ? currentPlayer.trackArtist : ""
                trackTitle = currentPlayer.trackTitle ? currentPlayer.trackTitle : currentPlayer.identity
            }
            trackArtUrl =  currentPlayer.trackArtUrl ? currentPlayer.trackArtUrl : ""
        })
    }

    function setPlayer(player) { currentPlayer = player }

    // direction: next | prev
    function switchPlayer(direction: string) {
        let players = Mpris.players.values;
        if (players.length <= 1)
            return;

        let currentIndex = players.indexOf(root.currentPlayer);

        if (direction === "next") {
            currentIndex = (currentIndex + 1) % players.length;
        }

        if (direction === "prev") {
            currentIndex = (currentIndex - 1 + players.length) % players.length;
        }

        root.currentPlayer = players[currentIndex];
    }

    function prevPlayer() {
        if (Mpris.players.length <= 1)
            return;
        var currentIndex = Mpris.players.indexOf(currentPlayer);
        currentIndex = (currentIndex - 1 + Mpris.players.length) % Mpris.players.length;
        currentPlayer = Mpris.players[currentIndex];
    }

    function setPosition(fraction) {
        const newPos = fraction * root.length
        currentPlayer.position = newPos
    }

    Component.onCompleted: {
        updateTrackData()
    }
}
