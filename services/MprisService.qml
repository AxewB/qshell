pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
  id: root

  readonly property list<MprisPlayer> players: Mpris.players.values
  readonly property int activePlayerIndex: 0
  readonly property MprisPlayer activePlayer: players[0]

  readonly property string trackArtist: activePlayer?.trackArtist ?? ""
  readonly property string trackTitle: activePlayer?.trackTitle ?? ""
  readonly property string trackArtUrl: activePlayer?.trackArtUrl

  function nextPlayer() {
    let maxPlayerIndex = root.players.length
    let nextIndex = root.activePlayerIndex + 1

    root.setPlayerIndex(nextIndex)
  }

  function previousPlayer() {
    let maxPlayerIndex = root.players.length
    let prevIndex = root.activePlayerIndex - 1

    root.setPlayerIndex(prevIndex)
  }

  function setPlayerIndex(newIndex) {
    root.activePlayerIndex = Math.max(0, Math.min(newIndex, maxPlayerIndex))
  }


  //
  // player actions
  //

  function next() {
    root.activePlayer.next()
  }

  function previous() {
    root.activePlayer.previous()
  }

  function pause() {
    root.activePlayer.pause()
  }

  function seek(offset) {
    root.activePlayer.seek(offset)
  }

  function stop() {
    root.activePlayer.stop()
  }

  function togglePlaying() {
    root.activePlayer.togglePlaying()
  }
}
