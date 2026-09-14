import QtQuick
import Quickshell.Io
import QtQuick.Layouts


Rectangle{

    anchors.fill: parent
    color: "transparent"
    
    PlaceholderButton{
        width: 300
        height: parent.height - 20 
        radius: 30 

        anchors.centerIn: parent

        PlaceholderText{
            text: timeCollector.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 0.0
                color: "#ac82ff"
            }
            GradientStop{
                position: 1.0
                color: "#9fbbfc"
            }
        }
    }


    Process {
        id: timedateProcess
        command: ["sh", "-c", "date | awk '{print $1, $2, $3; print $4, $5, $6}'"]
        stdout: StdioCollector {
            id: timeCollector 
        }
    }

    Timer{
        running:true
        repeat: true

        onTriggered: {
           timedateProcess.running= true 
       }
   }
}
