import QtQuick

import "../placeholderComponents/"

PlaceholderButton {
    id: root

    property bool round: true
    property int cornerRadius: 15
    signal toggled(bool round)

    radius: cornerRadius
    bottomLeftRadius: round ? cornerRadius : 0
    bottomRightRadius: round ? cornerRadius : 0

    buttonClick: () => {
        round = !round
        toggled(round)
    }

    ConvexCorner {
        leftFlare: !root.round
        rightFlare: !root.round
    }
}
