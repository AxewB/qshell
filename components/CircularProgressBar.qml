import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/modules"
import "root:/utils"
import "root:/components"

Canvas {
    id: root

    property real min: 0
    property real max: 1
    property real progress: min

    property bool looped: false
    property string loopColor: Colors.palette.m3primary
    property string loopColorAlt: Colors.palette.m3surfaceVariant
    property string loopColorCurrent: loopColor

    property int radius: 12
    property int lineWidth: radius / 3
    readonly property real centerX: width / 2
    readonly property real centerY: height / 2 + lineWidth / 2

    width: radius * 2 + lineWidth
    height: radius * 2 + lineWidth / 2


    function drawCircle() {
        var ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);

        const normalized = Math.max(0, Math.min(1, (progress - min) / (max - min)));

        const startAngle = 3/4 * Math.PI;
        const endAngle = 9/4 * Math.PI;
        const currentAngle = startAngle + (endAngle - startAngle) * normalized;
        const gapDegree = lineWidth * 0.15;

        // остаток
        ctx.lineWidth = lineWidth;
        ctx.strokeStyle = Colors.palette.m3surfaceVariant;
        ctx.lineCap = "round";
        ctx.beginPath();
        if (currentAngle + gapDegree >= endAngle) {
            ctx.arc(centerX, centerY, radius, endAngle - gapDegree, endAngle, false);
        } else {
            ctx.arc(centerX, centerY, radius, currentAngle + gapDegree, endAngle, false);
        }
        ctx.stroke();

        // заполненная часть
        ctx.lineWidth = lineWidth;
        ctx.strokeStyle = Colors.palette.m3primary;
        ctx.lineCap = "round";
        ctx.beginPath();
        ctx.arc(centerX, centerY, radius, startAngle, currentAngle + 0.01, false);
        ctx.stroke();
    }


    function drawCircleLooped() {
        var ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);

        const normalized = Math.max(0, Math.min(1, (progress - min) / (max - min)));

        const startAngle = 3/4 * Math.PI;
        const endAngle = 9/4 * Math.PI;
        const currentAngle = startAngle + (endAngle - startAngle) * normalized;
        const gapDegree = lineWidth * 0.15;

        // заполненная часть
        ctx.lineWidth = lineWidth;
        ctx.strokeStyle = loopColorCurrent
        ctx.lineCap = "round";
        ctx.beginPath();
        ctx.arc(centerX, centerY, radius, startAngle, endAngle, false);
        ctx.stroke();
    }

    // Анимация дыхания
    SequentialAnimation {
        id: breathAnimation
        loops: Animation.Infinite
        running: root.looped

        ColorAnimation {
            target: root;
            property: "loopColorCurrent";
            from: root.loopColor;
            to: root.loopColorAlt;
            duration: 2000;
            easing.type: Easing.InOutQuad
        }
        ColorAnimation {
            target: root;
            property: "loopColorCurrent";
            from: root.loopColorAlt;
            to: root.loopColor;
            duration: 2000;
            easing.type: Easing.InOutQuad
        }
    }

    onPaint: {
        if (looped) {
            drawCircleLooped()
        }
        else {
            drawCircle()
        }
    }
    onLoopColorCurrentChanged: requestPaint()
    onProgressChanged: requestPaint()
    onMinChanged: requestPaint()
    onMaxChanged: requestPaint()

}
