pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.service
import qs.config
import qs.utils
import qs.components

Item {
    id: root
    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth

    WrapperItem {
        id: content

        // margin: Config.appearance.padding.huge

        RowLayout {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            spacing: Config.appearance.padding.huge


            WrapperItem {
                ColumnLayout {
                    spacing: -Config.appearance.padding.small
                    StyledText {
                        Layout.alignment: Qt.AlignHCenter
                        color: Colors.palette.m3onSurface
                        text: Qt.formatDateTime(clock.date, "hh:mm")
                    }
                    StyledText {
                        Layout.alignment: Qt.AlignHCenter
                        type: "subtext"
                        color: Colors.palette.m3onSurface
                        opacity: 0.6
                        text: Qt.formatDateTime(clock.date, "MMM, dd")
                    }
                }
            }

            RoundClock { radius: 12 }
        }
    }


    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
