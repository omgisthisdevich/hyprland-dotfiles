import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import "placeholderComponents" as Ph

Ph.PlaceholderButton{
    radius: 20
    width: 40
    id: btn

    required property var panel
    property var deviceList: bluetoothDevices.text.split('\n')

    buttonClick: () => panel.togglePanel(btn, devicePanel, btn.color)

    Ph.PlaceholderText{
        text: deviceList.length > 0 ? "" : "󰂯"                    
    }
    Process{
        id: bluetoothQuery
        running: true
        command: ["sh", "-c", "bluetoothctl devices Connected | cut -d' ' -f2-"]
        stdout: StdioCollector{
            id: bluetoothDevices
        }
    }


    Component {
        id: devicePanel

        Column {
            Repeater {
                model: btn.deviceList

                Rectangle {
                    width: parent.width
                    height: 24
                    color: "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: modelData.split(' ').slice(1).join(' ')
                        color: "#2f008c"
                    }
                }
            }
        }
    }
}
