
import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

JsonObject {
    readonly property JsonObject clock: JsonObject {
        // time info
        readonly property string timeFormat: "hh:mm"
        readonly property string dateFormat: "ddd M/dd"
        // analog clock settings
        readonly property bool showMinutesArrow: true
        readonly property bool showSecondsArrow: false
    }
}
