import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: bar
    anchors { top: true; left: true; right: true }
    implicitHeight: 100
    color: "transparent"

    BlurSource {
        id: bg
        screen: bar.screen
        wallpaper: "file:/home/devich/.config/hypr/wallpapers/malenia-ER.jpg"
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        BlurButton {
            blurTexture: bg.texture
            screen: bar.screen
            windowOrigin: Qt.point(0, 0)     // bar sits at the screen's top-left
            implicitWidth: bar.width; implicitHeight: 60
            onClicked: console.log("hi")

            Text { anchors.centerIn: parent; text: "Apps"; color: "white" }
        }
    }
}
