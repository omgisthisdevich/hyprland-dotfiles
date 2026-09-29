import QtQuick
import QtQuick.Layouts
import Quickshell.Io


Rectangle{
    color: "transparent"
    anchors.fill: parent
    anchors.rightMargin: 20

    RowLayout{
        anchors.right: parent.right 
        anchors.verticalCenter: parent.verticalCenter


        Rectangle{
            implicitWidth: innerRow.implicitWidth
            implicitHeight: innerRow.implicitHeight
            color: "transparent"

            RowLayout{
                id: innerRow
                anchors.fill: parent

                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: ""

                    }

                }

                BluetoothComponent{}

                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: muteStateCollector.text == 1 ? ` ` : ``

                    }
                    buttonClick: () => {
                        micToggle.running = true
                    }                    
                    Process{
                        id: micToggle
                        command: ["sh", "-c", `wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle`]
                        running: false
                    }
                    Process{
                        command: ["sh", "-c", `wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED" && echo 1 || echo 0`]
                        running: true
                        onRunningChanged: if (!running) running = true
                        stdout: StdioCollector{ id: muteStateCollector }
                    }

                }

                ThresholdButton{
                    value: audioCollector.text.split(':')[1]*100 // output presents in 0-1.0
                    icons: [" ", " ", " ", " "]

                    rightClick: ["sh", "-c", "pwvucontrol"] 
                    leftClick: []

                    Process {
                        id: audioOutQuery
                        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]
                        stdout: StdioCollector {
                            id: audioCollector 
                        }
                        running: true
                        onRunningChanged: if (!running) running = true
                    }

                }


                ThresholdButton{
                    value: timeCollector.text.split(':')[2]
                    icons: ["󰤯 ", "󰤟 ", "󰤢 ", "󰤥 ", "󰤨 "]

                    rightClick: ["kitty", "-e", "nmtui"] 
                    leftClick: []

                    Process {
                        id: wifiQuery 
                        command: ["sh", "-c", "nmcli -t  -f IN-USE,SSID,SIGNAL,SECURITY,RATE dev wifi list | grep '^\*'"]
                        stdout: StdioCollector {
                            id: timeCollector 
                        }
                        running: true
                        onRunningChanged: if (!running) running = true

                    }

                }
            }
        }

    }
}
