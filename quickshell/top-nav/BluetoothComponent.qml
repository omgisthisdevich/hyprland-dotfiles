import QtQuick
import Quickshell
import Quickshell.Io

import "convexedButton" as Cb
import "placeholderComponents" as Ph

Cb.ConvexedButton{
    id: btn

    required property var panel
    property var deviceList: bluetoothDevices.text.split('\n')

    Component.onCompleted: addClickHandler(() => {
        panel.togglePanel(btn, devicePanel, btn.color)
    })
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
