pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Notifications
import qs.components
import qs.service
import qs.utils

// Что можно добавить:
// - линия-индикатор, которая будет показывать, когда уведомление само закроется

WrapperRectangle {
    id: root

    // Notification props
    readonly property var id: model.id
    readonly property var actions: model?.actions
    readonly property string appIcon: model?.appIcon
    readonly property string appName: model?.appName
    readonly property string body: model?.body
    readonly property string image: model?.image
    readonly property string summary: model?.summary
    readonly property string urgency: model?.urgency
    readonly property bool hasInlineReply: model?.hasInlineReply ?? false
    readonly property string inlineReplyPlaceholder: model?.inlineReplyPlaceholder ?? ""

    // additional props
    readonly property double time: model?.time

    property string timeString: "now"

    function updateTimeString() {
        root.timeString = TimeUtils.formatRelativeTime(model.time)
    }

    radius: Appearance.radius.normal
    color: Colors.palette.m3surface
    margin: Appearance.padding.enormous
    width: parent ? parent.width : 0


    ColumnLayout {
        spacing: Appearance.padding.enormous

        WrapperItem {
            Layout.fillWidth: true
            RowLayout {
                id: content
                width: parent.width
                spacing: Appearance.padding.huge

                Item {
                    width: Appearance.icon.small * 2
                    height: Appearance.icon.small * 2

                    ClippingWrapperRectangle {
                        id: notificationImageWrapper
                        anchors.fill: parent
                        radius: Appearance.radius.small
                        Layout.alignment: Qt.AlignCenter
                        color: model.image ? "transparent" : Colors.palette.m3surfaceContainer

                        Image {
                            id: notificationImage
                            anchors.fill: notificationImageWrapper
                            source: model.image
                        }

                        Icon {
                            id: notificationImageReplacer
                            icon: "notifications"
                            size: 36
                            anchors.centerIn: parent
                            color: Colors.palette.m3onSurface
                        }

                        child: model.image ? notificationImage : notificationImageReplacer
                    }

                }

                WrapperItem {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout {
                        WrapperItem {
                            RowLayout {

                                StyledText {
                                    text: notifSummaryMetrics.elidedText
                                    color: Colors.palette.m3onSurface
                                }

                                CircleDivider {color: Colors.palette.m3surfaceVariant}

                                StyledText {
                                    text: model.appName
                                    color: Colors.palette.m3surfaceVariant
                                }

                                TextMetrics {
                                    id: notifSummaryMetrics
                                    font.family: Appearance.font.family ?? ""
                                    font.pixelSize: Appearance?.font.size.normal ?? 0
                                    elide: Text.ElideRight
                                    elideWidth: 140
                                    text: model.summary
                                }
                                TextMetrics {
                                    id: notifAppNameMetrics
                                    font.family: Appearance.font.family ?? ""
                                    font.pixelSize: Appearance?.font.size.normal ?? 0
                                    elide: Text.ElideRight
                                    elideWidth: 100
                                    text: model.appName
                                }
                            }
                        }
                        StyledText {
                            text: notifBodyMetrics.elidedText
                            color: Colors.palette.m3onSurface
                        }
                        TextMetrics {
                            id: notifBodyMetrics
                            font.family: Appearance.font.family ?? ""
                            font.pixelSize: Appearance?.font.size.normal ?? 0
                            elide: Text.ElideRight
                            elideWidth: 260
                            text: model.body
                        }
                    }
                }

                WrapperItem {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 0

                        StyledText {
                            id: timeText
                            text: root.timeString
                            color: Colors.palette.m3surfaceVariant
                            Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        }
                    }
                }
            }
        }



        RowLayout {
            visible: model.actions && model.actions.count > 0
            spacing: Appearance.padding.huge
            Layout.fillWidth: true

            Repeater {
                Layout.fillWidth: true
                model: model.actions

                StyledButton {
                    required property var modelData

                    StyledText {
                        text: modelData?.text ?? "Unknown"
                        color: Colors.palette.m3surfaceVariant
                        anchors.centerIn: parent

                    }

                    onLeftClicked: {
                        console.log("Action clicked:", modelData?.identifier, modelData?.text)
                        if (modelData?.originalAction) {
                            modelData.originalAction.invoke()
                        }
                    }
                }
            }
        }


        // inline reply
        // RowLayout {
        //     visible: root.hasInlineReply
        //     spacing: Appearance.padding.huge
        //     Layout.fillWidth: true

        //     TextField {
        //         id: inlineReplyField
        //         Layout.fillWidth: true
        //         placeholderText: root.inlineReplyPlaceholder || "Reply..."
        //         background: Rectangle {
        //             color: Colors.palette.m3surfaceBright
        //             radius: Appearance.radius.normal
        //             border.width: 1
        //             border.color: Colors.palette.m3surfaceVariant
        //         }
        //         color: Colors.palette.m3onSurface

        //         Keys.onPressed: (event) => {
        //             if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
        //                 sendReply()
        //                 event.accepted = true
        //             }
        //         }

        //         function sendReply() {
        //             if (text.trim() !== "") {
        //                 console.log("Sending inline reply:", text)
        //                 if (model && model.notification) {
        //                     model.notification.sendInlineReply(text)
        //                 }
        //                 text = ""
        //             }
        //         }
        //     }

        //     MouseArea {
        //         width: 60
        //         height: inlineReplyField.height

        //         Rectangle {
        //             anchors.fill: parent
        //             color: Colors.palette.m3primary
        //             radius: Appearance.radius.normal

        //             StyledText {
        //                 text: "Send"
        //                 anchors.centerIn: parent
        //                 color: Colors.palette.m3onPrimary
        //             }
        //         }

        //         onClicked: {
        //             inlineReplyField.sendReply()
        //         }
        //     }
        // }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: root.updateTimeString()
    }
}
