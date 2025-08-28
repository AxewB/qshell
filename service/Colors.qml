pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.utils
import qs.config

Singleton {
    id: root
    property string scheme: "scheme-tonal-spot"
    property real contrast: 0
    property bool isDark: true
    property bool isDynamic: true

    property bool isPreview: false

    property color baseColor: "black"
    property color previewColor: "black"
    readonly property color color: isPreview ? previewColor : baseColor

    property Colors basePalette: Colors {}
    property Colors previewPalette: Colors {}
    readonly property Colors palette: isPreview ? previewPalette : basePalette

    signal saving()

    onColorChanged: updateColors()
    onSchemeChanged: updateColors()
    onContrastChanged: updateColors()
    onIsDarkChanged: updateColors()
    onIsDynamicChanged: updateColors()
    onIsPreviewChanged: if (isPreview) {
        previewColor = baseColor
        previewPalette = basePalette
    }

    function setColorManually(color) {
        isDynamic = false
        applyColor(color)
    }

    function setContrast(value) {
        if (value >= -1 && value <= 1) contrast = value
    }

    function updateColors() {
        if (!color) return

        const command = []
        command.push("matugen")
        command.push("color", "hex", color)
        command.push("--type", scheme)
        command.push("--contrast", contrast)
        command.push("--mode", isDark ? "dark" : "light")
        command.push("--json", "hex", "--dry-run")


        updateColorsProcess.command = command
        updateColorsProcess.running = true
    }

    function toggleDarkMode() { isDark = !isDark }

    function togglePreviewMode() { isPreview = !isPreview }

    function toggleDynamicMode() {
        isDynamic = !isDynamic

        if (isDynamic) {
            applyColor(quantizer.colors[0])
        }
    }

    function setScheme(newScheme) {
        const allowed = [
            "scheme-content", "scheme-expressive", "scheme-fidelity",
            "scheme-fruit-salad", "scheme-monochrome", "scheme-neutral",
            "scheme-rainbow", "scheme-tonal-spot"
        ]

        if (allowed.includes(newScheme)) {
            scheme = newScheme
        }
    }

    function applyColor(color) {
        if (isPreview) {
            previewColor = color
        } else {
            baseColor = color
        }
        updateColors()
    }

    function applyColors(data) {

        const { colors } = JSON.parse(data)
        const theme = isDark ? keysToCamel(colors.dark) : keysToCamel(colors.light)

        if (isPreview) {
            Object.assign(previewPalette, theme)
        }
        else {
            Object.assign(basePalette, theme)
            save()
        }
    }

    function acceptPreview() {
        if (!isPreview) return

        baseColor = previewColor
        basePalette = previewPalette
        isPreview = false
        save()
    }

    function save() {
        saving()

        jsData.scheme = scheme
        jsData.contrast = contrast
        jsData.isDark = isDark
        jsData.isDynamic = isDynamic
        jsData.color = color

        adapter.writeAdapter()
    }

    function snakeToCamel(str) {
        return str.replace(/_([a-z])/g, (_, l) => l.toUpperCase())
    }

    function keysToCamel(obj) {
        if (Array.isArray(obj)) return obj.map(keysToCamel)
        if (obj && typeof obj === "object") {
            const newObj = {}
            for (let key in obj) newObj["m3" + snakeToCamel(key)] = keysToCamel(obj[key])
            return newObj
        }
        return obj
    }

    Process {
        id: updateColorsProcess
        stdout: StdioCollector { onStreamFinished: root.applyColors(text) }
    }

    ColorQuantizer {
        id: quantizer
        source: Qt.resolvedUrl(WallpaperService.path)
        rescaleSize: 64
        depth: 1
        onColorsChanged: if (root.isDynamic && source) {
            root.applyColor(colors[0])
        }
    }

    FileView {
        id: adapter
        path: `${Paths.config}/colors.json`
        watchChanges: true
        onFileChanged: {
            console.log("HHHH")
            this.reload()
        }
        onLoaded: {
            root.scheme = jsData.scheme
            root.contrast = jsData.contrast
            root.isDark = jsData.isDark
            root.isDynamic = jsData.isDynamic

            root.baseColor = jsData.color
            root.previewColor = jsData.color

            root.basePalette = jsData.palette
            root.previewPalette = jsData.palette
        }

        JsonAdapter {
            id: jsData
            property string scheme: "scheme-tonal-spot"
            property real contrast: 0
            property bool isDark: true
            property bool isDynamic: true
            property color color: "black"
        }
    }

    component Colors: JsonObject {
        property color m3sourceColor: "#000000"
        property color m3background: "#191113"
        property color m3error: "#ffb4ab"
        property color m3errorContainer: "#93000a"
        property color m3inverseOnSurface: "#372e30"
        property color m3inversePrimary: "#8c4a60"
        property color m3inverseSurface: "#efdfe1"
        property color m3onBackground: "#efdfe1"
        property color m3onError: "#690005"
        property color m3onErrorContainer: "#ffdad6"
        property color m3onPrimary: "#541d32"
        property color m3onPrimaryContainer: "#ffd9e2"
        property color m3onPrimaryFixed: "#3a071d"
        property color m3onPrimaryFixedVariant: "#703348"
        property color m3onSecondary: "#422931"
        property color m3onSecondaryContainer: "#ffd9e2"
        property color m3onSecondaryFixed: "#2b151c"
        property color m3onSecondaryFixedVariant: "#5a3f47"
        property color m3onSurface: "#efdfe1"
        property color m3onSurfaceVariant: "#d5c2c6"
        property color m3onTertiary: "#48290b"
        property color m3onTertiaryContainer: "#ffdcc1"
        property color m3onTertiaryFixed: "#2e1500"
        property color m3onTertiaryFixedVariant: "#623f20"
        property color m3outline: "#9e8c90"
        property color m3outlineVariant: "#514347"
        property color m3primary: "#ffb1c8"
        property color m3primaryContainer: "#703348"
        property color m3primaryFixed: "#ffd9e2"
        property color m3primaryFixedDim: "#ffb1c8"
        property color m3scrim: "#000000"
        property color m3secondary: "#e3bdc6"
        property color m3secondaryContainer: "#5a3f47"
        property color m3secondaryFixed: "#ffd9e2"
        property color m3secondaryFixedDim: "#e3bdc6"
        property color m3shadow: "#000000"
        property color m3surface: "#191113"
        property color m3surfaceBright: "#413739"
        property color m3surfaceContainer: "#261d20"
        property color m3surfaceContainerHigh: "#31282a"
        property color m3surfaceContainerHighest: "#3c3235"
        property color m3surfaceContainerLow: "#22191c"
        property color m3surfaceContainerLowest: "#140c0e"
        property color m3surfaceDim: "#191113"
        property color m3surfaceTint: "#ffb1c8"
        property color m3surfaceVariant: "#514347"
        property color m3tertiary: "#efbd94"
        property color m3tertiaryContainer: "#623f20"
        property color m3tertiaryFixed: "#ffdcc1"
        property color m3tertiaryFixedDim: "#efbd94"
    }
}
