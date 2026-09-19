import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import Quickshell.Services.Mpris


Rectangle{

    anchors.fill: parent
    color: "transparent"


    PlaceholderButton{
        color: "#7d3dfc"
        width: hoverArea.containsMouse ? 300 : 200 
        height: parent.height - 20
        radius: 30
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: timedateContainer.left 
        anchors.rightMargin: -50

        Behavior on width {
            NumberAnimation {
                duration: 500 
                easing.type: Easing.OutCubic
            }
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            id: hoverArea
        }

        property var spotify: Mpris.players.values.find(p => p.identity === "Spotify")

        PlaceholderText {
            //text: spotify ? spotify.trackTitle + " - " + spotify.trackArtist : "Nothing playing"
            text: `${Mpris.players.values[0].trackArtist} 󰝚  ${Mpris.players.values[0].trackTitle}`.slice(0, 30) 
            color: "white"
            width: parent.width - 30
        }

    }


    PlaceholderButton{
        id: timedateContainer
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
