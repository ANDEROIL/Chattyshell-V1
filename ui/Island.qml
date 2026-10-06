import "../services"
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    // ─────────────────────────────────────
    // State
    // ─────────────────────────────────────
    property bool expanded: false
    readonly property bool lowBattery: Battery.percentage <= 20

    // ─────────────────────────────────────
    // Theme (temporary)
    // ─────────────────────────────────────
    readonly property color islandColor: "#DD111113"
    readonly property color borderColor: "#33FFFFFF"

    readonly property color pillBg: "#19191C"
    readonly property color pillBorder: "#33FFFFFF"

    readonly property color batteryGood: "#7DFFB2"
    readonly property color batteryLow: "#FF8A8A"

    readonly property color textPrimary: "white"
    readonly property color textSecondary: "#AAFFFFFF"

    // ─────────────────────────────────────
    // Size
    // ─────────────────────────────────────
    width: expanded ? 620 : (lowBattery ? 320 : 270)
    height: expanded ? 64 : 34
    radius: height / 2

    color: islandColor
    border.color: borderColor
    border.width: 1
    clip: true

    Behavior on width {
        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
    }

    Behavior on height {
        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
    }

    // Hover detection
    MouseArea {
        id: hover
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.expanded = !root.expanded
    }
    readonly property bool hovered: hover.containsMouse

    // ─────────────────────────────────────
    // Clock
    // ─────────────────────────────────────
    property string currentTime: Qt.formatTime(new Date(), "hh:mm")

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.currentTime = Qt.formatTime(new Date(), "hh:mm")
    }

    // ======================================================
    // COMPACT MODE
    // ======================================================
    Item {
        anchors.fill: parent
        visible: !root.expanded
        opacity: root.expanded ? 0 : 1

        Behavior on opacity { NumberAnimation { duration: 120 } }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 10
            spacing: 10

            WorkspaceDots {
                shown: 5
            }

            Item { Layout.fillWidth: true }

            Text {
                text: root.lowBattery
                      ? (Battery.charging ? "Charging" : "Low battery")
                      : root.currentTime

                color: root.textPrimary
                font.pixelSize: 12
                font.weight: Font.DemiBold
            }

            // Battery capsule
            Rectangle {
                Layout.preferredWidth: 58
                Layout.preferredHeight: 22
                radius: 11
                color: root.pillBg
                border.color: root.pillBorder
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 7
                    anchors.rightMargin: 6
                    spacing: 4

                    Text {
                        text: Battery.charging
                              ? "󰂄"
                              : Battery.percentage + "%"

                        color: Battery.charging ? "#79F2A4" : root.textPrimary
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 9
                        font.weight: Font.DemiBold
                    }

                    Item { Layout.fillWidth: true }

                    Item {
                        width: 18
                        height: 10

                        Rectangle {
                            width: 15
                            height: 8
                            radius: 2
                            anchors.verticalCenter: parent.verticalCenter

                            color: "#22FFFFFF"
                            border.color: "#55FFFFFF"
                            border.width: 1

                            Rectangle {
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom

                                width: Math.max(
                                    2,
                                    (parent.width - 2) * Battery.percentage / 100
                                )

                                radius: 1
                                color: Battery.charging
                                       ? "#79F2A4"
                                       : (root.lowBattery
                                            ? root.batteryLow
                                            : root.batteryGood)
                            }
                        }

                        Rectangle {
                            width: 2
                            height: 4
                            radius: 1
                            anchors.left: parent.right
                            anchors.leftMargin: 1
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#66FFFFFF"
                        }
                    }
                }
            }

            // Volume pill
            Text {
                text: Volume.muted
                      ? "󰖁"
                      : "󰕾 " + Volume.percentage + "%"

                color: Volume.muted ? root.batteryLow : root.textPrimary
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 12
                font.weight: Font.DemiBold
            }
        }
    }

    // ======================================================
    // EXPANDED MODE
    // ======================================================
    Item {
        anchors.fill: parent
        visible: root.expanded
        opacity: root.expanded ? 1 : 0

        Behavior on opacity { NumberAnimation { duration: 150 } }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            Rectangle {
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                radius: 11
                color: "#22FFFFFF"
                clip: true

                Image {
                    anchors.fill: parent
                    source: Mpris.available ? Mpris.artUrl : ""
                    fillMode: Image.PreserveAspectCrop
                    visible: Mpris.available && Mpris.artUrl !== ""
                    asynchronous: true
                }

                Text {
                    anchors.centerIn: parent
                    text: "♪"
                    color: root.textPrimary
                    font.pixelSize: 18
                    visible: !Mpris.available || Mpris.artUrl === ""
                }
            }

            ColumnLayout {
                spacing: 0

                Text {
                    text: Mpris.available
                          ? Mpris.title
                          : "You aint playing shit bro"

                    color: root.textPrimary
                    font.pixelSize: 13
                    font.weight: Font.DemiBold
                    elide: Text.ElideRight
                }

                Text {
                    text: Mpris.available
                          ? Mpris.artist
                          : "what did you expected?"

                    color: root.textSecondary
                    font.pixelSize: 11
                    elide: Text.ElideRight
                }
            }

            Item { Layout.fillWidth: true }

            RowLayout {
                spacing: 12

                Text {
                    text: Battery.percentage + "%"
                    color: root.textPrimary
                    font.pixelSize: 12
                    font.weight: Font.DemiBold
                }

                Rectangle { width: 1; height: 18; color: "#33FFFFFF" }

                Text {
                    text: root.currentTime
                    color: root.textPrimary
                    font.pixelSize: 12
                }

                Rectangle { width: 1; height: 18; color: "#33FFFFFF" }

                Text {
                    text: ChattyService.clients.values.length
                    color: root.textSecondary
                    font.pixelSize: 12
                }

                Text {
                    text: "⏮"
                    color: root.textPrimary
                    font.pixelSize: 15
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.previous()
                    }
                }

                Text {
                    text: Mpris.playing ? "⏸" : "▶"
                    color: root.textPrimary
                    font.pixelSize: 15
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.togglePlayPause()
                    }
                }

                Text {
                    text: "⏭"
                    color: root.textPrimary
                    font.pixelSize: 15
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Mpris.next()
                    }
                }
            }
        }
    }
}
