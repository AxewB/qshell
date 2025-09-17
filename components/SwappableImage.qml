import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.service
import qs.config
import qs.components


Rectangle {
    id: root
    property string source: ""
    property string current: ""
    property string previous: ""
    property var currentImageContainer: one

    color: "transparent"

    ImageContainer { id: one }
    ImageContainer { id: two }

    component ImageContainer: Image {
        anchors.fill: parent
        opacity: root.currentImageContainer === this ? 1 : 0
        scale: root.currentImageContainer === this ? 1.0 : 1.05
        source: root.currentImageContainer === this ? root.current : root.previous
        fillMode: Image.PreserveAspectCrop
    }

    function updateImage() {
        root.previous = root.current
        root.current = root.source
        root.currentImageContainer = (root.currentImageContainer === one) ? two : one
    }

    onSourceChanged: updateImage()
}
