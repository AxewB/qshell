pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import qs.service
Item {
    id: root
    clip: false
    property SystemClock systemClock: systemClockDefault
    property bool rotating: true
    property real circleRadius: 16
    // wave
    property real waveAmplitude: 1.2
    property real waveFrequency: 9
    // colors
    property color fillColor: Colors.palette.m3primary
    property color arrowColor: Colors.palette.m3onPrimary
    property color waveColor: "transparent"
    // time
    readonly property int hours: systemClock.hours
    readonly property int minutes: systemClock.minutes
    readonly property int seconds: systemClock.seconds

    onFillColorChanged: canvas.requestPaint()
    onArrowColorChanged: canvas.requestPaint()
    onWaveAmplitudeChanged: canvas.requestPaint()
    onWaveFrequencyChanged: canvas.requestPaint()
    onWaveColorChanged: canvas.requestPaint()
    onSecondsChanged: canvas.requestPaint()
    onMinutesChanged: canvas.requestPaint()
    onHoursChanged: canvas.requestPaint()


    implicitWidth: circleRadius * 2
    implicitHeight: circleRadius * 2

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();

            const centerX = width / 2;
            const centerY = height / 2;

            const points = 360;

            ctx.beginPath();
            for (let i = 0; i <= points; i++) {
                const angle = i / points * 2 * Math.PI;
                // радиус с волной внутрь
                const r = root.circleRadius - root.waveAmplitude * (1 + Math.sin(angle * root.waveFrequency)) / 2;
                const x = centerX + r * Math.cos(angle);
                const y = centerY + r * Math.sin(angle);

                if (i === 0)
                    ctx.moveTo(x, y);
                else
                    ctx.lineTo(x, y);
            }
            ctx.closePath();

            ctx.fillStyle = root.fillColor;
            ctx.fill();
            ctx.strokeStyle = root.waveColor;
            ctx.lineWidth = 2;
            ctx.stroke();

            // Clock arrows
            // === стрелки ===
            // вычисляем углы
            const angleH = ((root.hours % 12) + root.minutes / 60.0) * (Math.PI / 6);
            const angleM = (root.minutes + root.seconds / 60.0) * (Math.PI / 30);
            ctx.lineCap = "round"
            ctx.lineWidth = 4;
            ctx.strokeStyle = root.arrowColor

            // часовая стрелка
            ctx.beginPath();
            ctx.moveTo(centerX, centerY);
            ctx.lineTo(centerX + (root.circleRadius * 0.35) * Math.sin(angleH),
                        centerY - (root.circleRadius * 0.35) * Math.cos(angleH));
            ctx.stroke();

            // минутная стрелка
            ctx.beginPath();
            ctx.lineWidth = 3;
            ctx.moveTo(centerX, centerY);
            ctx.lineTo(centerX + (root.circleRadius * 0.6) * Math.sin(angleM),
                        centerY - (root.circleRadius * 0.6) * Math.cos(angleM));
            ctx.stroke();
        }
        Component.onCompleted: requestPaint()
    }

    SystemClock {
        enabled: root.systemClock?.objectName && root.systemClock?.objectName === this.objectName
        objectName: "defaultClock"
        id: systemClockDefault
    }
}
