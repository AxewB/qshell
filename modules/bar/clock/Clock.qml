import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes

import Quickshell
import Quickshell.Widgets

import qs.config
import qs.service

Item {
    implicitHeight: content.implicitHeight
    implicitWidth: content.implicitWidth
    WrapperItem {
        id: content

        margin: Config.appearance.padding.medium
        RowLayout {
            spacing: Config.appearance.padding.large
            AnalogClock { systemClock: systemClock }
            TimeAndDate { systemClock: systemClock }
        }
    }
    SystemClock { id: systemClock }
}
