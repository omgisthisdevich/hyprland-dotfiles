import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import "placeholderComponents" as Ph

Ph.PlaceholderButton{
    radius: 20
    width: 40
    id: btn

    property var deviceList: bluetoothDevices.text.split('\n')

    buttonClick: () => { 
        popupLoader.active = !popupLoader.active
    }
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


    SharedPanel{
        id: popupLoader
        panelColor: btn.color

        content: Component {
            Column {
                Repeater {
                    model: deviceList

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
}
