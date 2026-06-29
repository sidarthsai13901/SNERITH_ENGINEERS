import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    anchors.fill: parent
    color: "transparent"

    property real batteryValue: 75

    Rectangle {
        id: outerBox

        anchors.fill: parent

        color: "transparent"

        border.color: "white"
        border.width: 4

        radius: 15

        Text {
            text: "Battery"

            color: "white"

            font.pixelSize: 18
            font.bold: true

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 15
        }

        Text {
            id: percentText

            text: Math.round(root.batteryValue) + "%"

            color: "white"

            font.pixelSize: 26
            font.bold: true

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 45
        }

        Rectangle {
            id: batteryBody

            width: 80
            height: 140

            radius: 8

            color: "transparent"

            border.color: "white"
            border.width: 4

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20

            Rectangle {
                width: 30
                height: 10

                radius: 3

                color: "white"

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
            }

            Rectangle {
                id: batteryFill

                width: parent.width - 10

                height:
                    (root.batteryValue / 100)
                    * (parent.height - 10)

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5

                anchors.horizontalCenter: parent.horizontalCenter

                radius: 4

                color:
                    root.batteryValue > 45 ? "#00ff00" :
                    root.batteryValue > 10 ? "yellow" :
                    "red"

                Behavior on height {
                    NumberAnimation {
                        duration: 150
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 150
                    }
                }
            }

            MouseArea {
                anchors.fill: parent

                onPressed: updateBattery(mouseY)

                onPositionChanged: {
                    if (pressed)
                        updateBattery(mouseY)
                }

                function updateBattery(yPos)
                {
                    var percent =
                            ((batteryBody.height - yPos)
                             / batteryBody.height) * 100

                    root.batteryValue =
                            Math.max(
                                0,
                                Math.min(100, percent))
                }
            }
        }

        Popup {
            id: lowBatteryPopup

            width: 220
            height: 120

            modal: true

            anchors.centerIn: parent

            background: Rectangle {
                color: "#2b2b2b"

                border.color: "white"
                border.width: 2

                radius: 10
            }

            Column {
                anchors.centerIn: parent

                spacing: 10

                Text {
                    text: "Low Battery"

                    color: "red"

                    font.bold: true
                }

                Button {
                    text: "OK"

                    onClicked:
                        lowBatteryPopup.close()
                }
            }
        }
    }

    onBatteryValueChanged: {
        if (batteryValue < 10 &&
                !lowBatteryPopup.visible)
        {
            lowBatteryPopup.open()
        }
    }
}