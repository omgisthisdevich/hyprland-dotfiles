import QtQuick
import Quickshell.Io
import Quickshell.Services.Mpris
import qs.config

Row {
    id: root
    spacing: 8

    // ---- media button ------------------------------------------------
    // Fixed-width slot, so growing the button on hover doesn't push the
    // time button around. The button is pinned to the right and grows left.
    Item {
        width: 300
        height: mediaButton.height

        GlassNavButton {
            id: mediaButton
//            anchors.rightMargin: -50


            // prefer Spotify, fall back to any player, or null if none
            readonly property var player:
                Mpris.players.values.find(p => p.identity === "Spotify")
                ?? Mpris.players.values[0]
                ?? null

            text: player
                ? `${player.trackArtist} 󰝚  ${player.trackTitle}`.slice(0, 20) + "..."
                : "Nothing playing"
            textColor: Config.textColor

            width: hovered ? 300 : 200
            anchors.right: parent.right

            Behavior on width {
                NumberAnimation { duration: 500; easing.type: Easing.OutCubic }
            }
        }
    }
    
    // ARCH icon
    GlassNavButton{
        id: archIcon

        text: "󰣇"
        width: 50

        textColor: Config.textColor
        fontSize: 30
    }

    // ---- time / date button -----------------------------------------
    GlassNavButton {
        id: timedateButton

        text: timeCollector.text.trim()
        textColor: Config.textColor

        width: 200
    }

    // ---- time/date logic --------------------------------------------
    Process {
        id: timedateProcess
        command: ["sh", "-c", "date | awk '{print $1, $2, $3; print $4, $5, $6}'"]
        stdout: StdioCollector { id: timeCollector }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: timedateProcess.running = true
    }

}
