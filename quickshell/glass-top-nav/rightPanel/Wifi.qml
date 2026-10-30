import QtQuick
import Quickshell
import Quickshell.Io
import qs                    // SegmentButton lives in the root
import qs.config

SegmentButton {
    id: seg

    property real signal: 0
    property var icons: ["󰤯 ", "󰤟 ", "󰤢 ", "󰤥 ", "󰤨 "]

    icon: icons[Math.min(icons.length - 1, Math.floor(signal / 100 * icons.length))]

    onRightClicked: Quickshell.execDetached(["kitty", "-e", "nmtui"])

    tooltip: signal > 0 ? "Wi-Fi: " + signal + "%" : "Wi-Fi off"

    Process {
        id: query
        command: ["sh", "-c",
            "nmcli -t -f ACTIVE,SIGNAL dev wifi list --rescan no | grep '^yes' | cut -d: -f2"]
        stdout: StdioCollector {
            onStreamFinished: seg.signal = parseFloat(text) || 0
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: query.running = true
    }
}
