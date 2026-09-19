import QtQuick
import QtQuick.Layouts



Rectangle{
    color: "transparent"
    anchors.fill: parent
    anchors.rightMargin: 20

    RowLayout{
        anchors.right: parent.right 
        anchors.verticalCenter: parent.verticalCenter


        Rectangle{
            implicitWidth: innerRow.implicitWidth
            implicitHeight: innerRow.implicitHeight
            color: "transparent"

            RowLayout{
                id: innerRow
                anchors.fill: parent

                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: ``
                        font.pixelSize: 20
                    }

                }

                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: ""
                        font.pixelSize: 20
                    }

                }
                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: ""
                        font.pixelSize: 20
                    }

                }
                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: "󰂯"
                        font.pixelSize: 20
                    }

                }
                PlaceholderButton{
                    radius: 20
                    width: 40

                    PlaceholderText{
                        text: "󰤨"
                        font.pixelSize: 20
                    }

                }
            }
        }

    }
}
