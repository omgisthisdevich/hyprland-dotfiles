import QtQuick

Rectangle {
    id: btn
    width: 30
    height: 30
    color: mouseArea.containsMouse ? "#555555" : "#333333"
    radius: 4

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: console.log("button clicked")
    }
}
