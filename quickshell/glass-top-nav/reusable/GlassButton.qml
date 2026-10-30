import QtQuick
import qs.config 
// Reusable glass button backed by glass.frag.qsb.
//
// Required from the parent:
//   wallpaper    - a screen-sized, blurred texture provider (see shell.qml)
//   windowOrigin - top-left of the PanelWindow in screen px
//   screenSize   - screen size in px
BaseButton {
    id: root

    // ---- public API -------------------------------------------------
    property string text: ""
    property string icon: ""            // optional glyph (e.g. Nerd Font)
    property string fontFamily: ""      // empty = default font
    property int fontSize: 13
    property color textColor: "white"

    property Item wallpaper: null
    property point windowOrigin: Qt.point(0, 0)
    property size screenSize: Qt.size(1920, 1080)

    property real cornerRadius: height / 2   // pill by default
    property color tintColor: "#ffffff"
    property real tintStrength: 0.12         // idle
    property real hoverStrength: 0.20
    property real pressStrength: 0.30
    property int padding: 16

    // ---- sizing -----------------------------------------------------
    implicitWidth: content.implicitHeight + padding * 2
    implicitHeight: 36

    // ---- screen-position tracking ----------------------------------
    // The shader samples the wallpaper at this item's *screen* position,
    // so we need to know where we are. Call updateOrigin() manually if an
    // ancestor moves without this item's own x/y changing.
    readonly property point _origin: {
        let px = windowOrigin.x
        let py = windowOrigin.y
        for (let it = root; it && it.parent; it = it.parent) {
            px += it.x
            py += it.y
        }
        return Qt.point(px, py)
    }
    
    // ---- hover / press animation -----------------------------------
    property real _strength: pressed ? pressStrength
    : hovered ? hoverStrength
    : tintStrength
    Behavior on _strength { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }

    // ---- visuals ----------------------------------------------------
    ShaderEffect {
        id: shader
        anchors.fill: parent

        visible: root.wallpaper !== null

        // names must match the uniforms in glass.frag
        property variant source: root.wallpaper
        property size size: Qt.size(width, height)
        property point origin: root._origin
        property size screenSize: root.screenSize
        property real radius: Math.min(root.cornerRadius, Math.min(width, height) / 2)
        // vector4d (not color) so Qt doesn't premultiply the alpha/strength
        property vector4d tint: Qt.vector4d(root.tintColor.r,
                                            root.tintColor.g,
                                            root.tintColor.b,
                                            root._strength)

        fragmentShader: Config.glassShader
    }

    Row {
        id: content
        anchors.centerIn: parent
        spacing: 6

        Text {
            visible: root.icon !== ""
            text: root.icon
            color: root.textColor
            font.pixelSize: root.fontSize + 2
            font.family: root.fontFamily
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            visible: root.text !== ""
            text: root.text
            color: root.textColor
            font.pixelSize: root.fontSize
            font.family: root.fontFamily
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
