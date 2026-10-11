import QtQuick
import Quickshell
import Quickshell.Hyprland

LazyLoader {
    id: root
    active: false
    property Component content
    property var panelColor: "transparent"

    PanelWindow {
        id: popupWindow
        implicitWidth: 500
        implicitHeight: Math.max(contentLoader.implicitHeight, 1)
        color: "transparent"

        anchors { top: true; right: true }
        margins { top: 45 }   

        exclusionMode: ExclusionMode.Ignore 

        // close the popup when it is unfocused
        HyprlandFocusGrab {
            windows: [popupWindow]
            active: true
            onCleared: root.active = false
        }
        Rectangle{
            anchors.fill: parent
            radius: 20
            color: root.panelColor

            Loader {
                id: contentLoader
                anchors.fill: parent
                anchors.margins: 10
                sourceComponent: root.content
            }
        }
    }
}
