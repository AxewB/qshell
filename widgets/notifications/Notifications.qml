pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.Notifications

import qs.components
import qs.services

Scope {
  id: root
  required property Item bar
  property string shortcutName: "toggle-rightbar"
  property bool active: false

  MinshPanelWindow {
    id: launcherWindow

    anchors.right: true
    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    focusable: true

    margins.right: 16
    margins.top: 16

    // exclusionMode: ExclusionMode.Ignore
    // exclusiveZone: 0
    WlrLayershell.layer: WlrLayer.Top
    mask: Region {
      item: content
    }

    MouseArea {
      id: content
      anchors.top: parent.top;
      anchors.right: parent.right;
      implicitHeight: notificationList.implicitHeight;
      width: 280;

      MinshWrapperRectangle {
        anchors.fill: parent
        id: notificationList

        ColumnLayout {
          width: parent.width
          spacing: 8
          Repeater {
            model: NotificationService.notifList

            delegate: WrapperMouseArea {
              id: notificationRoot
              required property var modelData
              Layout.fillWidth: true
              acceptedButtons: Qt.RightButton
              onClicked: {
                modelData.dismiss()
              }
              MinshWrapperRectangle {
                color: Colorscheme.base00
                radius: 8
                margin: 8
                border.width: 2
                border.color: Colorscheme.base07
                ColumnLayout {
                  implicitHeight: notificationRoot.implicitHeight
                  implicitWidth: notificationRoot.implicitWidth
                  spacing: 8

                  RowLayout {
                    spacing: 8
                    IconImage {
                      Layout.preferredHeight: 16
                      Layout.preferredWidth: 16
                      asynchronous: true
                      source: Quickshell.iconPath(notificationRoot.modelData.appIcon, true)
                    }

                    MinshText {
                      text: notificationRoot.modelData?.summary ?? ""
                      size: 14
                    }
                  }


                  MinshText {
                    Layout.fillWidth: true
                    text: notificationRoot.modelData?.body ?? ""
                    textFormat: Text.MarkdownText
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                  }

                  RowLayout {
                    spacing: 8
                    Repeater {
                      model: notificationRoot.modelData.actions
                      delegate: MinshWrapperRectangle {
                        required property NotificationAction modelData
                        MinshButton {
                          text: parent.modelData?.text ?? ""
                          onClicked: {
                            notificationRoot.modelData.dismiss(parent.modelData)
                          }
                        }
                      } 
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    // Component.onCompleted: {
    //   Quickshell.execDetached(["sh", "-c", "notify-send -u critical -t 5000 -a \"MyApp\" -i \"dialog-information\" -c \"device.dvd\" -A \"yes=Да\" -A \"no=Нет\" -A \"cancel=Отмена\" \"Заголовок уведомления (summary)\" \"<b>Текст уведомления (body)</b><br><a href='https://example.com'>Ссылка</a><br><img src='file:///usr/share/icons/hicolor/48x48/apps/firefox.png'>\""
    // ])
    // }

    MultiEffect {
      source: content
      anchors.fill: content
      shadowEnabled: true
      blurMax: 16
      shadowColor: "black"
    }
  }
}
