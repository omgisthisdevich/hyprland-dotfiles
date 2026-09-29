import QtQuick
import Quickshell.Widgets
import Quickshell.Io

Rectangle {
    id: btn
    width: 50
    height: 30
    color: hoverArea.containsMouse ? "#333333" : "#444444"
    radius: 10 

    required property real value
    property var icons: ["0", "20", "40", "60", "80"] 
    property var rightClick: ["kitty", "-e"] 
    property var leftClick: ["kitty", "-e"] 

    PlaceholderText{
        id: iconValue
        text: iconForValue() 
    }

    function iconForValue() {
        var iconNum = icons.length

        for (let i = iconNum  -1 ; i >= 0 ;  i--) {
            if (value >= 100/iconNum * i) {
                // console.log(value, '|', 100/iconNum * i)
                return icons[i]
            }
        }
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        id: hoverArea
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: (mouse) => {
            if (mouse.button === Qt.RightButton) {
                console.log("right clicked")
                buttonClicked.command = rightClick
            } else if (mouse.button === Qt.LeftButton) {
                buttonClicked.command = leftClick
                console.log("left clicked")
            }
            if (!buttonClicked.running)
                buttonClicked.running = true
        }
        Process {
            running: false
            id: buttonClicked
        }

    }
}
