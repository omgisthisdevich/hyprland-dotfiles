import QtQuick
import Quickshell

import qs.config
import "./reusable" as Rs

Rs.GlassButton {
    id: btn 

    readonly property var bar: QsWindow.window

    Component.onCompleted: console.log("tex:", wallpaper, "screen:", screenSize, "origin:", windowOrigin)

    wallpaper: bar && bar.wallpaperSource ? bar.wallpaperSource : fallbackImage
    windowOrigin: bar ? bar.screenOrigin : Qt.point(0, 0)
    screenSize: bar ? bar.screenDims : Qt.size(0, 0)

    height: 44 
    width:44

    Image {
        id: fallbackImage
        visible: false                 // texture source only, don't draw it
        source: Config.wallpaperDirectory + "malenia-ER-i.jpg"// put the path in your config
        width: btn.screenSize.width
        height: btn.screenSize.height
        fillMode: Image.PreserveAspectCrop
    }
}
