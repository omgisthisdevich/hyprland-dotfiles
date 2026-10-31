import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Widgets

import qs.reusable as Rs
import qs.config as Config

RowLayout {
    id: root
    spacing: 0
    uniformCellSizes: true

    readonly property var player:
        Mpris.players.values.find(p => p.identity === "Spotify")
        ?? Mpris.players.values[0]
        ?? null

    readonly property color ink: "#2b2b3a"      // dark text for the pastel background

    // Mpris doesn't update `position` by itself, so poke it while playing
    FrameAnimation {
        running: root.player?.isPlaying ?? false
        onTriggered: root.player.positionChanged()
    }

    // ---- column 1: cover ----------------------------------------------
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        ClippingRectangle {
            anchors.centerIn: parent
            width: Math.min(parent.width, parent.height) * 0.7
            height: width
            radius: width / 2
            color: "transparent"

            Image {
                anchors.fill: parent
                source: root.player ? root.player.trackArtUrl : ""
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
            }
        }
    }

    // ---- column 2: info + controls ------------------------------------
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true

        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width - 32
            spacing: 6

            Rs.BaseText {
                Layout.fillWidth: true
                text: root.player ? root.player.trackTitle : "Nothing playing"
                color: root.ink
                font.pixelSize: 18
                font.bold: true
                elide: Text.ElideRight
            }

            Rs.BaseText {
                Layout.fillWidth: true
                text: root.player ? root.player.trackArtist : ""
                color: root.ink
                opacity: 0.7
                font.pixelSize: 14
                elide: Text.ElideRight
            }
            // ---- prev / play-pause / next ----
            Row {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 8
                spacing: 8

                component Ctl: Rs.BaseButton {
                    property string glyph: ""
                    implicitWidth: 40
                    implicitHeight: 40
                    opacity: hovered ? 1 : 0.75

                    Rs.BaseText {
                        anchors.centerIn: parent
                        text: parent.glyph
                        color: root.ink
                        font.pixelSize: 22
                    }                }

                    Ctl {
                    glyph: "󰒮"
                    onClicked: root.player?.previous()
                }
                Ctl {
                    glyph: root.player?.isPlaying ? "󰏤" : "󰐊"
                    onClicked: root.player?.togglePlaying()
                }
                Ctl {
                    glyph: "󰒭"
                    onClicked: root.player?.next()
                }
            }

            // ---- progress bar ----
            Item {
                id: bar
                Layout.fillWidth: true
                Layout.topMargin: 8
                implicitHeight: 12

                readonly property real ratio:
                    root.player && root.player.length > 0
                        ? Math.min(1, root.player.position / root.player.length)
                        : 0

                Rectangle {              // track
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width
                    height: 4
                    radius: 2
                    color: root.ink
                    opacity: 0.2
                }
                Rectangle {              // fill
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * bar.ratio
                    height: 4
                    radius: 2
                    color: root.ink
                }

                MouseArea {              // click to seek
                    anchors.fill: parent
                    enabled: root.player?.canSeek ?? false
                    cursorShape: Qt.PointingHandCursor
                    onClicked: (ev) => root.player.position = ev.x / width * root.player.length
                }
            }
        }
    }

    // ---- column 3 -------------------------------------------------------
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true

        AnimatedImage {
            anchors.centerIn: parent
            width: parent.width 
            source: Qt.resolvedUrl("rev-NR.gif")
            fillMode: Image.PreserveAspectFit
            playing: root.player?.isPlaying ?? false
        }
    }
}
