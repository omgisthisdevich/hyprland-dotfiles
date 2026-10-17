import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root
    anchors { top: true; left: true }
    margins { top: 100; left: 100 }
    implicitWidth: 200
    implicitHeight: 80
    color: "transparent"                  // window itself must be transparent
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.namespace: "glass"      // used by the compositor blur rule

    Rectangle {
        id: button
        anchors.centerIn: parent
        width: 360
        height: 156
        radius: 16

        // translucent white fill, brighter on hover
        color: mouse.pressed ? Qt.rgba(1, 1, 1, 0.08)
             : mouse.containsMouse ? Qt.rgba(1, 1, 1, 0.22)
             : Qt.rgba(1, 1, 1, 0.12)
        Behavior on color { ColorAnimation { duration: 150 } }

        // thin light edge sells the "glass"
        border.width: 1
        border.color: Qt.rgba(1, 1, 1, 0.3)

        Text {
            anchors.centerIn: parent
            text: "Glass"
            color: "white"
            font.pixelSize: 16
        }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: console.log("clicked")
        }
    }
}
