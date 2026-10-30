import QtQuick
import Quickshell
import qs.config
import ".."          // folder containing GlassNavButton.qml, see notes

GlassNavButton {
    id: btn

    required property real value
    property var icons: ["0", "20", "40", "60", "80"]
    property var rightClick: []
    property var leftClick: []

    function iconForValue() {
        const n = icons.length
        for (let i = n - 1; i >= 0; i--) {
            if (value >= 100 / n * i)
                return icons[i]
        }
        return icons[0] ?? ""
    }

    icon: iconForValue()
    textColor: Config.textColor

    onClicked: if (leftClick.length > 0) Quickshell.execDetached(leftClick)
    onRightClicked: if (rightClick.length > 0) Quickshell.execDetached(rightClick)
}
