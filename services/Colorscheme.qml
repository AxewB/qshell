pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import qs.services
import Quickshell.Io

// Base16 colors
Singleton {
  id: root

  property Colors colors: Colors {
    id: colors
  }

  property alias base00: colors.base00
  property alias default_background: colors.base00

  property alias base01: colors.base01
  property alias lighter_background: colors.base01

  property alias base02: colors.base02
  property alias seletion_background: colors.base02

  property alias base03: colors.base03
  property alias comments: colors.base03

  property alias base04: colors.base04
  property alias dark_foreground: colors.base04

  property alias base05: colors.base05
  property alias default_foreground: colors.base05

  property alias base06: colors.base06
  property alias light_foreground: colors.base06

  property alias base07: colors.base07
  property alias light_background: colors.base07

  property alias base08: colors.base08
  property alias variables: colors.base08

  property alias base09: colors.base09
  property alias types: colors.base09

  property alias base0A: colors.base0A
  property alias classes: colors.base0A

  property alias base0B: colors.base0B
  property alias strings: colors.base0B

  property alias base0C: colors.base0C
  property alias support: colors.base0C

  property alias base0D: colors.base0D
  property alias functions: colors.base0D

  property alias base0E: colors.base0E
  property alias keywords: colors.base0E

  property alias base0F: colors.base0F
  property alias deprecated: colors.base0F

  function updateColors(text) {
    const jsData = JSON.parse(text);
    const colors = jsData.colors;

    for (const [key, value] of Object.entries(colors)) {
      root.colors[key] = value;
    }
  }

  FileView {
    path: Paths.colorscheme
    watchChanges: true
    onFileChanged: reload()

    onLoaded: {
      root.updateColors(this.text());
    }
  }

  component Colors: QtObject {
    // Base16 -- catppuccin-mocha as default
    property color base00: "#1e1e2e" // # base -- Default Background
    property color base01: "#181825" // # mantle -- Lighter Background (Used for status bars, line number and folding marks)
    property color base02: "#313244" // # surface0 -- Selection Background
    property color base03: "#45475a" // # surface1 -- Comments, Invisibles, Line Highlighting
    property color base04: "#585b70" // # surface2 -- Dark Foreground (Used for status bars)
    property color base05: "#cdd6f4" // # text -- Default Foreground, Caret, Delimiters, Operators
    property color base06: "#f5e0dc" // # rosewater -- Light Foreground (Not often used)
    property color base07: "#b4befe" // # lavender -- Light Background (Not often used)
    property color base08: "#f38ba8" // # red -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    property color base09: "#fab387" // # peach -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
    property color base0A: "#f9e2af" // # yellow -- Classes, Markup Bold, Search Text Background
    property color base0B: "#a6e3a1" // # green -- Strings, Inherited Class, Markup Code, Diff Inserted
    property color base0C: "#94e2d5" // # teal -- Support, Regular Expressions, Escape Characters, Markup Quotes
    property color base0D: "#89b4fa" // # blue -- Functions, Methods, Attribute IDs, Headings
    property color base0E: "#cba6f7" // # mauve -- Keywords, Storage, Selector, Markup Italic, Diff Changed
    property color base0F: "#f2cdcd" // # flamingo -- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    // Base24 additional
    property color base10: "#1e1e2e"
    property color base11: "#1e1e2e"
    property color base12: "#f38ba8"
    property color base13: "#f9e2af"
    property color base14: "#a6e3a1"
    property color base15: "#94e2d5"
    property color base16: "#89b4fa"
    property color base17: "#cba6f7"
  }
}
