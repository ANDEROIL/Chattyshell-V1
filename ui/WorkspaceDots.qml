
import QtQuick
import Quickshell.Hyprland

Row {
    id: root

    property int shown: 5
    spacing: 8

    Repeater {
        model: root.shown

        Rectangle {
            required property int index

            readonly property int ws: index + 1
            readonly property bool active: Hyprland.focusedWorkspace?.id === ws

            width: active ? 18 : 8
            height: 8
            radius: 4

            color: active ? "#E7D7FF" : "#55FFFFFF"

            Behavior on width {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    Hyprland.dispatch(`workspace ${parent.ws}`)
                }
            }
        }
    }
}
