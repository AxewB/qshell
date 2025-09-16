pragma ComponentBehavior: Bound
import Quickshell.Io
JsonObject {
    id: padding
    property real scale: 1

    readonly property real xsmall: 1 * padding.scale
    readonly property real small: 2 * padding.scale
    readonly property real medium: 4 * padding.scale
    readonly property real large: 8 * padding.scale
    readonly property real huge: 12 * padding.scale
    readonly property real enormous: 16 * padding.scale
}
