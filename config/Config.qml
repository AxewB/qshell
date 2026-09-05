pragma Singleton
import Quickshell
import QtQuick
import qs.services

Singleton {
  // property string wallpaper: `${Paths.wallpapers}/catppuccin/flatppuccin/flatppuccin_4k_macchiato.png`
  property string wallpaper: `${Paths.wallpapers}/gruvbox/minimalistic/sunset.png`
  property BarConfig bar: BarConfig {}


  component BarConfig: QtObject {
    property bool floating: false
  }
}
