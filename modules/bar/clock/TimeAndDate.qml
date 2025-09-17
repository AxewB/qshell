pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.components.common as Common
import qs.service
import qs.config

Item {
    id: root

    property SystemClock systemClock: systemClockDefault
    property string time: Qt.formatDateTime(systemClock.date, Config.bar.clock.timeFormat)
    property string date: Qt.formatDateTime(systemClock.date, Config.bar.clock.dateFormat)

    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth


    ColumnLayout {
        id: content
        spacing: 0
        WrapperRectangle {
            Layout.alignment: Qt.AlignHCenter
            color:"transparent"
            Common.Text {
                text: root.time
                type: "body"
                font.weight: Font.Bold
            }
        }
        WrapperRectangle {

            color:"transparent"
            Layout.alignment: Qt.AlignHCenter
            Common.Text {
                text: root.date
                type: "label"
                color: Colors.palette.m3onSurfaceVariant
            }
        }
    }


    SystemClock {
        enabled: root.systemClock?.objectName && root.systemClock?.objectName === this.objectName
        objectName: "defaultClock"
        id: systemClockDefault
    }
}
