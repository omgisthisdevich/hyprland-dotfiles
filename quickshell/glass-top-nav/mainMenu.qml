import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import qs.config
import qs.reusable as Rs
import qs.mainMenu as MM

PanelWindow {
    id: win

    property int current: 0
    readonly property var tabs: ["Media", "Performance", "Notifications"]

    anchors.top: true
    margins.top: 60
    implicitWidth: screen.width * 0.3
    implicitHeight: screen.height * 0.4
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    HyprlandFocusGrab {
        windows: [win]
        active: true
        onCleared: Qt.quit()
    }    
    Rectangle {
        anchors.fill: parent
        radius: 20

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            // ---- tabs ----
            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 4

                Repeater {
                    model: win.tabs

                    Rs.BaseButton {
                        id: tab
                        required property string modelData
                        required property int index
                        readonly property bool selected: win.current === index

                        implicitWidth: label.implicitWidth + 24
                        implicitHeight: 32

                        onClicked: win.current = index

                        Rectangle {
                            anchors.fill: parent
                            radius: height / 2
                            color: "white"
                            opacity: tab.selected ? 0.18
                                   : tab.hovered ? 0.08
                                   : 0
                            Behavior on opacity { NumberAnimation { duration: 120 } }
                        }

                        Text {
                            id: label
                            anchors.centerIn: parent
                            text: tab.modelData
                            color: Config.textColor
                            font.pixelSize: Config.fontSize
                            opacity: tab.selected ? 1 : 0.6
                        }
                    }
                }
            }

            // ---- divider ----
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: "black"
            }

            // ---- content ----
            StackLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: win.current

                
                MM.Media{}
                
                Item { Text { anchors.centerIn: parent; text: "Performance"; color: Config.textColor } }
                Item { 
                    Text { anchors.centerIn: parent; text: "Notifications"; color: Config.textColor } 
                }
            }
        }
    }
}
