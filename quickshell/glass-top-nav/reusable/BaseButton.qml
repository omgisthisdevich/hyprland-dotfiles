import QtQuick
import Quickshell
import qs.config

Item {
    id: base

    property string tooltip: ""

    readonly property bool hovered: mouse.containsMouse
    readonly property bool pressed: mouse.pressed

    signal clicked()
    signal rightClicked()

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (ev) => ev.button === Qt.RightButton ? base.rightClicked() : base.clicked()
    }

    PopupWindow {
        visible: base.hovered && base.tooltip !== ""
        color: "transparent"

        anchor.item: base
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
        anchor.margins.top: 6

        implicitWidth: tipText.implicitWidth + 24
        implicitHeight: tipText.implicitHeight + 12

        Rectangle {
            anchors.fill: parent
            radius: 10
            color: "white"

            Text {
                id: tipText
                anchors.centerIn: parent
                text: base.tooltip
                color: Config.textColor
                font.pixelSize: Config.fontSize
            }
        }
    }
}
