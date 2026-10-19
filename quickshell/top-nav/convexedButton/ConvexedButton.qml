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

    function toggleCorners() {
        console.log(round)
        round = !round
        toggled(round)
    }
    function disableRoundCorners() {
        round = false
    }
    function enableRoundCorners() {
        round = true
    }

    // Component.onCompleted: addClickHandler(() => {
    //     toggleCorners()
    // })

    ConvexCorner {
        leftFlare: !root.round
        rightFlare: !root.round
    }
}
