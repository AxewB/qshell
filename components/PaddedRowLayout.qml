import QtQuick
import QtQuick.Layouts
import "root:/service"


// Все размеры буквально зависят от внутренностей. Каждый `Item`
// имеет свойство `implicitHeight`, которое вручную прописывается на
// основе размера внутреннего `RowLayout`.
//
// WIP // FIXME: хз, есть ли смысл доделывать это
Item {
    id: root

    property int padding: 0
    property int spacing: 0
    property color color: "transparent"
    property string align: "left" // center | right
    property Layout layout

    default property alias children: content.children

    implicitHeight: content.implicitHeight + root.padding
    Layout.fillHeight: true
    Layout.fillWidth: true

    Rectangle {
        anchors.fill: parent
        color: root.color
    }

    RowLayout{
        id: content
        anchors {
            left: root.align === "left" ? parent.left : undefined
            right: root.align === "right" ? parent.right : undefined
            horizontalCenter: root.align === "center" ? parent.horizontalCenter : undefined
            verticalCenter: parent.verticalCenter
        }
        anchors.margins: root.padding
        spacing: root.spacing
    }
}
