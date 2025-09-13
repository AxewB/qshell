import qs.config

Button {
    id: root
    property string iconName: "indeterminate_question_box"
    property string widthSize: "default" // narrow | default | wide
    showOnlyIcon: true
    prependIcon: iconName

    iconSize: {
        if (root.size === "xsmall") return Config.appearance.icon.size.small;
        if (root.size === "medium") return Config.appearance.icon.size.medium;
        if (root.size === "large")  return Config.appearance.icon.size.large;
        if (root.size === "xlarge") return Config.appearance.icon.size.xlarge;
        return Config.appearance.icon.size.small
    }
    implicitWidth: {
        if (widthSize === "narrow") {
            if (root.size === "xsmall") return 28;
            if (root.size === "medium") return 48
            if (root.size === "large")  return 64
            if (root.size === "xlarge") return 104
            return 40
        }
        if (widthSize === "wide") {
            if (root.size === "xsmall") return 40
            if (root.size === "medium") return 72
            if (root.size === "large")  return 128
            if (root.size === "xlarge") return 184
            return 52
        }

        // default
        return height
    }
}
