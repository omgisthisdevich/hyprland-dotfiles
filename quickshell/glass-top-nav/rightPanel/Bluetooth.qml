import QtQuick
import Quickshell.Io

import qs.reusable

SegmentButton {
    id: seg

    property var devices: []

    icon: devices.length > 0 ? "󰂱" : "󰂯"
    tooltip: devices.length > 0 ? devices.join("\n") : "No devices"

    onHoveredChanged: if (hovered) query.running = true

    Process {
        id: query
        command: ["sh", "-c", "bluetoothctl devices Connected | cut -d' ' -f3-"]
        stdout: StdioCollector {
            onStreamFinished: seg.devices = text.split("\n").filter(l => l !== "")
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: query.running = true
    }
}
