import QtQuick
import qs.config
import qs.reusable as Rs

Rs.BaseButton {
    id: seg

    property string text: ""
    property string icon: ""
    property int fontSize: Config.fontSize
    property color textColor: Config.textColor
    property int padding: 12

    implicitWidth: label.implicitWidth + padding * 2
    height: parent ? parent.height : 36

    Rectangle {
        anchors.fill: parent
        anchors.margins: 3
        radius: height / 2
        color: "white"
        opacity: seg.pressed ? 0.25 : seg.hovered ? 0.12 : 0
        Behavior on opacity { NumberAnimation { duration: 120 } }
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: (seg.icon + " " + seg.text).trim()
        color: seg.textColor
        font.pixelSize: seg.fontSize
    }
}
