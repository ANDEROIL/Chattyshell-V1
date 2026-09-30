import QtQuick
import Quickshell
import Quickshell.Wayland

import "ui"
import "services"

ShellRoot {

    // ─────────────────────────────────────────────
    // CHATY SHELL
    // Top island + reveal trigger
    // ─────────────────────────────────────────────

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            required property ShellScreen modelData
            screen: modelData

            color: "transparent"

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.exclusionMode: ExclusionMode.Ignore

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 92

            // Only the island and the tiny reveal strip
            // receive mouse interaction.
            mask: Region {
                Region {
                    item: revealArea
                }

                Region {
                    item: island
                }
            }

            Item {
                anchors.fill: parent
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                readonly property bool hasWindows:
                    ChattyService.hasWindows

                readonly property bool shouldHide:
                    hasWindows &&
                    !revealArea.containsMouse &&
                    !island.hovered &&
                    !island.expanded

                // ─────────────────────────────
                // TOP REVEAL ZONE
                // ─────────────────────────────

                MouseArea {
                    id: revealArea

                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                    }

                    height: 6
                    hoverEnabled: true
                }

                // ─────────────────────────────
                // DYNAMIC ISLAND
                // ─────────────────────────────

                Island {
                    id: island

                    anchors.horizontalCenter: parent.horizontalCenter

                    y: parent.shouldHide
                        ? -height + 6
                        : 10

                    Behavior on y {
                        NumberAnimation {
                            duration: 240
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }
    }


    // ─────────────────────────────────────────────
    // SCREEN CORNERS
    // ─────────────────────────────────────────────

    Variants {
        model: Quickshell.screens

        ScreenCorners {
            modelData: modelData

            cornerSize: 16
            maskColor: "black"
        }
    }
}
