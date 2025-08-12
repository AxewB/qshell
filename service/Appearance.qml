pragma ComponentBehavior

pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property real scale: 1.0
    readonly property Padding padding: Padding {}
    readonly property Language language: Language {}
    readonly property Font font: Font {}
    readonly property Icon icon: Icon {}
    readonly property Radius radius: Radius {}
    readonly property Animation animation: Animation {}

    component Radius: QtObject {
        readonly property real xsmall: 6 * root.scale
        readonly property real small: 10 * root.scale
        readonly property real normal: 20 * root.scale
        readonly property real large: 30 * root.scale
        readonly property real huge: 40 * root.scale
        readonly property real full: 1000
    }

    component Padding: QtObject {
        readonly property real xsmall: 1 * root.scale
        readonly property real small: 2 * root.scale
        readonly property real normal: 4 * root.scale
        readonly property real large: 6 * root.scale
        readonly property real huge: 8 * root.scale
        readonly property real enormous: 16 * root.scale
    }

    component FontSize: QtObject {
        readonly property real h1: 24 * root.scale
        readonly property real h2: 20 * root.scale
        readonly property real h3: 16 * root.scale
        readonly property real text: 14 * root.scale
        readonly property real subtext: 12 * root.scale
    }

    component Font: QtObject {
        readonly property string family: "Roboto"
        // readonly property string family: "CaskaydiaCove Nerd Font Mono"
        // readonly property string family: "JetBrainsMono Nerd Font Mono"
        readonly property int weight: 400
        readonly property FontSize size: FontSize {}
    }

    component Icon: QtObject {
        readonly property real xsmall: 18 * root.scale
        readonly property real small: 24 * root.scale
        readonly property real normal: 30 * root.scale
        readonly property real large: 72 * root.scale
    }


    component Language: QtObject {
        readonly property string english: "en-us"
        readonly property string russian: "ru-ru"
    }

    component Animation: QtObject {
        readonly property AnimationDuration durations: AnimationDuration {}
        readonly property AnimationCurves curves: AnimationCurves {}
    }

    component AnimationDuration: QtObject {
        readonly property int fast: 150
        readonly property int normal: 250
        readonly property int slow: 400
        readonly property int turtle: 600
    }

    component AnimationCurves: QtObject {
        readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> bounce: [0.68, -0.55, 0.27, 1.55, 1.0, 1.0]

        // Popular ones
        readonly property list<real> xsmall: [0.25, 0.1, 0.25, 1.0, 1.0, 1.0]
        readonly property list<real> easeIn: [0.42, 0.0, 1.0, 1.0, 1.0, 1.0]
        readonly property list<real> easeOut: [0.0, 0.0, 0.58, 1.0, 1.0, 1.0]
        readonly property list<real> easeInOut: [0.42, 0.0, 0.58, 1.0, 1.0, 1.0]
        readonly property list<real> linear: [0.0, 0.0, 1.0, 1.0, 1.0, 1.0]
        readonly property list<real> easeInQuad: [0.55, 0.085, 0.68, 0.53, 1.0, 1.0]
        readonly property list<real> easeOutQuad: [0.25, 0.46, 0.45, 0.94, 1.0, 1.0]
        readonly property list<real> easeInOutQuad: [0.455, 0.03, 0.515, 0.955, 1.0, 1.0]
    }
}
