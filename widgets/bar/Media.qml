import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.components
import qs.services

MinshWrapperRectangle {
  id: root

  readonly property string trackArtist: MprisService.trackArtist
  readonly property string trackTitle: MprisService.trackTitle
  readonly property string trackArtUrl: MprisService.trackArtUrl

  RowLayout {

    ClippingWrapperRectangle {
      Layout.preferredHeight: 16
      Layout.preferredWidth: 16
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

    RowLayout {
      MinshText {
        Layout.maximumWidth: 80
        text: root.trackArtist
      }

      MinshText {
        Layout.maximumWidth: 80
        text: (root.trackTitle ? " - " + root.trackTitle : "")
      }

    }

  }

}
