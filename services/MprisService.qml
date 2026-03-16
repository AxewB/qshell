pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
  id: root

  readonly property list<MprisPlayer> players: Mpris.players.values
  property int activePlayerIndex: 0
  readonly property MprisPlayer activePlayer: players[activePlayerIndex]
  
  onActivePlayerChanged: {
    console.log(activePlayer)
  }

  onActivePlayerIndexChanged: {
    console.log(activePlayerIndex)
  }


  readonly property bool isPlaying: activePlayer?.isPlaying ?? false
  readonly property string trackArtist: activePlayer?.trackArtist ?? ""
  readonly property string trackTitle: activePlayer?.trackTitle ?? ""
  readonly property string trackArtUrl: activePlayer?.trackArtUrl

  function nextPlayer() {
    let nextIndex = root.activePlayerIndex + 1
    root.setPlayerIndex(nextIndex)
  }

  function previousPlayer() {
    let prevIndex = root.activePlayerIndex - 1
    root.setPlayerIndex(prevIndex)
  }

  function setPlayerIndex(newIndex) {
    let maxPlayerIndex = root.players.length - 1
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

  function seek(offset) {
    root.activePlayer.seek(offset)
  }

  function play() {
    root.activePlayer.play()
  }

  function pause() {
    root.activePlayer.pause()
  }

  function stop() {
    root.activePlayer.stop()
  }

  function togglePlaying() {
    root.activePlayer.togglePlaying()
  }
}
