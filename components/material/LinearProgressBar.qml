import QtQuick
import qs.config
import qs.service

Rectangle {
    id: root
    width: 300
    height: 20
    color: "transparent"

    property real minimum: 0
    property real maximum: 100
    property real value: 50

    property bool wave: value / maximum > 0.1 && value / maximum < 0.95
    property real amplitude: wave ? 2 : 0
    property real frequency: 0.24

    property string trackColor: Colors.palette.m3secondaryContainer
    property string indicatorColor: Colors.palette.m3primary

    property real lineWidth: 4
    property real endDotSize: 4
    property real trackSpacingPx: lineWidth + 4
    property real minWaveLengthPx: 0

    property real phase: 0

    Behavior on trackColor { CAnim {} }
    Behavior on indicatorColor { CAnim {} }
    Behavior on lineWidth { ExprAnim {} }
    Behavior on endDotSize { ExprAnim {} }
    Behavior on amplitude { ExprAnim {} }
    Behavior on value { ExprAnim { speed: "slow" } }

    onTrackColorChanged: canvas.requestPaint()
    onIndicatorColorChanged: canvas.requestPaint()
    onAmplitudeChanged: canvas.requestPaint()
    onFrequencyChanged: canvas.requestPaint()
    onPhaseChanged: canvas.requestPaint()
    onTrackSpacingPxChanged: canvas.requestPaint()
    onValueChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var startX = root.lineWidth / 2
            var endX = width - root.lineWidth / 2
            var totalLength = endX - startX

            var spacingPx = root.trackSpacingPx
            var progressFraction = Math.min(Math.max((root.value - root.minimum)/(root.maximum - root.minimum), 0), 1)

            var minLength = Math.max(root.minWaveLengthPx, spacingPx)
            var progressLength = Math.max(totalLength * progressFraction, minLength)

            // --- Синусоида (индикатор) ---
            ctx.beginPath()
            ctx.lineCap = "round"
            for (var x = startX + spacingPx; x <= startX + progressLength; x += 1) {
                var angle = (x - startX) * root.frequency + root.phase
                var y = height/2 + root.amplitude * Math.sin(angle)
                if (x === startX + spacingPx)
                    ctx.moveTo(x, y)
                else
                    ctx.lineTo(x, y)
            }
            ctx.strokeStyle = root.indicatorColor
            ctx.lineWidth = root.lineWidth
            ctx.stroke()

            root.endDotSize = 4

            // --- Оставшийся трек с отступом ---
            var trackStart = startX + progressLength + spacingPx
            if (trackStart < endX) {
                ctx.beginPath()
                ctx.moveTo(trackStart, height/2)
                ctx.lineTo(endX, height/2)
                ctx.strokeStyle = root.trackColor
                ctx.lineWidth = root.lineWidth
                ctx.lineCap = "round"
                ctx.stroke()
            } else {
                root.endDotSize = root.lineWidth
            }

            // --- Кружок в конце трека ---
            ctx.beginPath()
            ctx.arc(endX, height/2, root.endDotSize/2, 0, 2 * Math.PI)
            ctx.fillStyle = root.indicatorColor
            ctx.fill()
        }
    }

    Timer {
        interval: 16
        running: root.amplitude > 0
        repeat: true
        onTriggered: root.phase += 0.05
    }


    component ExprAnim: M3SpringAnimation {
        speed: "fast"
        category: "spatial"
    }
    component CAnim: M3ColorAnimation { speed: "short" }
}
