import QtQuick
import Quickshell
import Quickshell.Io
import qs.config
import qs.rightPanel as RP

Row {
    id: root
    spacing: 6

    // ---- mic toggle ---------------------------------------------------
    GlassNavButton {
        id: micButton
        property bool muted: muteCollector.text.trim() === "1"

        icon: muted ? ` ` : ``   // paste your glyphs

        tooltip: "Muted: " + muted
        textColor: Config.textColor
        onClicked: micToggle.running = true
    }

    // ---- volume ---------------------------------------------------------
    RP.ThresholdButton {
        value: root.volume
        tooltip: "Volume: " + Math.round(root.volume) + "%"
        icons: [" ", " ", " ", " "]            // paste your glyphs
        rightClick: ["pwvucontrol"]
    }

    // ---- wifi + bluetooth in one glass pill ------------------------------
    GlassNavButton {
        width: group.implicitWidth

        Row {
            id: group
            height: parent.height

            RP.Wifi {}
            RP.Bluetooth {}
        }
    }

    // ---- mic + volume state ----------------------------------------------
    property real volume: 0

    Process {
        id: micToggle
        command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "toggle"]
        onExited: muteQuery.running = true
    }

    Process {
        id: muteQuery
        command: ["sh", "-c",
            "wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo 1 || echo 0"]
        stdout: StdioCollector { id: muteCollector }
    }

    Process {
        id: audioQuery
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        stdout: StdioCollector {
            onStreamFinished: {
                const m = text.match(/([0-9.]+)/)
                root.volume = m ? parseFloat(m[1]) * 100 : 0
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            muteQuery.running = true
            audioQuery.running = true
        }
    }
}
