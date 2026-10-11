import QtQuick
import QtQuick.Shapes

Item {
    id: root
    anchors.fill: parent

    property int radius: 12
    property color color: parent.color
    property bool leftFlare: false 
    property bool rightFlare: false

    
    Shape {
        visible: root.rightFlare
        x: root.width
        y: root.height - root.radius
        width: root.radius
        height: root.radius
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: root.color
            strokeWidth: -1
            startX: 0; startY: 0
            PathArc {
                x: root.radius; y: root.radius
                radiusX: root.radius; radiusY: root.radius
                direction: PathArc.Counterclockwise
            }
            PathLine { x: 0; y: root.radius }
        }
    }

    Shape {
        visible: root.leftFlare
        x: -root.radius
        y: root.height - root.radius
        width: root.radius
        height: root.radius
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: root.color
            strokeWidth: -1
            startX: root.radius; startY: 0
            PathArc {
                x: 0; y: root.radius
                radiusX: root.radius; radiusY: root.radius
                direction: PathArc.Clockwise
            }
            PathLine { x: root.radius; y: root.radius }
        }
    }
}
