pragma ComponentBehavior: Bound
import Quickshell.Io

JsonObject {
    id: typography
    property real scale: 1
    readonly property JsonObject fontFamilies: JsonObject {
        readonly property string sans: "Rubik" // "Roboto"
        readonly property string mono: "CaskaydiaCove Nerd Font Mono"
    }

    readonly property JsonObject display: JsonObject {
        readonly property var large:   ({ family: typography.fontFamilies.sans, size: 57 * typography.scale, weight: 400, lineHeight: 64 * typography.scale, tracking: -0.25 })
        readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 45 * typography.scale, weight: 400, lineHeight: 52 * typography.scale, tracking: -0.2 })
        readonly property var small:   ({ family: typography.fontFamilies.sans, size: 36 * typography.scale, weight: 400, lineHeight: 44 * typography.scale, tracking: -0.1 })
    }

    readonly property JsonObject headline: JsonObject {
        readonly property var large:   ({ family: typography.fontFamilies.sans, size: 32 * typography.scale, weight: 400, lineHeight: 40 * typography.scale, tracking: 0 })
        readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 28 * typography.scale, weight: 400, lineHeight: 36 * typography.scale, tracking: 0.1 })
        readonly property var small:   ({ family: typography.fontFamilies.sans, size: 24 * typography.scale, weight: 400, lineHeight: 32 * typography.scale, tracking: 0.1 })
    }

    readonly property JsonObject title: JsonObject {
        readonly property var large:   ({ family: typography.fontFamilies.sans, size: 22 * typography.scale, weight: 400, lineHeight: 28 * typography.scale, tracking: 0 })
        readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 16 * typography.scale, weight: 500, lineHeight: 24 * typography.scale, tracking: 0.15 })
        readonly property var small:   ({ family: typography.fontFamilies.sans, size: 14 * typography.scale, weight: 500, lineHeight: 20 * typography.scale, tracking: 0.1 })
    }

    readonly property JsonObject body: JsonObject {
        readonly property var large:   ({ family: typography.fontFamilies.sans, size: 16 * typography.scale, weight: 400, lineHeight: 24 * typography.scale, tracking: 0.5 })
        readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 14 * typography.scale, weight: 400, lineHeight: 20 * typography.scale, tracking: 0.25 })
        readonly property var small:   ({ family: typography.fontFamilies.sans, size: 12 * typography.scale, weight: 400, lineHeight: 16 * typography.scale, tracking: 0.4 })
    }

    readonly property JsonObject label: JsonObject {
        readonly property var large:   ({ family: typography.fontFamilies.sans, size: 14 * typography.scale, weight: 500, lineHeight: 20 * typography.scale, tracking: 0.1 })
        readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 12 * typography.scale, weight: 500, lineHeight: 16 * typography.scale, tracking: 0.5 })
        readonly property var small:   ({ family: typography.fontFamilies.sans, size: 11 * typography.scale, weight: 500, lineHeight: 16 * typography.scale, tracking: 0.5 })
    }

    readonly property JsonObject code: JsonObject {
        readonly property var large:   ({ family: typography.fontFamilies.mono, size: 16 * typography.scale, weight: 400, lineHeight: 24 * typography.scale, tracking: 0.5 })
        readonly property var medium:  ({ family: typography.fontFamilies.mono, size: 14 * typography.scale, weight: 400, lineHeight: 20 * typography.scale, tracking: 0.25 })
        readonly property var small:   ({ family: typography.fontFamilies.mono, size: 12 * typography.scale, weight: 400, lineHeight: 16 * typography.scale, tracking: 0.4 })
    }


    readonly property JsonObject emphasized: JsonObject {
        readonly property JsonObject display: JsonObject {
            readonly property var large:   ({ family: typography.fontFamilies.sans, size: 57 * typography.scale, weight: 500, lineHeight: 64 * typography.scale, tracking: -0.25 })
            readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 45 * typography.scale, weight: 500, lineHeight: 52 * typography.scale, tracking: -0.2 })
            readonly property var small:   ({ family: typography.fontFamilies.sans, size: 36 * typography.scale, weight: 500, lineHeight: 44 * typography.scale, tracking: -0.1 })
        }
        readonly property JsonObject headline: JsonObject {
            readonly property var large:   ({ family: typography.fontFamilies.sans, size: 32 * typography.scale, weight: 500, lineHeight: 40 * typography.scale, tracking: 0 })
            readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 28 * typography.scale, weight: 500, lineHeight: 36 * typography.scale, tracking: 0.1 })
            readonly property var small:   ({ family: typography.fontFamilies.sans, size: 24 * typography.scale, weight: 500, lineHeight: 32 * typography.scale, tracking: 0.1 })
        }
        readonly property JsonObject title: JsonObject {
            readonly property var large:   ({ family: typography.fontFamilies.sans, size: 22 * typography.scale, weight: 500, lineHeight: 28 * typography.scale, tracking: 0 })
            readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 16 * typography.scale, weight: 600, lineHeight: 24 * typography.scale, tracking: 0.15 })
            readonly property var small:   ({ family: typography.fontFamilies.sans, size: 14 * typography.scale, weight: 600, lineHeight: 20 * typography.scale, tracking: 0.1 })
        }
        readonly property JsonObject body: JsonObject {
            readonly property var large:   ({ family: typography.fontFamilies.sans, size: 16 * typography.scale, weight: 500, lineHeight: 24 * typography.scale, tracking: 0.5 })
            readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 14 * typography.scale, weight: 500, lineHeight: 20 * typography.scale, tracking: 0.25 })
            readonly property var small:   ({ family: typography.fontFamilies.sans, size: 12 * typography.scale, weight: 500, lineHeight: 16 * typography.scale, tracking: 0.4 })
        }
        readonly property JsonObject label: JsonObject {
            readonly property var large:   ({ family: typography.fontFamilies.sans, size: 14 * typography.scale, weight: 600, lineHeight: 20 * typography.scale, tracking: 0.1 })
            readonly property var medium:  ({ family: typography.fontFamilies.sans, size: 12 * typography.scale, weight: 600, lineHeight: 16 * typography.scale, tracking: 0.5 })
            readonly property var small:   ({ family: typography.fontFamilies.sans, size: 11 * typography.scale, weight: 600, lineHeight: 16 * typography.scale, tracking: 0.5 })
        }
        readonly property JsonObject code: JsonObject {
            readonly property var large:   ({ family: typography.fontFamilies.mono, size: 16 * typography.scale, weight: 400, lineHeight: 24 * typography.scale, tracking: 0.5 })
            readonly property var medium:  ({ family: typography.fontFamilies.mono, size: 14 * typography.scale, weight: 400, lineHeight: 20 * typography.scale, tracking: 0.25 })
            readonly property var small:   ({ family: typography.fontFamilies.mono, size: 12 * typography.scale, weight: 400, lineHeight: 16 * typography.scale, tracking: 0.4 })
        }
    }
}
