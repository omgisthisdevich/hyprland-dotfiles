import QtQuick
import Quickshell.Widgets

Rectangle {
    id: btn
    width: 30
    height: 30
    color: "#333333"
    radius: 10 

    property real value: 55
    property var icons: ["0", "25", "50", "75", "100"] 

    PlaceholderText{
        id: iconValue
        text: iconForValue() 
    }

    function iconForValue() {
        var iconNum = icons.length

        for (let i = iconNum  -1 ; i >= 0 ;  i--) {
            if (value >= 100/iconNum * i) {
                console.log(`${i}`) 
                return icons[i]
            }
        }
    }
}
