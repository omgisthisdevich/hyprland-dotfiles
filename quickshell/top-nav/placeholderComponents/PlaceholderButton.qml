import QtQuick

Rectangle {
    width: 30
    height: 30
    color: mouseArea.containsMouse ? "#fcbfa4" : "#95abfc"

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
