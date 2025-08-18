import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Io
import qs.service
import qs.config
import qs.components

Scope {
	id: root

	// Bind the pipewire node so its volume will be tracked
	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	property bool shouldShowOsd: false

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
	}

	LazyLoader {
		active: root.shouldShowOsd

		PanelWindow {
			anchors.right: true
			exclusiveZone: 0
			implicitWidth: control.implicitWidth
			implicitHeight: control.implicitHeight
			WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Overlay
			color: "transparent"

			SoundOSDBar {
    			id: control
    			icon: Pipewire.defaultAudioSink?.audio.muted ? "volume_off" : 'volume_up'
    			progress: (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                active: Pipewire.defaultAudioSink?.audio.muted
                onTopClicked: {
                    if (!Pipewire.defaultAudioSink) {
                        errorMuting.startDetached()
                        return
                    }
                    Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink?.audio.muted
                }
                onBottomClicked: soundSettingsLinkProc.startDetached()
                onWheelUp: {
                    Pipewire.defaultAudioSink.audio.volume += 0.02
                }
                onWheelDown: {
                    Pipewire.defaultAudioSink.audio.volume -= 0.02
                }
			}
		}
	}

	Process {
        id: errorMuting
        command: ['notify-send', "Error", "There is an error while trying to mute audio"]
    }

	// TODO: Когда сделаю виджет для настройки звука, надо отсюда сделать переход в него
    Process {
        id: soundSettingsLinkProc
        command: ['notify-send', "Not implemented", "Here should be link to audio settings, which is not exists right now"]
    }
}
