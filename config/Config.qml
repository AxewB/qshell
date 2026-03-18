pragma Singleton
import Quickshell
import QtQuick
import qs.services

Singleton {
  property string wallpaper: `${Paths.wallpapers}/flatppuccin/flatppuccin_4k_macchiato.png`
  property BarConfig bar: BarConfig {}


  component BarConfig: QtObject {
    property bool floating: false
  }
}
