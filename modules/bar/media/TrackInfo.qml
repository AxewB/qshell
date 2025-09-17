pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Qt.labs.animation
import qs.components.common as Common
import qs.service

Item {
    id: root
    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth
    readonly property string title: MediaService.trackTitle
    readonly property string artist: MediaService.trackArtist
    readonly property int maxTextWidth: 120


    // TODO: make animated text component that will do something cool when `property text` is changed
    ColumnLayout {
        id: content
        spacing: 0

        Common.Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.maximumWidth: root.maxTextWidth
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            visible: root.title
            text: root.title
            type: "body"
            font.weight: Font.Bold

        }
        Common.Text {
            visible: root.artist
            Layout.maximumWidth: root.maxTextWidth
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            Layout.alignment: Qt.AlignHCenter
            text: root.artist
            type: "label"
            color: Colors.palette.m3onSurfaceVariant
        }
    }

}
