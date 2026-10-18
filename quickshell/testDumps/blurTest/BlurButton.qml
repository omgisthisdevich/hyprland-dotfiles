import QtQuick
import Quickshell

ShaderEffect {
    id: root

    // --- inputs ---
    required property Item blurTexture      // BlurSource.texture
    required property var screen            // ShellScreen
    // Window's top-left in screen px. Default (0,0) fits a full-width top bar.
    property point windowOrigin: Qt.point(0, 0)
    property real cornerRadius: 16
    property color tintColor: "white"
    property real tintStrength: 0.08

    signal clicked()
    property alias hovered: mouse.containsMouse

    // --- uniforms (names/types must match the shader block) ---
    property vector2d size: Qt.vector2d(width, height)
    property vector2d screenSize: Qt.vector2d(screen.width, screen.height)
    property vector2d origin: {
        // re-evaluate when position changes
        const _ = x + y + width + height;
        const p = root.mapToItem(null, 0, 0);
        return Qt.vector2d(windowOrigin.x + p.x, windowOrigin.y + p.y);
    }
    property real radius: cornerRadius
    property vector4d tint: Qt.vector4d(tintColor.r, tintColor.g, tintColor.b, tintStrength)
    property variant source: blurTexture

    fragmentShader: Qt.resolvedUrl("glass.frag.qsb")
    blending: true

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }

    default property alias content: contentItem.data
    Item { id: contentItem; anchors.fill: parent }
}
