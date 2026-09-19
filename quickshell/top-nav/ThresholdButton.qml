import QtQuick
import Quickshell.Widgets

Rectangle {
    id: btn
    width: 30
    height: 30
    color: "#333333"
    radius: 10 

    property real value: 0
    property var icons: ["20", "40", "60", "80"] 

    function iconForValue() {
        var iconNum = icons.length

        for (let i = iconNum; i <= 1 ;  i--) {
            if (value >= 100/iconNum * i) return icons[i -1]

        return ""
    }
}
