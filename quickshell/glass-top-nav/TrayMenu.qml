import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import qs.config

Scope {
    id: root
    property bool shown: false

    IpcHandler {
        target: "tray"
        function toggle(): void { root.shown = !root.shown }
    }

    LazyLoader {
        active: root.shown

        PanelWindow {
            id: win
            anchors { top: true; bottom: true; left: true; right: true }
            exclusionMode: ExclusionMode.Ignore
            color: "transparent"

            WlrLayershell.namespace: "qs-tray"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

            // full-screen dim: gives Hyprland pixels to blur, click closes
            Rectangle {
                anchors.fill: parent
                color: "#55000000"

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.shown = false
                }
            }

            // the actual 80% panel
            Rectangle {
                width: parent.width * 0.8
                height: parent.height * 0.8
                anchors.centerIn: parent
                radius: 24
                color: "#e61b1530"

                // swallow clicks so they don't reach the backdrop
                MouseArea { anchors.fill: parent }

                // put your tray content here
            }

            FocusScope {
                anchors.fill: parent
                focus: true
                Keys.onEscapePressed: root.shown = false
            }
        }
    }
}
