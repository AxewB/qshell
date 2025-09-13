pragma ComponentBehavior: Bound
import Quickshell.Io

JsonObject {
    id: root
    property real scale: 1.0
    readonly property Padding padding: Padding {}
    readonly property Icon icon: Icon {}
    readonly property Radius radius: Radius {}
    // readonly property Animations animations: Animations {}
    readonly property Motion motion: Motion {}
    readonly property Typography typography: Typography {}
    readonly property Elevation elevation: Elevation {}

    component Icon: JsonObject {
        readonly property string family: "Material Symbols Rounded"
        readonly property IconSize size: IconSize {}
    }
    component IconSize: JsonObject {
        readonly property real xsmall: 18 * root.scale
        readonly property real small: 20 * root.scale
        readonly property real medium: 24 * root.scale
        readonly property real large: 32 * root.scale
        readonly property real xlarge: 40 * root.scale
    }

    component Padding: JsonObject {
        readonly property real xsmall: 1 * root.scale
        readonly property real small: 2 * root.scale
        readonly property real normal: 4 * root.scale
        readonly property real large: 6 * root.scale
        readonly property real huge: 8 * root.scale
        readonly property real enormous: 16 * root.scale
    }

    component Radius: JsonObject {
        readonly property real xsmall: 4 * root.scale
        readonly property real small: 8 * root.scale
        readonly property real medium: 12 * root.scale
        readonly property real larger: 16 * root.scale
        readonly property real large: 20 * root.scale
        readonly property real xlarge: 28 * root.scale
        readonly property real xxlarger: 32 * root.scale
        readonly property real xxlarge: 48 * root.scale
        readonly property real full: 1000 * root.scale
    }

    component Motion: JsonObject {
        readonly property MotionSprings springs: MotionSprings {}
        readonly property MotionCurves curves: MotionCurves {}
        readonly property var durations: ({
            short:   [50, 100, 150, 200],
            medium:  [250, 300, 350, 400],
            long:    [450, 500, 550, 600],
            xlong:   [700, 800, 900, 1000]
        })
    }
    component MotionSprings: JsonObject {
        readonly property var fast: ({
            spatial:   { damping: 0.4,  stiffness: 1400 },
            effects:   { damping: 1,  stiffness: 3800 }
        })
        readonly property var normal: ({
            spatial:   { damping: 0.4,  stiffness: 700 },
            effects:   { damping: 1,  stiffness: 1600 }
        })
        readonly property var slow: ({
            spatial:   { damping: 0.4,  stiffness: 300 },
            effects:   { damping: 1,  stiffness: 800 }
        })
    }
    component MotionCurves: JsonObject {
        readonly property var emphasized: ({
            accelerate: [0.3, 0, 0.8, 0.15],
            decelerate: [0.05, 0.7, 0.1, 1.0]
        })
        readonly property var standard: ({
            accelerate: [0.3, 0, 1, 1],
            decelerate: [0, 0, 0, 1]
        })
        readonly property var legacy: ({
            accelerate: [0.4, 0, 1, 1],
            decelerate: [0, 0, 0.2, 1]
        })
        readonly property list<int> linear: [0,0,1,1]
    }

    component Elevation: JsonObject {
        property list<var> levels: [
            {  // 0
                shadow: { x: 0, y: 0, blur: 0, spread: 0, opacity: 0.0 },
                overlayOpacity: 0.0
            },
            { // 1
                shadow: { x: 0, y: 1, blur: 3, spread: 0, opacity: 0.2 },
                overlayOpacity: 0.05
            },
            { // 2
                shadow: { x: 0, y: 2, blur: 6, spread: 0, opacity: 0.25 },
                overlayOpacity: 0.08
            },
            { // 3
                shadow: { x: 0, y: 3, blur: 8, spread: 0, opacity: 0.3 },
                overlayOpacity: 0.11
            },
            { // 4
                shadow: { x: 0, y: 4, blur: 10, spread: 0, opacity: 0.35 },
                overlayOpacity: 0.12
            },
            { // 5
                shadow: { x: 0, y: 6, blur: 12, spread: 0, opacity: 0.4 },
                overlayOpacity: 0.14
            }
        ]
    }

    component Typography: JsonObject {
        id: typographyComponent
        readonly property JsonObject fontFamilies: JsonObject {
            readonly property string sans: "Roboto"
            readonly property string mono: "IosevkaTermSlab Nerd Font"
        }

        readonly property JsonObject display: JsonObject {
            readonly property var large:   ({ family: fontFamilies.sans, size: 57 * root.scale, weight: 400, lineHeight: 64 * root.scale, tracking: -0.25 })
            readonly property var medium:  ({ family: fontFamilies.sans, size: 45 * root.scale, weight: 400, lineHeight: 52 * root.scale, tracking: -0.2 })
            readonly property var small:   ({ family: fontFamilies.sans, size: 36 * root.scale, weight: 400, lineHeight: 44 * root.scale, tracking: -0.1 })
        }

        readonly property JsonObject headline: JsonObject {
            readonly property var large:   ({ family: fontFamilies.sans, size: 32 * root.scale, weight: 400, lineHeight: 40 * root.scale, tracking: 0 })
            readonly property var medium:  ({ family: fontFamilies.sans, size: 28 * root.scale, weight: 400, lineHeight: 36 * root.scale, tracking: 0.1 })
            readonly property var small:   ({ family: fontFamilies.sans, size: 24 * root.scale, weight: 400, lineHeight: 32 * root.scale, tracking: 0.1 })
        }

        readonly property JsonObject title: JsonObject {
            readonly property var large:   ({ family: fontFamilies.sans, size: 22 * root.scale, weight: 400, lineHeight: 28 * root.scale, tracking: 0 })
            readonly property var medium:  ({ family: fontFamilies.sans, size: 16 * root.scale, weight: 500, lineHeight: 24 * root.scale, tracking: 0.15 })
            readonly property var small:   ({ family: fontFamilies.sans, size: 14 * root.scale, weight: 500, lineHeight: 20 * root.scale, tracking: 0.1 })
        }

        readonly property JsonObject body: JsonObject {
            readonly property var large:   ({ family: fontFamilies.sans, size: 16 * root.scale, weight: 400, lineHeight: 24 * root.scale, tracking: 0.5 })
            readonly property var medium:  ({ family: fontFamilies.sans, size: 14 * root.scale, weight: 400, lineHeight: 20 * root.scale, tracking: 0.25 })
            readonly property var small:   ({ family: fontFamilies.sans, size: 12 * root.scale, weight: 400, lineHeight: 16 * root.scale, tracking: 0.4 })
        }

        readonly property JsonObject label: JsonObject {
            readonly property var large:   ({ family: fontFamilies.sans, size: 14 * root.scale, weight: 500, lineHeight: 20 * root.scale, tracking: 0.1 })
            readonly property var medium:  ({ family: fontFamilies.sans, size: 12 * root.scale, weight: 500, lineHeight: 16 * root.scale, tracking: 0.5 })
            readonly property var small:   ({ family: fontFamilies.sans, size: 11 * root.scale, weight: 500, lineHeight: 16 * root.scale, tracking: 0.5 })
        }

        readonly property JsonObject code: JsonObject {
            readonly property var large:   ({ family: fontFamilies.mono, size: 16 * root.scale, weight: 400, lineHeight: 24 * root.scale, tracking: 0.5 })
            readonly property var medium:  ({ family: fontFamilies.mono, size: 14 * root.scale, weight: 400, lineHeight: 20 * root.scale, tracking: 0.25 })
            readonly property var small:   ({ family: fontFamilies.mono, size: 12 * root.scale, weight: 400, lineHeight: 16 * root.scale, tracking: 0.4 })
        }


        readonly property JsonObject emphasized: JsonObject {
            readonly property JsonObject display: JsonObject {
                readonly property var large:   ({ family: fontFamilies.sans, size: 57 * root.scale, weight: 500, lineHeight: 64 * root.scale, tracking: -0.25 })
                readonly property var medium:  ({ family: fontFamilies.sans, size: 45 * root.scale, weight: 500, lineHeight: 52 * root.scale, tracking: -0.2 })
                readonly property var small:   ({ family: fontFamilies.sans, size: 36 * root.scale, weight: 500, lineHeight: 44 * root.scale, tracking: -0.1 })
            }
            readonly property JsonObject headline: JsonObject {
                readonly property var large:   ({ family: fontFamilies.sans, size: 32 * root.scale, weight: 500, lineHeight: 40 * root.scale, tracking: 0 })
                readonly property var medium:  ({ family: fontFamilies.sans, size: 28 * root.scale, weight: 500, lineHeight: 36 * root.scale, tracking: 0.1 })
                readonly property var small:   ({ family: fontFamilies.sans, size: 24 * root.scale, weight: 500, lineHeight: 32 * root.scale, tracking: 0.1 })
            }
            readonly property JsonObject title: JsonObject {
                readonly property var large:   ({ family: fontFamilies.sans, size: 22 * root.scale, weight: 500, lineHeight: 28 * root.scale, tracking: 0 })
                readonly property var medium:  ({ family: fontFamilies.sans, size: 16 * root.scale, weight: 600, lineHeight: 24 * root.scale, tracking: 0.15 })
                readonly property var small:   ({ family: fontFamilies.sans, size: 14 * root.scale, weight: 600, lineHeight: 20 * root.scale, tracking: 0.1 })
            }
            readonly property JsonObject body: JsonObject {
                readonly property var large:   ({ family: fontFamilies.sans, size: 16 * root.scale, weight: 500, lineHeight: 24 * root.scale, tracking: 0.5 })
                readonly property var medium:  ({ family: fontFamilies.sans, size: 14 * root.scale, weight: 500, lineHeight: 20 * root.scale, tracking: 0.25 })
                readonly property var small:   ({ family: fontFamilies.sans, size: 12 * root.scale, weight: 500, lineHeight: 16 * root.scale, tracking: 0.4 })
            }
            readonly property JsonObject label: JsonObject {
                readonly property var large:   ({ family: fontFamilies.sans, size: 14 * root.scale, weight: 600, lineHeight: 20 * root.scale, tracking: 0.1 })
                readonly property var medium:  ({ family: fontFamilies.sans, size: 12 * root.scale, weight: 600, lineHeight: 16 * root.scale, tracking: 0.5 })
                readonly property var small:   ({ family: fontFamilies.sans, size: 11 * root.scale, weight: 600, lineHeight: 16 * root.scale, tracking: 0.5 })
            }
            readonly property JsonObject code: JsonObject {
                readonly property var large:   ({ family: fontFamilies.mono, size: 16 * root.scale, weight: 400, lineHeight: 24 * root.scale, tracking: 0.5 })
                readonly property var medium:  ({ family: fontFamilies.mono, size: 14 * root.scale, weight: 400, lineHeight: 20 * root.scale, tracking: 0.25 })
                readonly property var small:   ({ family: fontFamilies.mono, size: 12 * root.scale, weight: 400, lineHeight: 16 * root.scale, tracking: 0.4 })
            }
        }
    }
}
