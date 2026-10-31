import QtQuick
import Quickshell
import Quickshell.Io

import qs.config as Config

Text {
    id: root

    property var values: []

    readonly property int rows: 5

    color: "white"
    font.pixelSize: 8
    font.family: "monospace"     // equal widths so the columns line up
    lineHeight: 0.5

    // line 0 is the top row (needs 5 dots), the last line is the bottom row (needs 1)
    text: {
        let lines = []
        for (let r = 0; r < rows; r++) {
            const needed = rows - r
            lines.push(values.map(v => Math.ceil(v / 20) >= needed ? "" : " ").join(" "))
        }
        return lines.join("\n")
    }

    Process {
        running: true
        command: ["cava", "-p", "/home/devich/dotfiles/quickshell/glass-top-nav/cava/cava.conf"]
        stdout: SplitParser {
            onRead: data => root.values = data.split(";").filter(s => s !== "").map(Number)
        }
    }
}
