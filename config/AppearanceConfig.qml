import Quickshell.Io

JsonObject {
    id: root

    property real scale: 1.0
    readonly property Padding padding: Padding {}
    readonly property Font font: Font {}
    readonly property Icon icon: Icon {}
    readonly property Radius radius: Radius {}
    readonly property Animation animation: Animation {}

    component Radius: JsonObject {
        readonly property real xsmall: 6 * root.scale
        readonly property real small: 10 * root.scale
        readonly property real normal: 20 * root.scale
        readonly property real large: 30 * root.scale
        readonly property real huge: 40 * root.scale
        readonly property real full: 1000
    }

    component Padding: JsonObject {
        readonly property real xsmall: 1 * root.scale
        readonly property real small: 2 * root.scale
        readonly property real normal: 4 * root.scale
        readonly property real large: 6 * root.scale
        readonly property real huge: 8 * root.scale
        readonly property real enormous: 16 * root.scale
    }

    component FontSize: JsonObject {
        readonly property real h1: 24 * root.scale
        readonly property real h2: 20 * root.scale
        readonly property real h3: 16 * root.scale
        readonly property real text: 14 * root.scale
        readonly property real subtext: 12 * root.scale
    }

    component FontFamily: JsonObject {
        readonly property string sans: "Roboto"
        readonly property string mono: "IosevkaTermSlab Nerd Font"
        readonly property string icons: "Material Symbols Rounded"
    }

    component Font: JsonObject {
        readonly property FontFamily family: FontFamily {}
        readonly property int weight: 400
        readonly property FontSize size: FontSize {}
    }

    component Icon: JsonObject {
        readonly property real xsmall: 20 * root.scale
        readonly property real small: 24 * root.scale
        readonly property real normal: 32 * root.scale
        readonly property real larger: 40 * root.scale
        readonly property real large: 48 * root.scale
    }

    component Animation: JsonObject {
        readonly property AnimationDuration durations: AnimationDuration {}
        readonly property AnimationCurves curves: AnimationCurves {}
    }

    component AnimationDuration: JsonObject {
        readonly property int fast: 150
        readonly property int normal: 250
        readonly property int slow: 400
        readonly property int turtle: 600
    }

    component AnimationCurves: JsonObject {
        property list<string> stringList: [ "default", "value" ]

        // Somehow var instead of list<var> crashes Quickshell entirely
        // But with list<var> everything saves in json as it should be, so
        // it's not big deal
        readonly property list<var> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<var> bounce: [0.68, -0.55, 0.27, 1.55, 1.0, 1.0]

        readonly property list<var> xsmall: [0.25, 0.1, 0.25, 1.0, 1.0, 1.0]
        readonly property list<var> easeIn: [0.42, 0.0, 1.0, 1.0, 1.0, 1.0]
        readonly property list<var> easeOut: [0.0, 0.0, 0.58, 1.0, 1.0, 1.0]
        readonly property list<var> easeInOut: [0.42, 0.0, 0.58, 1.0, 1.0, 1.0]
        readonly property list<var> linear: [0.0, 0.0, 1.0, 1.0, 1.0, 1.0]
        readonly property list<var> easeInQuad: [0.55, 0.085, 0.68, 0.53, 1.0, 1.0]
        readonly property list<var> easeOutQuad: [0.25, 0.46, 0.45, 0.94, 1.0, 1.0]
        readonly property list<var> easeInOutQuad: [0.455, 0.03, 0.515, 0.955, 1.0, 1.0]
    }
}
