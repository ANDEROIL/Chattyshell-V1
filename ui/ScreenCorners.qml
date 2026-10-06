import QtQuick
import Quickshell
import Quickshell.Wayland
//alldayidreamaboutsex,same
PanelWindow {
    id: root

    required property ShellScreen modelData
    screen: modelData

    property int cornerSize: 16
    property color maskColor: "black"

    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    // Empty region = the whole window is click-through, nothing here
    // ever intercepts mouse/keyboard input.
    mask: Region {}

    CornerMask {
        anchors.top: parent.top
        anchors.left: parent.left
        size: root.cornerSize
        maskColor: root.maskColor
        rotation: 0
        transformOrigin: Item.Center
    }

    CornerMask {
        anchors.top: parent.top
        anchors.right: parent.right
        size: root.cornerSize
        maskColor: root.maskColor
        rotation: 90
        transformOrigin: Item.Center
    }

    CornerMask {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        size: root.cornerSize
        maskColor: root.maskColor
        rotation: 180
        transformOrigin: Item.Center
    }

    CornerMask {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        size: root.cornerSize
        maskColor: root.maskColor
        rotation: 270
        transformOrigin: Item.Center
    }
}
