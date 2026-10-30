import QtQuick
import Quickshell.Hyprland
import qs.config

Row {
    id: root
    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        GlassNavButton {
            id: ws
            required property var modelData

            text: `${modelData.id}`
            textColor: Config.textColor
            padding: 8                      // see note below

            width: modelData.focused ? 60 : 44   

            Behavior on width {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }

            onClicked: Hyprland.dispatch("workspace " + modelData.id)
        }
    }
}
