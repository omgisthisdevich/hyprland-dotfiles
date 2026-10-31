import QtQuick
import Quickshell

import qs.config
import "./reusable" as Rs

Rs.GlassButton {
    id: btn 

    readonly property var bar: QsWindow.window

    Component.onCompleted: console.log("tex:", wallpaper, "screen:", screenSize, "origin:", windowOrigin)

    wallpaper: bar ? bar.wallpaperSource : null
    windowOrigin: bar ? bar.screenOrigin : Qt.point(0, 0)
    screenSize: bar ? bar.screenDims : Qt.size(0, 0)

    height: 44 
    width:44

    tintColor: "#0f0d85"

}
