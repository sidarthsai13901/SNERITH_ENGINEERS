import QtQuick 2.15

Item {
    id: batteryRoot
    anchors.fill: parent

    property real batteryLevel: 100  // 0 to 100

    property color fillColor: {
        if (batteryLevel < 31)      return "#ff0000"
        else if (batteryLevel < 61) return "#ff8c00"
        else                        return "#00cc00"
    }

    Item {
        id: batteryBody

        width:  parent.width  * 0.80
        height: parent.height * 0.88

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter:   parent.verticalCenter

        // Nub on top
        Rectangle {
            id: nub
            width:  batteryBody.width * 0.35
            height: batteryBody.height * 0.045
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: bodyBorder.top
            color: "#ffffff"
            radius: 3
        }

        // Outer border
        Rectangle {
            id: bodyBorder
            anchors.fill: parent
            color: "transparent"
            border.color: "#ffffff"
            border.width: 3
            radius: 8
            clip: true

            // Fill level
            Rectangle {
                id: fillRect
                anchors.left:    parent.left
                anchors.right:   parent.right
                anchors.bottom:  parent.bottom
                anchors.margins: 5

                height: (parent.height - 10) * (batteryRoot.batteryLevel / 100)
                color:  batteryRoot.fillColor
                radius: 5

                Behavior on height { NumberAnimation { duration: 80 } }
                Behavior on color  { ColorAnimation  { duration: 200 } }
            }

            // Percentage text — centered inside body, rotated -90 to counter panel rotation
            Text {
                id: percentText
                anchors.centerIn: parent
                //rotation: -90          // cancel out the panel's 90° rotation so text reads normally
                text: Math.round(batteryRoot.batteryLevel) + "%"
                color: "#ffffff"
                font.pixelSize: bodyBorder.width * 0.3   // width here = visual height (rotated)
                font.bold: true
                z: 2
            }
        }

        // Drag handler
        MouseArea {
            id: dragArea
            anchors.fill: parent

            property real startY:     0
            property real startLevel: 0

            onPressed: (mouse) => {
                startY     = mouse.y
                startLevel = batteryRoot.batteryLevel
            }
            onPositionChanged: (mouse) => {
                var delta      = startY - mouse.y
                var bodyH      = bodyBorder.height - 10
                var deltaLevel = (delta / bodyH) * 100
                batteryRoot.batteryLevel = Math.max(0, Math.min(100, startLevel + deltaLevel))
            }
        }
    }
}