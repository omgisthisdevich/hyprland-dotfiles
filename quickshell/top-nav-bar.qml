import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    anchors {
        top: true
        left: true
        right: true 
    }

    color: "transparent"

    implicitHeight: 70 

    RowLayout{
        anchors.fill: parent

        Rectangle{
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true

            LeftPanel{}


            // Workspace{
            //     color: "#123456"
            //     width: 50
            // }
            // Workspace{
            //     color: "#123457"
            //     width: 50
            // } 
            // Workspace{
            //     width: 100
            // }
        }
        Rectangle{
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true

            MiddlePanel{}

        }

        Rectangle{
            color: "red"
            Layout.fillWidth: true
            Layout.fillHeight: true
            
            RightPanel{}
        }



    }

}
