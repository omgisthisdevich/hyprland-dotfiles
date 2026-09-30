import QtQuick
import Quickshell
import Quickshell.Io


PlaceholderButton{
    radius: 20
    width: 40
    id: btn

    property var deviceList: bluetoothDevices.text.split('\n')

    buttonClick: () => { 
        popupLoader.active = !popupLoader.active
    }
    PlaceholderText{
        text: "󰂯"                    
    }
    Process{
        id: bluetoothQuery
        running: true
        command: ["sh", "-c", "bluetoothctl devices Connected | cut -d' ' -f3-"]
        stdout: StdioCollector{
            id: bluetoothDevices
        }
    }

    LazyLoader {
        id: popupLoader
        active: false

        PanelWindow {
            id: popupWindow
            implicitWidth: 300
            implicitHeight: column.implicitHeight

            anchors { top: true; right: true }
            margins { top: 70; right: 10 }   
            exclusionMode: ExclusionMode.Ignore 

            property int n: deviceList.length

            Column {
                id: column
                anchors.fill: parent
                spacing: 4

                Repeater {
                    model: popupWindow.n

                    Rectangle {
                        width: parent.width
                        height: 24
                        color: "#333333"

                        Text {
                            anchors.centerIn: parent
                            text: deviceList[index]
                            color: "white"
                        }
                    }
                }
            }
        }
    }

}

