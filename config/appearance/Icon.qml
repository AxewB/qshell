pragma ComponentBehavior: Bound
import Quickshell.Io
JsonObject {
    id: icon
    property real scale: 1
    readonly property string family: "Material Symbols Rounded"
    readonly property IconSize size: IconSize {}

    component IconSize: JsonObject {
        readonly property real xsmall: 18 * icon.scale
        readonly property real small: 20 * icon.scale
        readonly property real medium: 24 * icon.scale
        readonly property real large: 32 * icon.scale
        readonly property real xlarge: 40 * icon.scale
    }
}
