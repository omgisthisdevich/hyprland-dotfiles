import Quickshell
import QtQuick


Rectangle {
    id: btn
    height: parent.height
    //width: 100

    color: mouseArea.containsMouse ? "#555555" : "#333333"

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: console.log("button clicked")
    }
} 
