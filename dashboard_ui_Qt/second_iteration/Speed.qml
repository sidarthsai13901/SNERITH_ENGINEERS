import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: speedo
    property real speedValue: 0
    property real maxSpeed:   10
    property real rpmValue: speedValue * 6
    property color speedColor: {
        let speed = Math.round(speedValue)
        if (speed < 5)      return "#00cc00"
        else if (speed < 7) return "#ffff00"
        else                return "#ff3333"
    }

    property real _dragStartX:     0
    property real _dragStartSpeed: 0

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        border.width: 3
        border.color:"#ffffff"
        radius: speedo.width * 0.04
    }

    Row {
        id: topRow
        anchors.top:         parent.top
        anchors.left:        parent.left
        anchors.right:       parent.right
        anchors.topMargin:   speedo.height * 0.08
        anchors.leftMargin:  speedo.width  * 0.05
        anchors.rightMargin: speedo.width  * 0.05
        spacing:             speedo.width  * 0.04

        Rectangle {
            width:  (parent.width - parent.spacing) * 0.5
            height: speedo.height * 0.5
            color:  "transparent"
            border.color: "#ffffff"
            border.width: 2.5
            radius: height * 0.2

            Text {
                anchors.centerIn: parent
                text: Math.round(speedo.speedValue) + " km/h"
                font.pixelSize: speedo.height * 0.18
                font.bold: true
                color: speedo.speedColor
            }
        }

        Rectangle {
            width:  (parent.width - parent.spacing) * 0.5
            height: speedo.height * 0.5
            color:  "transparent"
            border.color: "#ffffff"
            border.width: 2.5
            radius: height * 0.2

            Text {
                anchors.centerIn: parent
                text: "RPM: " + Math.round(speedo.rpmValue)
                font.pixelSize: speedo.height * 0.18
                font.bold: true
                color: speedo.speedColor
            }
        }
    }

    Rectangle {
        id: barBackground
        anchors.top:         topRow.bottom
        anchors.left:        parent.left
        anchors.right:       parent.right
        anchors.topMargin:   speedo.height * 0.10
        anchors.leftMargin:  speedo.width  * 0.05
        anchors.rightMargin: speedo.width  * 0.05
        height: speedo.height * 0.12+10
        radius: height / 2
        color:  "#2a2a2a"
        border.color: "#ffffff"
        border.width: 3

        Rectangle {
            id: barFill
            width:  parent.width * (speedo.speedValue / speedo.maxSpeed)-6
            height: parent.height-6
            anchors.top:parent.top

            anchors.left: parent.left
            anchors.topMargin:   3
            anchors.leftMargin:  3

            radius: parent.radius+5
            color:  speedo.speedColor
            Behavior on width {
                SmoothedAnimation { velocity: 300 }
            }
        }

        MouseArea {
            anchors.fill: parent
            onPressed: (mouse) => {
                speedo._dragStartX     = mouse.x
                speedo._dragStartSpeed = speedo.speedValue
                var ratio = Math.max(0, Math.min(1, mouse.x / barBackground.width))
                speedo.speedValue = ratio * speedo.maxSpeed
            }
            onPositionChanged: (mouse) => {
                var ratio = Math.max(0, Math.min(1, mouse.x / barBackground.width))
                speedo.speedValue = ratio * speedo.maxSpeed
            }
        }
    }
}