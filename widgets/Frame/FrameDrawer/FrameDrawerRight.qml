import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/config"
import "root:/utils"
import "root:/components"
import "root:/widgets/Bar"

WrapperItem {
    id: root
    required property bool isOpened
    implicitWidth: content.implicitWidth - insideContent.implicitWidth * !root.isOpened

    WrapperItem {
        id: content

        RowLayout {
            spacing: Appearance.padding.large
            layoutDirection: Qt.LeftToRight

            WrapperItem {
                id: outsideContent
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }

                ColumnLayout { }
            }
            WrapperItem {
                id: insideContent
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }

                ColumnLayout { }
            }
        }
    }

    Behavior on implicitHeight {Anim{}}
    Behavior on implicitWidth {Anim{}}
    component Anim: NumberAnimation {
        duration: Appearance.animation.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animation.curves.ease
    }
}
