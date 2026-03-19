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

    WlrLayershell.layer: WlrLayer.Overlay

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

            delegate: NotificationItem {}
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

  component NotificationItem:WrapperMouseArea {
    id: notificationRoot
    required property var modelData
    property NotificationAction activateAction

    property bool isActionOnlyActivate: {
      const actions = notificationRoot.modelData.actions
      if (actions.length > 1) {
        return false
      }
      const activateAction = actions?.find(a => a.text.toLowerCase().includes("activate"))

      notificationRoot.activateAction = activateAction

      if (activateAction) {
        return true
      }
    }

    Layout.fillWidth: true
    acceptedButtons: Qt.RightButton | Qt.LeftButton
    onClicked: event => {
      if (event.button == Qt.RightButton) {
        modelData.dismiss()
      }

      if (event.button == Qt.LeftButton && isActionOnlyActivate && activateAction) {
        notificationRoot.modelData.dismiss(activateAction)
      }
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

        NotificationActions {
          visible: !notificationRoot.isActionOnlyActivate
          actions: notificationRoot.modelData.actions
        }
      }
    }
  }

  component NotificationActions: RowLayout {
    id: notificationActions
    required property list<NotificationAction> actions
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
