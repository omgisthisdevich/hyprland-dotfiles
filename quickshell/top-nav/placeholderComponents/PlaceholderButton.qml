import QtQuick

Rectangle {
    width: 30
    height: 30
    color: mouseArea.containsMouse ? "#555555" : "#333333"

    property var buttonClick: {}

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            buttonClick() 
        }
    }
}
