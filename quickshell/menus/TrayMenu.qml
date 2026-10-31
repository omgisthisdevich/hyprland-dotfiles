import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: win

    implicitWidth: screen.width * 0.8
    implicitHeight: screen.height * 0.8
    exclusionMode: ExclusionMode.Ignore
    color: "#bbc6f2"

    WlrLayershell.namespace: "qs-tray"
    WlrLayershell.layer: WlrLayer.Top

    RowLayout {
        anchors.fill: parent
        uniformCellSizes: true      // forces all three columns to be exactly equal
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#bbc6f2"

            Image {
                
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
