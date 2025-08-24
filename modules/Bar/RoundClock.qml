import Quickshell
import QtQuick
import qs.config
import qs.service

Canvas {
    id: root

    property int radius: 11 * Config.appearance.scale
    property int lineWidth: 2 * Config.appearance.scale
    property int arrowsOffset: 0 * Config.appearance.scale

    property bool fillBackground: false
    property bool hoursEnabled: true
    property bool minutesEnabled: true
    property bool secondsEnabled: false
    property string backgroundColor: Colors.palette.m3primaryContainer
    property string clockBorderColor: Colors.palette.m3onSurface
    property string hoursArrowColor: Colors.palette.m3primary
    property string minutesArrowColor: Colors.palette.m3primary
    property string secondsArrowColor: Colors.palette.m3primary
    readonly property real centerX: width / 2
    readonly property real centerY: height / 2


    width: radius * 2 + lineWidth
    height: radius * 2 + lineWidth

    function drawClock() {
        var ctx = getContext("2d");
        const hours = clock.hours
        const minutes = clock.minutes
        const seconds = clock.seconds

        const hourAngle = (hours % 12) * (2 * Math.PI / 12) - Math.PI / 2;
        const minuteAngle = minutes * (2 * Math.PI / 60) - Math.PI / 2;
        const secondAngle = seconds * (2 * Math.PI / 60) - Math.PI / 2;

        ctx.clearRect(0, 0, width, height);

        function angleDiff(a, b) {
            let diff = (b - a) % (2 * Math.PI);
            if (diff < 0) diff += 2 * Math.PI; // перевод в диапазон 0..2π
            return diff;
        }

        function drawArc(centerX, centerY, angleStart, angleEnd, color) {
            if (angleStart == angleEnd)  {
                angleStart = 0
                angleEnd = Math.PI * 2
            }
            ctx.lineWidth = lineWidth;
            ctx.strokeStyle = color
            ctx.lineCap = "round";
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, angleStart, angleEnd, false);
            ctx.stroke();
        }

        function drawArrow(angle, offset, strokeColor, lineWidth, endCrop) {
            const startX = centerX + Math.cos(angle) * offset;
            const startY = centerY + Math.sin(angle) * offset;
            const endX = centerX + Math.cos(angle) * (radius - lineWidth - endCrop);
            const endY = centerY + Math.sin(angle) * (radius - lineWidth - endCrop);
            ctx.beginPath();
            ctx.strokeStyle = strokeColor;
            ctx.lineWidth = lineWidth;
            ctx.moveTo(startX, startY);
            ctx.lineTo(endX, endY);
            ctx.stroke();
        }

        if (fillBackground) {
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius + lineWidth / 2, 0, Math.PI * 2);
            ctx.fillStyle = backgroundColor
            ctx.fill();
        }

        drawArc(centerX, centerY, 0, Math.PI * 2, clockBorderColor)

        // TODO: мб сделаю две линии между минутами и часами, заебался пытаться сделать нормальную обработку их длин, когда пропуск уже маловат
        // const arcGap = 0.5
        // const diff = angleDiff(hourAngle, secondAngle);
        // if (diff > arcGap) {
        //     drawArc(centerX, centerY, secondAngle + arcGap, hourAngle - arcGap + 2 * Math.PI, "red");
        //     drawArc(centerX, centerY, hourAngle + arcGap, secondAngle - arcGap, clockColor);
        // }
        // else {
        //     drawArc(centerX, centerY, hourAngle , secondAngle , clockColor);
        // }


        if (hoursEnabled) drawArrow(hourAngle, arrowsOffset, hoursArrowColor, lineWidth, lineWidth)
        if (minutesEnabled) drawArrow(minuteAngle, arrowsOffset, minutesArrowColor, lineWidth, lineWidth / 2)
        if (secondsEnabled) drawArrow(secondAngle, arrowsOffset, secondsArrowColor, lineWidth, lineWidth / 3)
    }

    Connections {
        target: clock
        function onHoursChanged() {requestPaint()}
        function onMinutesChanged() {requestPaint()}
        function onSecondsChanged() {requestPaint()}
    }

    onPaint: drawClock()

    SystemClock {
        id: clock
        precision: secondsEnabled ? SystemClock.Seconds
            : minutesEnabled ? SystemClock.Minutes
            : SystemClock.Hours
    }
}
