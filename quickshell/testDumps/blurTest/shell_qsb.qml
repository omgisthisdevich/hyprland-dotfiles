import Quickshell
import QtQuick
import QtQuick.Effects

PanelWindow {
    id: win
    anchors.top: true
    margins.top: 40
    implicitWidth: 400
    implicitHeight: 120
    exclusiveZone: 0
    color: "transparent"

    // Full-screen wallpaper, hidden; only used as a blur source
    Image {
        id: wall
        visible: false
        width: win.screen.width
        height: win.screen.height
        source: "file:/home/devich/.config/hypr/wallpapers/malenia-ER.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    MultiEffect {
        id: blurred
        source: wall
        width: wall.width
        height: wall.height
        blurEnabled: true
        blur: 1.0
        blurMax: 64
    }

    ShaderEffectSource {
        id: blurTex
        sourceItem: blurred
        hideSource: true
    }

    ShaderEffect {
        anchors.fill: parent

        property variant source: blurTex
        property vector2d size: Qt.vector2d(width, height)
        // panel is top-anchored, so layer-shell centers it horizontally
        property vector2d origin: Qt.vector2d((win.screen.width - win.width) / 2, win.margins.top)
        property vector2d screenSize: Qt.vector2d(win.screen.width, win.screen.height)
        property real radius: 28
        property color tint: Qt.rgba(1, 1, 1, 0.12)

        fragmentShader: Qt.resolvedUrl("glass.frag.qsb")
    }
}
