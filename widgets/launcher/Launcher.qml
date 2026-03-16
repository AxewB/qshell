pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import qs.components
import qs.services
import "./providers" as Providers

// TODO: read and cache applications
// TODO: make different binds for dirrerent providers (default bind would place `appProvider` as default, `menu` bind would replace povider with `menuProvider` etc.)

Scope {
  id: root
  property bool active: false

  property Providers.Provider currentProvider: appsProvider

  property string prompt: ""
  property int activeEntryIndex: 0

  property var filteredEntries: filterEntries(prompt)
  property var activeEntry: filteredEntries[activeEntryIndex]

  property Providers.Provider appsProvider: Providers.Apps {
    onBindCalled: root.toggleLauncher(this)
  }

  onFilteredEntriesChanged: activeEntryIndex = 0

  function toggleLauncher(provider) {
    if (root.active) {
      root.active = false;
      return;
    }

    root.active = !root.active;
    currentProvider = provider;
    root.reset();
  }

  function execute() {
    currentProvider.execute(activeEntry);
    root.active = false;
  }

  function reset() {
    prompt = "";
    grab.windows = [];
  }

  function activate_menu_item(item) {
    if (item) {
      Quickshell.execDetached(["sh", "-c", item.cmd]);
    } else {
      Quickshell.execDetached(["sh", "-c", "notify-send 'Minsh' 'Something went wrong while activating item'"]);
    }
    root.active = false;
  }

  Loader {
    active: root.active
    sourceComponent: MinshPanelWindow {
      id: launcherWindow

      focusable: true

      implicitWidth: launcherContent.implicitWidth
      implicitHeight: launcherContent.implicitHeight

      anchors.left: true
      anchors.top: true
      anchors.right: true
      anchors.bottom: true

      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

      MouseArea {
        anchors.fill: parent
        onClicked: root.active = false
      }

      MinshWrapperRectangle {
        id: launcherContent
        opacity: root.active ? 1 : 0
        anchors.centerIn: parent
        color: Colorscheme.base00
        margin: 16
        radius: 8
        border.width: 2
        border.color: Colorscheme.base07
        ColumnLayout {
          spacing: 16
          MinshWrapperRectangle {
            Layout.fillWidth: true
            Layout.preferredWidth: 400
            color: Colorscheme.base01
            clip: true
            margin: 8
            RowLayout {
              width: parent.width
              MinshText {
                size: 16
                opacity: 0.6
                text: root.currentProvider.promptHint
              }
              MinshRectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                MinshTextInput {
                  id: promptInput
                  focus: true
                  onFocusChanged: console.log(focus)
                  anchors.fill: parent

                  onAccepted: root.execute()
                  onTextEdited: root.prompt = this.text
                  size: 16

                  Keys.onPressed: event => {
                    if (event.key === Qt.Key_Escape) {
                      root.active = false;
                      return;
                    }
                  }
                }
              }
            }
          }

          ListView {
            id: listView
            Layout.preferredWidth: 400
            Layout.preferredHeight: 320
            spacing: 4
            orientation: ListView.Vertical
            model: root.filteredEntries
            currentIndex: root.activeEntryIndex
            clip: true

            delegate: Providers.AppDisplay {
              width: listView.width
              color: index === listView.currentIndex ? Colorscheme.base02 : "transparent"
              onClicked: (entry, index) => {
                root.activeEntryIndex = index;
                root.execute();
              }
            }
            // Autoscroll
            onCurrentIndexChanged: positionViewAtIndex(currentIndex, ListView.Center)

            ScrollBar.vertical: ScrollBar {
              id: vbar
              active: true
              policy: ScrollBar.AsNeeded
            }
          }

          RowLayout {
            Layout.alignment: Qt.AlignRight
            width: parent.width
            ActionHint {
              action: cycle_entries_backwards
            }
            ActionHint {
              action: cycle_entries_forward
            }
          }
        }
      }

      Action {
        id: cycle_entries_forward
        text: qsTr("Next")
        shortcut: "Ctrl+j"
        onTriggered: root.activeEntryIndex = (root.activeEntryIndex + 1) % listView.count
      }

      Action {
        id: cycle_entries_backwards
        text: qsTr("Prev")
        shortcut: "Ctrl+k"
        onTriggered: root.activeEntryIndex = (root.activeEntryIndex - 1 + listView.count) % listView.count
      }

      Component.onCompleted: {
        grab.windows.push(launcherWindow);
        console.log(grab.windows);
      }

      MultiEffect {
        source: launcherContent
        anchors.fill: launcherContent
        shadowEnabled: true
        blurMax: 16
        shadowColor: "black"
      }
    }
  }

  HyprlandFocusGrab {
    id: grab
    windows: []
    active: true
  }

  function filterEntries(query, numResults = 5, fuzzyRatio = 0.3) {
    let result;
    if (!query) {
      result = currentProvider.entries.map(entry => ({
            entry: entry,
            score: 1.0
          }));
      return result;
    }

    result = currentProvider.entries.map(entry => {
      let score = fuzzyMatchString(entry.name, query, fuzzyRatio);
      return {
        entry: entry,
        score: score
      };
    }).filter(entry => entry.score > 0).sort((a, b) => b.score - a.score).sort((a, b) => {
      if (a.score < b.score) {
        return 1
      } else {
        return -1
      }
      return 0
    })
    //.slice(0, numResults);  // top numResults results

    return result;
  }

  function fuzzyMatchString(haystack, needle, ratio) {
    haystack = haystack.toLowerCase();
    needle = needle.toLowerCase();

    if (haystack.indexOf(needle) > -1) {
      return 1.0;
    }

    let matches = 0;
    for (let i = 0; i < needle.length; i++) {
      if (haystack.indexOf(needle[i]) > -1) {
        matches += 1;
      } else {
        matches -= 1;
      }
    }

    let score = matches / haystack.length;
    return (score >= ratio || needle === "") ? Math.max(0, score) : 0;
  }

  Component.onCompleted: {
    root.filterEntries();
  }
}
