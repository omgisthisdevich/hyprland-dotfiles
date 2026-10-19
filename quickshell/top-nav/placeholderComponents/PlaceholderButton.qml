import QtQuick

Rectangle {
    width: 30
    height: 30
    color: mouseArea.containsMouse ? "#fcbfa4" : "#95abfc"
    id: root

    property var clickHandlers: []
    function addClickHandler(fn) { clickHandlers = [...clickHandlers, fn] }

    function runClickHandlers() {
        for (const fn of clickHandlers) {
            try {
                fn()
            } catch (e) {
                console.warn("click handler failed:", e)
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
           root.runClickHandlers() 
        }
    }
}
