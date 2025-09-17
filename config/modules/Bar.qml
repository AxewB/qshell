
import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

JsonObject {
    readonly property JsonObject clock: JsonObject {
        readonly property string timeFormat: "hh:mm"
        readonly property string dateFormat: "ddd M/dd"
    }
}
