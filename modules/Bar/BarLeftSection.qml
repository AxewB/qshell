import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"
import "root:/modules"


Item {
    implicitHeight: content.implicitHeight
    Layout.fillHeight: true
    Layout.fillWidth: true

    // Цвет фона секции
    // Можно сделать "парящие" секции или что-нибудь такое
    RowLayout {
        id: content
        anchors.fill: parent
        height: parent.height
        layoutDirection: Qt.LeftToRight
        spacing: 0

        // Rectangle {
        //     anchors.fill: parent
        // }

        Item {
            id: leftContent
            implicitHeight: leftContentLeft.implicitHeight
            Layout.fillWidth: true

            RowLayout {
                id: leftContentLeft
                anchors.left: parent.left
                layoutDirection: Qt.LeftToRight
                spacing: 0

                Weather {}

            }
        }
        Item {
            id: rightContent
            implicitHeight: leftContentRight.implicitHeight
            Layout.fillWidth: true

            RowLayout {
                id: leftContentRight
                anchors.right: parent.right
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Media { }
            }
        }

        // Text {
        //     text: Colors.palette.m3surface
        // }
        // Text {
        //     text: Colors.palette.m3background
        // }
    }
}
