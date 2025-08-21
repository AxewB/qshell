import QtQuick
import Quickshell
import Quickshell.Io
import "root:/utils"
pragma Singleton

Singleton {
    id: root

    // settings
    property string scheme
    property int quality
    property int contrast
    property bool isDark
    property string sourceType
    property string source
    property string prefix

    // colors
    property bool isPreview: false
    property Colors current: Colors {}
    property Colors preview: Colors {}
    property Colors palette: isPreview ? preview : current

    function setWallpaper(source: string) {
        const command = Array(
            "axewbshell",
            "theme",
            "--image", source,
            "-s", root.scheme,
            "-ct", root.contrast,
            root.isDark ? "-d" : ""
        )

        updateColorsProc.command = command
        updateColorsProc.startDetached();
    }

    function set(type: string, source: string, isDark: bool, scheme = "scheme_tonal_spot", contrast = 0 ) {
        const command = Array(
            "axewbshell",
            "theme",
            `${type === "image" ? "--image" : "--color"}`, source,
            "-s", scheme,
            "-ct", contrast
        )

        if (isDark) command.append("-d")

        updateColorsProc.command = command
        updateColorsProc.startDetached();
    }

    function apply(data: string) {
        const jsonData = JSON.parse(data.trim());

        // Палитра цветов
        const palette = isPreview ? root.preview : root.current;
        const newPalette = jsonData.palette;
        for (const [key, value] of Object.entries(newPalette)) {
            palette[key] = value;
        }

        // Информация о теме
        root.scheme = jsonData.scheme
        root.quality = jsonData.quality
        root.contrast = jsonData.contrast
        root.isDark = jsonData.is_dark
        root.sourceType = jsonData.source_type
        root.source = jsonData.source
        root.prefix = jsonData.prefix
    }

    // Обновляем палитру, если файл темы изменился
    FileView {
        path: `${Paths.theme}`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.apply(text())
    }

    Process {
        id: updateColorsProc
    }

    function applyAlpha(hexColor, alpha = 1) {
        if (!hexColor.startsWith("#")) throw new Error("Color must start with `#`");
        if (hexColor.length !== 7) throw new Error("Color must be in alpha-less HEX format: #RRGGBB");
        if (alpha < 0 || alpha > 1) throw new Error("Alpha must be in range from 0 to 1");

        const alphaDecimal = Math.round(alpha * 255);
        const alphaHex = alphaDecimal.toString(16).padStart(2, "0").toUpperCase();

        return `#${alphaHex}${hexColor.slice(1)}`;
    }

    component Colors: QtObject {
        // Ключевые цвета
        property color m3primary_paletteKeyColor: "#AD6353"
        property color m3secondary_paletteKeyColor: "#926F68"
        property color m3tertiary_paletteKeyColor: "#887544"
        property color m3neutral_paletteKeyColor: "#827471"
        property color m3neutral_variant_paletteKeyColor: "#85736F"

        // Основные цвета
        property color m3background: "#1A1110"
        property color m3onBackground: "#F1DFDB"
        property color m3surface: "#1A1110"
        property color m3surfaceDim: "#1A1110"
        property color m3surfaceBright: "#423734"
        property color m3surfaceContainerLowest: "#140C0A"
        property color m3surfaceContainerLow: "#231917"
        property color m3surfaceContainer: "#271D1B"
        property color m3surfaceContainerHigh: "#322826"
        property color m3surfaceContainerHighest: "#3D3230"
        property color m3onSurface: "#F1DFDB"
        property color m3surfaceVariant: "#534340"
        property color m3onSurfaceVariant: "#D8C2BD"
        property color m3inverseSurface: "#F1DFDB"
        property color m3inverseOnSurface: "#392E2C"
        property color m3outline: "#A08C88"
        property color m3outlineVariant: "#534340"
        property color m3shadow: "#000000"
        property color m3scrim: "#000000"
        property color m3surfaceTint: "#FFB4A5"
        property color m3primary: "#FFB4A5"
        property color m3onPrimary: "#561F14"
        property color m3primaryContainer: "#733427"
        property color m3onPrimaryContainer: "#FFDAD3"
        property color m3inversePrimary: "#904B3D"
        property color m3secondary: "#E7BDB4"
        property color m3onSecondary: "#442A24"
        property color m3secondaryContainer: "#5D3F39"
        property color m3onSecondaryContainer: "#FFDAD3"
        property color m3tertiary: "#DCC48C"
        property color m3onTertiary: "#3D2F04"
        property color m3tertiaryContainer: "#A38F5B"
        property color m3onTertiaryContainer: "#000000"
        property color m3error: "#FFB4AB"
        property color m3onError: "#690005"
        property color m3errorContainer: "#93000A"
        property color m3onErrorContainer: "#FFDAD6"
        property color m3primaryFixed: "#FFDAD3"
        property color m3primaryFixedDim: "#FFB4A5"
        property color m3onPrimaryFixed: "#3A0A03"
        property color m3onPrimaryFixedVariant: "#733427"
        property color m3secondaryFixed: "#FFDAD3"
        property color m3secondaryFixedDim: "#E7BDB4"
        property color m3onSecondaryFixed: "#2C1510"
        property color m3onSecondaryFixedVariant: "#5D3F39"
        property color m3tertiaryFixed: "#F9E0A6"
        property color m3tertiaryFixedDim: "#DCC48C"
        property color m3onTertiaryFixed: "#241A00"
        property color m3onTertiaryFixedVariant: "#554519"
    }
}
