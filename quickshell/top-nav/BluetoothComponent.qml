import QtQuick
import Quickshell
import Quickshell.Io


PlaceholderButton{
    radius: 20
    width: 40
    id: btn

    //var deviceList: []
    buttonClick: () => { 
        popupWindow.visible = !popupWindow.visible
    }
    PlaceholderText{
        text: "󰂯"                    
    }
    Process{
        id: bluetoothQuery
        running: true
        command: ["sh", "-c", "bluetoothctl devices Connected"]
        stdout: StdioCollector{
            id: bluetoothDevices
        }
    }

    PanelWindow {
        visible: false
        id: popupWindow
        implicitWidth: 500
        implicitHeight: 550

        anchors { top: true; right: true }
        margins { top: 70; right: 10 }   // top = your bar's height, so it sits below the bar
        exclusionMode: ExclusionMode.Ignore   // do
    }

}

