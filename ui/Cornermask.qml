import QtQuick
import QtQuick.Shapes

// Canonical top-left corner mask. Rotate this 0/90/180/270 to getawedsa
// top-left / top-right / bottom-right / bottom-left respectively.
Shape {
    id: root

    property int size: 16
    property color maskColor: "black"

    width: size
    height: size
    preferredRendererType: Shape.CurveRenderer

    ShapePath {
        fillColor: root.maskColor
        strokeWidth: -1

        startX: 0
        startY: 0

        PathLine { x: root.size; y: 0 }

        PathArc {
            x: 0
            y: root.size
            radiusX: root.size
            radiusY: root.size
            direction: PathArc.Counterclockwise
        }

        PathLine { x: 0; y: 0 }
    }
}
