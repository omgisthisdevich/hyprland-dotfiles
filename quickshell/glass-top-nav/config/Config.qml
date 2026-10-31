pragma Singleton

import QtQuick
import Quickshell

Singleton {
    /* Glass top-nav attribs */
    readonly property string home: Quickshell.env("HOME")
    readonly property string configHome: "/home/devich/dotfiles/quickshell/glass-top-nav/config"

    readonly property string wallpaperDirectory: home + "//.config/hypr//wallpapers//"
    readonly property url glassShader: Qt.resolvedUrl("../glsl/glass.frag.qsb")

    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 13
    readonly property color textColor: "Black"

    readonly property real tintStrength: 0.12
    readonly property real hoverTintStrength: 20
    readonly property int padding: 10
    readonly property color tintColor: "#ffffff"

    /* TAB - media */
    readonly property url mediaGif: Qt.resolvedUrl("../mainMenu/rev-NR.gif")

    /* Tray menu */
    readonly property url trayMenuURL: Qt.resolvedUrl(`${home}/.config/quickshell/menus/trayMenu.qml`)

}
