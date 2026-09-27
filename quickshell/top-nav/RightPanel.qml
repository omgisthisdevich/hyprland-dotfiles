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
                        text: ``

                    }

                }

                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: ""

                    }

                }
                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: ""

                    }

                }
                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: "󰂯"

                    }

                }
                ThresholdButton{
                    value: timeCollector.text.split(':')[2]
                    icons: ["󰤯 ", "󰤟 ", "󰤢 ", "󰤥 ", "󰤨 "]

                    leftClick: ["sh", "-c", "nmtui"]
                    rightClick: []

                    Process {
                        id: wifiQuery 
                        command: ["sh", "-c", "nmcli -t  -f IN-USE,SSID,SIGNAL,SECURITY,RATE dev wifi list | grep '^\*'"]
                        stdout: StdioCollector {
                            id: timeCollector 
                        }
                    }

                    Timer{
                        running:true
                        repeat: true

                        onTriggered: {
                            wifiQuery.running= true 
                        }
                    }

                }
            }
        }

    }
}
