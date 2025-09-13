
Canvas {
    id: circularWaveBar
    width: parent.width
    height: parent.height

    property real progress: 0.5
    property color barColor: "blue"
    property real waveAmplitude: 5
    property real waveFrequency: 0.2
    property real waveSpeed: 0.05

    onPaint: {
        var ctx = getContext("2d");
        var radius = Math.min(width, height) / 2 - 10;
        var centerX = width / 2;
        var centerY = height / 2;
        var startAngle = -Math.PI / 2;
        var endAngle = startAngle + 2 * Math.PI * progress;

        ctx.clearRect(0, 0, width, height);

        // Фоновая окружность
        ctx.beginPath();
        ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
        ctx.lineWidth = 10;
        ctx.strokeStyle = "#e0e0e0";
        ctx.stroke();

        // Волна
        ctx.beginPath();
        for (var i = 0; i <= 100; i++) {
            var angle = startAngle + (endAngle - startAngle) * (i / 100);
            var x = centerX + radius * Math.cos(angle);
            var y = centerY + radius * Math.sin(angle) + waveAmplitude * Math.sin(waveFrequency * angle + waveSpeed * Date.now());
            if (i === 0) {
                ctx.moveTo(x, y);
            } else {
                ctx.lineTo(x, y);
            }
        }
        ctx.strokeStyle = barColor;
        ctx.lineWidth = 10;
        ctx.stroke();
    }

    Timer {
        interval: 16
        running: true
        repeat: true
        onTriggered: circularWaveBar.requestPaint()
    }
}
