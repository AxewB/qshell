
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/config"
import "root:/utils"
import "root:/components"
import "./Tray"

Item {
    id: root
    property int padding: Appearance.padding.huge

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }
    implicitHeight: contentWrapper.implicitHeight

    WrapperItem {
        id: contentWrapper

        anchors.fill: parent
        margin: root.padding

        RowLayout {
            id: content
            anchors.fill: parent
            spacing: root.padding

            BarLeftSection {}
            BarCenterSection {}
            BarRightSection {}
        }
    }
}

// Scope {
//     id: root
//     Variants {
//         model: Quickshell.screens

//         PanelWindow {
//             required property var modelData
//             screen: modelData
//             color: "transparent"

//             anchors {
//                 left: true
//                 right: true
//                 top: true
//             }

//             // Обязательно нужно добавлять "padding", который внутренний margin
//             implicitHeight: contentWrapper.implicitHeight

//             StyledRectangle {
//                 anchors.fill: parent
//                 color: Colors.palette.m3background
//                 // color: Colors.palette.m3onSurface
//             }

//             // Все размеры буквально зависят от внутренностей. Каждый `Item`
//             // имеет свойство `implicitHeight`, которое вручную прописывается на
//             // основе размера внутреннего `RowLayout`.
//             WrapperItem {
//                 id: contentWrapper

//                 anchors.fill: parent
//                 margin: Appearance.padding.normal

//                 RowLayout {
//                     id: content
//                     anchors.fill: parent
//                     spacing: Appearance.padding.normal

//                     BarLeftSection {}
//                     BarCenterSection {}
//                     BarRightSection {}
//                 }
//             }
//         }

//     }
// }
