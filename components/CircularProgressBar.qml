// source https://github.com/arunpkio/RadialBarDemo
import QtQuick 2.15
import QtQuick.Shapes 1.15
import QtQml 2.2
import QtQuick 2.0

// draws two arcs (portion of a circle)
// fills the circle with a lighter secondary color
// when pressed
Canvas {
    id: canvas
    width: 240
    height: 240
    antialiasing: true

    property color primaryColor: "orange"
    property color secondaryColor: "lightblue"

    property real centerWidth: width / 2
    property real centerHeight: height / 2
    property real radius: Math.min(canvas.width, canvas.height) / 2

    property real minimumValue: 0
    property real maximumValue: 100
    property real currentValue: 33

    // this is the angle that splits the circle in two arcs
    // first arc is drawn from 0 radians to angle radians
    // second arc is angle radians to 2*PI radians
    property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI

    // we want both circle to start / end at 12 o'clock
    // without this offset we would start / end at 9 o'clock
    property real angleOffset: -Math.PI / 2

    property string text: "Text"

    signal clicked()

    onPrimaryColorChanged: requestPaint()
    onSecondaryColorChanged: requestPaint()
    onMinimumValueChanged: requestPaint()
    onMaximumValueChanged: requestPaint()
    onCurrentValueChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d");
        ctx.save();

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // fills the mouse area when pressed
        // the fill color is a lighter version of the
        // secondary color

        if (mouseArea.pressed) {
            ctx.beginPath();
            ctx.lineWidth = 1;
            ctx.fillStyle = Qt.lighter(canvas.secondaryColor, 1.25);
            ctx.arc(canvas.centerWidth,
                    canvas.centerHeight,
                    canvas.radius,
                    0,
                    2*Math.PI);
            ctx.fill();
        }

        // First, thinner arc
        // From angle to 2*PI

        ctx.beginPath();
        ctx.lineWidth = 1;
        ctx.strokeStyle = primaryColor;
        ctx.arc(canvas.centerWidth,
                canvas.centerHeight,
                canvas.radius,
                angleOffset + canvas.angle,
                angleOffset + 2*Math.PI);
        ctx.stroke();


        // Second, thicker arc
        // From 0 to angle

        ctx.beginPath();
        ctx.lineWidth = 3;
        ctx.strokeStyle = canvas.secondaryColor;
        ctx.arc(canvas.centerWidth,
                canvas.centerHeight,
                canvas.radius,
                canvas.angleOffset,
                canvas.angleOffset + canvas.angle);
        ctx.stroke();

        ctx.restore();
    }

    Text {
        anchors.centerIn: parent

        text: canvas.text
        color: canvas.primaryColor
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: canvas.clicked()
        onPressedChanged: canvas.requestPaint()
    }
}

// Item {
//     id: control

//     implicitWidth: 200
//     implicitHeight: 200

//     enum DialType {
//         FullDial,
//         MinToMax,
//         NoDial
//     }

//     property real startAngle: 0
//     property real spanAngle: 360
//     property real minValue: 0
//     property real maxValue: 100
//     property real value: 0
//     property int dialWidth: 15

//     property color backgroundColor: "transparent"
//     property color dialColor: "#FF505050"
//     property color progressColor: "#FFA51BAB"

//     property int penStyle: Qt.RoundCap
//     property int dialType: RadialBarShape.DialType.FullDial

//     QtObject {
//         id: internals

//         property bool isFullDial: control.dialType === RadialBarShape.DialType.FullDial
//         property bool isNoDial: control.dialType === RadialBarShape.DialType.NoDial

//         property real baseRadius: Math.min(control.width / 2, control.height / 2)
//         property real radiusOffset: internals.isFullDial ? control.dialWidth / 2
//                                                          : control.dialWidth / 2
//         property real actualSpanAngle: internals.isFullDial ? 360 : control.spanAngle

//         property color transparentColor: "transparent"
//         property color dialColor: internals.isNoDial ? internals.transparentColor
//                                                      : control.dialColor
//     }

//     Shape {
//         id: shape
//         anchors.fill: parent
//         layer.enabled: true
//         layer.samples: 8

//         ShapePath {
//             id: pathBackground
//             strokeColor: internals.transparentColor
//             fillColor: control.backgroundColor
//             capStyle: control.penStyle

//             PathAngleArc {
//                 radiusX: internals.baseRadius - control.dialWidth
//                 radiusY: internals.baseRadius - control.dialWidth
//                 centerX: control.width / 2
//                 centerY: control.height / 2
//                 startAngle: 0
//                 sweepAngle: 360
//             }
//         }

//         ShapePath {
//             id: pathDial
//             strokeColor: control.dialColor
//             fillColor: internals.transparentColor
//             strokeWidth: control.dialWidth
//             capStyle: control.penStyle

//             PathAngleArc {
//                 radiusX: internals.baseRadius - internals.radiusOffset
//                 radiusY: internals.baseRadius - internals.radiusOffset
//                 centerX: control.width / 2
//                 centerY: control.height / 2
//                 startAngle: control.startAngle - 90
//                 sweepAngle: internals.actualSpanAngle
//             }
//         }

//         ShapePath {
//             id: pathProgress
//             strokeColor: control.progressColor
//             fillColor: internals.transparentColor
//             strokeWidth: control.dialWidth
//             capStyle: control.penStyle

//             PathAngleArc {
//                 radiusX: internals.baseRadius - internals.radiusOffset
//                 radiusY: internals.baseRadius - internals.radiusOffset
//                 centerX: control.width / 2
//                 centerY: control.height / 2
//                 startAngle: control.startAngle - 90
//                 sweepAngle: (internals.actualSpanAngle / control.maxValue * control.value)
//             }
//         }
//     }
// }
