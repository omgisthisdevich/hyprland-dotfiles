import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland


Rectangle{
    anchors.fill: parent
    color: "transparent"

    RowLayout{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter


        Repeater{
            model: Hyprland.workspaces

            PlaceholderButton{
                radius: 20
                Layout.preferredWidth: modelData.focused ? 60 : 40

                required property var modelData
                color: modelData.focused ?  "#ac82ff" : "black"

                PlaceholderText{
                    text: `${modelData.id}`
                    color: modelData.focused ? "black" : "white"
                }

                Behavior on Layout.preferredWidth{
                    NumberAnimation {
                        duration: 200 
                        easing.type: Easing.OutCubic
                    }
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Hyprland.dispatch("workspace " + modelData.id)
                }


            }

        }

    }


}


