pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    property MprisPlayer player: Mpris.players.values[0]

    function switchPlayer(direction: string) {
        let players = Mpris.players.values;
        if (players.length <= 1)
            return;

        let currentIndex = players.indexOf(root.player);

        if (direction === "next") {
            currentIndex = (currentIndex + 1) % players.length;
        }

        if (direction === "prev") {
            currentIndex = (currentIndex - 1 + players.length) % players.length;
        }

        root.player = players[currentIndex];
    }

    function prevPlayer() {
        if (Mpris.players.length <= 1)
            return;
        var currentIndex = Mpris.players.indexOf(player);
        currentIndex = (currentIndex - 1 + Mpris.players.length) % Mpris.players.length;
        player = Mpris.players[currentIndex];
    }
}
