import QtQuick as QQ
import QtQuick.Effects as Effects
import qs.config
import qs.service

Effects.MultiEffect {
    id: root

    property QQ.Item target: null
    property int level: 0

    readonly property var elevation: Config.appearance?.elevation[level] ?? null

    anchors.fill: target
    visible: target !== null

    shadowEnabled: true
    shadowColor: Colors.palette.m3shadow
    shadowOpacity: elevation?.shadow?.opacity ?? 0
    shadowVerticalOffset: elevation?.shadow?.y ?? 0
    shadowHorizontalOffset: elevation?.shadow?.x ?? 0
    shadowBlur: elevation?.shadow?.blur ?? 0
}
