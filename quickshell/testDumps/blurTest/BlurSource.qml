import QtQuick
import QtQuick.Effects
import Quickshell

Item {
    id: root
    required property var screen          // ShellScreen
    property url wallpaper
    property real blurAmount: 0.4

    // the thing buttons sample from
    readonly property alias texture: src

    width: screen.width
    height: screen.height
    visible: false                        // rendered only through ShaderEffectSource

    Image {
        id: img
        anchors.fill: parent
        source: root.wallpaper
        fillMode: Image.PreserveAspectCrop
        visible: false
    }
    MultiEffect {
        id: blurred
        anchors.fill: parent
        source: img
        blurEnabled: true
        blur: root.blurAmount
        blurMax: 64
        autoPaddingEnabled: false
        visible: false
    }
    ShaderEffectSource {
        id: src
        anchors.fill: parent
        sourceItem: blurred
        live: false                       // static wallpaper: render once
        hideSource: false
    }
}
