pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.components
import qs.services

MinshWrapperRectangle {
  id: root

  readonly property bool isPlaying: MprisService.isPlaying
  readonly property string trackArtist: MprisService.trackArtist
  readonly property string trackTitle: MprisService.trackTitle
  readonly property string trackArtUrl: MprisService.trackArtUrl

  RowLayout {
    MediaInfo {}
    MediaButtons {}
  }

  // // // // // components

  component MediaButton: WrapperMouseArea {
    property alias icon: mediaButtonIcon.icon

    MinshIcon {
      id: mediaButtonIcon
      size: 20
    }
  }

  component MediaButtons: RowLayout {
    MediaButton {
      icon: "skip_previous"
      onClicked: MprisService.previous()
    }

    MediaButton {
      icon: root.isPlaying ? "pause" : "play_arrow"
      onClicked: root.isPlaying ? MprisService.pause() : MprisService.play()
    }

    MediaButton {
      icon: "skip_next"
      onClicked: MprisService.next()
    }
  }

  component MediaImage: ClippingWrapperRectangle {
    Layout.preferredHeight: 20
    Layout.preferredWidth: 20
    color: "transparent"
    radius: 4

    Image {
      anchors.fill: parent
      source: root.trackArtUrl
      onSourceChanged: {
        console.log(source);
      }
    }
  }
  component MediaInfo: WrapperMouseArea {
    RowLayout {
      MediaImage {}

      MinshText {
        Layout.maximumWidth: 80
        text: root.trackArtist
      }

      MinshText {
        Layout.maximumWidth: 80
        text: (root.trackTitle ? " - " + root.trackTitle : "")
      }
    }

    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: (event) => {
      if (event.button == Qt.LeftButton) MprisService.nextPlayer()
      if (event.button == Qt.RightButton) MprisService.previousPlayer()
    }
  }

}
