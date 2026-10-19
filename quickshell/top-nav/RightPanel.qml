import QtQuick
import QtQuick.Layouts
import Quickshell.Io

import "placeholderComponents" as Ph
import "convexedButton" as Cb

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
            id: root

            SharedPanel {
                id: sharedPanel
                panelColor: root.panelColor
                content: root.panelContent
            }

            property Component panelContent: null
            property color panelColor: "white"
            property Item panelOwner: null

            function togglePanel(owner, content, color) {
                // clicking the same owner again closes the panel
                if (sharedPanel.active && panelOwner === owner) {
                    closePanel()
                    return
                }
                // otherwise (re)open with the new owner's content
                panelOwner = owner
                panelColor = color
                panelContent = content
                sharedPanel.active = true
            }
            function closePanel() {
                sharedPanel.active = false
                panelOwner = null
            }

            RowLayout{
                id: innerRow
                anchors.fill: parent

                property var itemColor: "#ad9dfa"

                Cb.ConvexedButton{
                    width: 40
                    color: innerRow.itemColor
                    Ph.PlaceholderText{
                        text: ""
                    }
                }
                BluetoothComponent {
                    color: innerRow.itemColor
                    width: 40
                    panel: root
                    id: bt2
                }

                BluetoothComponent {
                    color: innerRow.itemColor
                    width: 40
                    panel: root
                    id: bt
                }
                Ph.PlaceholderButton{
                    radius: 20
                    color: innerRow.itemColor
                    width: 40

                    Ph.PlaceholderText{
                        text: muteStateCollector.text == 1 ? ` ` : ``

                    }
                    Component.onCompleted: addClickHandler(() => {
                        micToggle.running = true
                    }) 
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
                    color: innerRow.itemColor

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
                    color: innerRow.itemColor

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
