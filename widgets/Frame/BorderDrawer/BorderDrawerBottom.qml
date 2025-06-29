import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "root:/service"
import "root:/utils"
import "root:/components"
import "root:/widgets/Bar"

WrapperItem {
    id: root
    required property bool isOpened
    implicitHeight: content.implicitHeight - insideContent.implicitHeight * !root.isOpened

    WrapperItem {
        id: content

        Column {
            spacing: Appearance.padding.large

            WrapperItem {
                id: outsideContent
                anchors {
                    right: parent.right
                    left: parent.left
                }

                RowLayout { }
            }
            WrapperItem {
                id: insideContent
                anchors {
                    right: parent.right
                    left: parent.left
                }

                RowLayout { }
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
