import Quickshell
import QtQuick
import QtQuick.Layouts


ShellRoot{
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
 
            anchors {
                top: true
                left: true
                right: true 
            }

            color: "transparent"

            implicitHeight: 60 

            RowLayout{
                anchors.fill: parent

                Rectangle{
                    color: "transparent"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    LeftPanel{}
                }
                Rectangle{
                    color: "transparent"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    MiddlePanel{}

                }

                Rectangle{
                    color: "transparent"
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    RightPanel{}
                }
            }
        }
    }
}

