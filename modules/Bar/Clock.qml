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

        // margin: Appearance.padding.huge

        RowLayout {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter



            StyledText {
                color: Colors.palette.m3onSurface
                text: Qt.formatDateTime(clock.date, "hh:mm")
            }
            CircleDivider {
                color: Colors.palette.m3surfaceBright
            }
            RoundClock { }

            CircleDivider {
                color: Colors.palette.m3surfaceBright
            }
            StyledText {
                color: Colors.palette.m3onSurface
                text: Qt.formatDateTime(clock.date, "ddd M")
            }
        }
    }


    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
