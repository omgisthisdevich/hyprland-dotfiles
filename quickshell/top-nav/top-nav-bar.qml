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
