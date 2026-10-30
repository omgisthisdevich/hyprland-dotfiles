import QtQuick
import QtQuick.Effects
import Quickshell

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            required property var modelData
            screen: modelData

            anchors { top: true; left: true; right: true }
            margins { top: 8; left: 8; right: 8 }
            implicitHeight: 44
            color: "transparent"

            // Where this window's top-left sits on the screen (matches the margins).
            readonly property point screenOrigin: Qt.point(margins.left, margins.top)
            readonly property size screenDims: Qt.size(screen.width, screen.height)

            // ---- shared blurred wallpaper (one copy, used by every button) ----
            Image {
                id: wall
                visible: false
                width: bar.screenDims.width
                height: bar.screenDims.height
                fillMode: Image.PreserveAspectCrop
                source: "file:/home/devich/.config/hypr/wallpapers/malenia-ER-i.jpg"
            }

            MultiEffect {
                id: blurred
                visible: false
                source: wall
                width: wall.width
                height: wall.height
                blurEnabled: true
                blurMax: 64
                blur: 0.3
                autoPaddingEnabled: false
            }

            ShaderEffectSource {
                id: wallpaperTex
                visible: false
                sourceItem: blurred
                width: wall.width
                height: wall.height
                live: true   // set false + scheduleUpdate() once the image loads to save GPU
            }

            // ---- the content ---
            LeftPanel {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            MiddlePanel{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

            }
            // GlassButton {
            //     anchors.right: parent.right
            //     anchors.rightMargin: 8
            //     anchors.verticalCenter: parent.verticalCenter

            //     text: "Power"
            //     tintColor: "#ff5566"
            //     tintStrength: 0.25
            //     wallpaper: wallpaperTex
            //     windowOrigin: bar.screenOrigin
            //     screenSize: bar.screenDims

            // }
            RightPanel{
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

            }
        }
    }
}
