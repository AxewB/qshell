pragma ComponentBehavior: Bound
import Quickshell.Io

JsonObject {
    id: radius
    property real scale: 1

    readonly property real xsmall: 4 * radius.scale
    readonly property real small: 8 * radius.scale
    readonly property real medium: 12 * radius.scale
    readonly property real larger: 16 * radius.scale
    readonly property real large: 20 * radius.scale
    readonly property real xlarge: 28 * radius.scale
    readonly property real xxlarger: 32 * radius.scale
    readonly property real xxlarge: 48 * radius.scale
    readonly property real full: 1000 * radius.scale
}
