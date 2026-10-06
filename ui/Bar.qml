Rectangle {
    id: bar

    width: state.state === state.Expanded ? 620 : 280
    height: state.state === state.Compact ? 28 :
            state.state === state.Island ? 52 : 88

    radius: height / 2

    Behavior on width  { NumberAnimation { duration: 180 } }
    Behavior on height { NumberAnimation { duration: 180 } }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: state.expand()
        onExited: state.compact()
    }
}
