import QtQuick
import QtQuick.Effects

Item {
z: 100
    // mask: Region {
    //     x: 0
    //     y: 0
    //     width: window.width
    //     height: window.height
    //     intersection: Intersection.Xor
    // }

    opacity: 0.2
    anchors.fill: parent

    Rectangle {
        id: borders
        anchors.fill: parent
        color: "black"
        visible: false
    }

    Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            radius: root.radius + 100
        }
    }


    MultiEffect {
        source: borders
        maskSource: mask
        anchors.fill: parent
        maskEnabled: true
        maskInverted: true
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1
    }
}


// Rectangle {
//     id: root
//     opacity: 0.2

//     Rectangle {
//         id: fillRect
//         anchors.fill: parent
//         color: "black"
//         visible: false
//     }

//     Item {
//         id: mask

//         anchors.fill: parent
//         layer.enabled: true
//         visible: false

//         Rectangle {
//             anchors.fill: parent
//             radius: Config.borders.radius
//         }
//     }

//     MultiEffect {
//         source: fillRect
//         maskSource: mask
//         anchors.fill: root
//         maskEnabled: true
//         maskInverted: true
//         maskThresholdMin: 0.5
//         maskSpreadAtMin: 1
//     }
// }
