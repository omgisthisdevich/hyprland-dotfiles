import QtQuick
import QtQuick.Shapes

Item {
    id: root

    property real value: 0                 // 0.0 to 1.0
    property int thickness: 6
    property color trackColor: "#33ffffff"
    property color progressColor: "#ad9dfa"
    property bool animated: true

    implicitWidth: 48
    implicitHeight: 48

    readonly property real _r: (Math.min(width, height) - thickness) / 2
    readonly property real _v: Math.max(0, Math.min(1, value))

    Behavior on value {
        enabled: root.animated
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 4

        ShapePath {                        // background ring
            strokeColor: root.trackColor
            strokeWidth: root.thickness
            fillColor: "transparent"
            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root._r
                radiusY: root._r
                startAngle: 0
                sweepAngle: 360
            }
        }

        ShapePath {                        // progress arc
            strokeColor: root.progressColor
            strokeWidth: root.thickness
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap
            PathAngleArc {
                centerX: root.width / 2
                centerY: root.height / 2
                radiusX: root._r
                radiusY: root._r
                startAngle: -90            // start at 12 o'clock
                sweepAngle: root._v * 359.99
            }
        }
    }
}
