import QtQuick
import qs.config
import qs.service

Rectangle {
    id: root
    width: radius * 2 + lineWidth
    height: radius * 2 + lineWidth
    color: "transparent"

    property real min: 0
    property real max: 100
    property real value: 100

    property bool wave: false
    property real radius: 16
    property real frequency: 8
    property real amplitude: wave

    property bool rotate: true
    property bool rotateDirection: false // false for Clockwise, true for Counterclockwise

    property string trackColor: Colors.palette.m3secondaryContainer
    property string indicatorColor: Colors.palette.m3primary

    property int lineWidth: 4
    property real phase: 0  // сдвиг синусоиды

    property real startAngle: -Math.PI/2
    property real endAngle: 3*Math.PI/2

    property real trackSpacingPx: lineWidth
    property real endDotSize: lineWidth

    Behavior on trackColor { CAnim {} }
    Behavior on indicatorColor { CAnim {} }
    Behavior on lineWidth { ExprAnim {} }
    Behavior on endDotSize { ExprAnim {} }
    Behavior on frequency { ExprAnim {} }
    Behavior on amplitude { ExprAnim {} }
    Behavior on value { ExprAnim { speed: "slow" } }

    onTrackColorChanged: canvas.requestPaint()
    onIndicatorColorChanged: canvas.requestPaint()
    onRadiusChanged: canvas.requestPaint()
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

            var cx = width / 2
            var cy = height / 2

            var minWaveLengthPx= 1  // минимальная видимая длина синусоиды в пикселях

            var spacingAngle = root.trackSpacingPx / root.radius
            var totalAngle = root.endAngle - root.startAngle
            var progressFraction = Math.min(Math.max((root.value - root.min) / (root.max - root.min), 0), 1)
            var progressAngle = root.startAngle + spacingAngle + (totalAngle - spacingAngle) * progressFraction

            // минимальная длина синусоиды
            var minAngle = root.minWaveLengthPx / root.radius
            if (progressAngle - (root.startAngle + spacingAngle) < minAngle)
                progressAngle = root.startAngle + spacingAngle + minAngle

            // компенсируем толщину линии, чтобы синусоида дотянулась до точки начала
            var extraAngle = root.lineWidth / (2 * root.radius)
            progressAngle += extraAngle

            // Средний радиус для синусоиды
            var waveRadius = root.radius - root.lineWidth / 4 - root.amplitude

            // DRAWING TRACK
            if (progressFraction < 1) {
                var trackStart = progressAngle + spacingAngle * 2
                var trackEnd = root.endAngle - spacingAngle

                // Если трек корректный, рисуем его
                if (trackStart < trackEnd) {
                    ctx.beginPath()
                    ctx.arc(cx, cy, root.radius, trackStart, trackEnd, false)
                    ctx.strokeStyle = root.trackColor
                    ctx.lineWidth = root.endDotSize
                    ctx.stroke()
                    root.endDotSize = root.lineWidth
                }
                else {
                    root.endDotSize = 0
                }

                // --- Кружок в конце трека ---
                var endX = cx + root.radius * Math.cos(trackEnd)
                var endY = cy + root.radius * Math.sin(trackEnd)
                ctx.beginPath()
                ctx.arc(endX, endY, root.endDotSize / 2, 0, 2 * Math.PI)
                ctx.fillStyle = root.trackColor
                ctx.fill()
            }

            // --- Синусоида ---
            ctx.beginPath()
            ctx.lineCap = "round"
            for (var angle = root.startAngle + spacingAngle; angle <= progressAngle; angle += 0.01) {
                var r = waveRadius + root.amplitude * Math.sin(root.frequency * angle + root.phase)
                var x = cx + r * Math.cos(angle)
                var y = cy + r * Math.sin(angle)
                if (angle === root.startAngle + spacingAngle)
                    ctx.moveTo(x, y)
                else
                    ctx.lineTo(x, y)
            }
            ctx.strokeStyle = root.indicatorColor
            ctx.lineWidth = root.lineWidth
            ctx.stroke()

        }
    }

    Timer {
        interval: 16  // ~60 FPS
        running: root.amplitude > 0 && root.rotate
        repeat: true
        onTriggered: root.phase += 0.05 * (root.rotateDirection ? 1 : -1)
    }


    component ExprAnim: M3SpringAnimation {
        speed: "fast"
        category: "effects"
    }
    component CAnim: M3ColorAnimation { speed: "short" }
}
