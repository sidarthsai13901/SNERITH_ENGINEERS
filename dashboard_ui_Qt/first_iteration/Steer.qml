import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

Item {
    id: root
    anchors.fill: parent


    property real dialValue: 0

    function dialColor() {
        if (dialValue < 0) return "#ff3030"
        if (dialValue > 0) return "#00e676"
        return "#ffeb3b"
    }

    property color animatedDialColor: "#ffeb3b"

    ColorAnimation {
        id: colorAnim
        target: root
        property: "animatedDialColor"
        duration: 300
    }

    onDialValueChanged: {
        colorAnim.to = root.dialColor()
        colorAnim.restart()
    }

    // ── Background ────────────────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        radius: 7
        border.color: "#ffffff"
        border.width: 2
    }

    // ── Title ─────────────────────────────────────────────────────
    Text {
        id: titleText
        text: "STEERING ANGLE"
        color: "white"
        font.bold: true
        font.pixelSize: Math.max(10, root.height * 0.08)
        font.family: "Arial"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: root.height * 0.1
    }

    // ── Value readout ─────────────────────────────────────────────
    Text {
        id: valueText
        text: {
            if      (root.dialValue > 0) return "R  —  " + root.dialValue + "°"
            else if (root.dialValue < 0) return "L  —  " + Math.abs(root.dialValue) + "°"
            else                         return "0"
        }
        color: root.animatedDialColor
        font.bold: true
        font.pixelSize: Math.max(10, root.height * 0.08)
        font.family: "Arial"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.height * 0.04
    }

    // ── Dial area — strictly between title and value text ─────────
    Item {
        id: dialArea

        anchors.top: titleText.bottom
        anchors.bottom: valueText.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: root.height * 0.06
        anchors.bottomMargin: root.height * 0.06

        // r is capped so the semicircle always fits:
        //   horizontally: r <= cx  (half width)
        //   vertically:   r <= cy  (full available height, pivot at bottom)
        readonly property real cx: width  * 0.5
        readonly property real cy: height * 0.92
        readonly property real r:  Math.min(cx, cy) * 0.88

        // Background arc
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeColor: "#2a2a2a"
                strokeWidth: dialArea.r * 0.09
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap
                PathAngleArc {
                    centerX: dialArea.cx; centerY: dialArea.cy
                    radiusX: dialArea.r;  radiusY: dialArea.r
                    startAngle: 180; sweepAngle: 180
                }
            }
        }

        // Left zone tint (red)
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeColor: "#66ff3030"
                strokeWidth: dialArea.r * 0.09
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap
                PathAngleArc {
                    centerX: dialArea.cx; centerY: dialArea.cy
                    radiusX: dialArea.r;  radiusY: dialArea.r
                    startAngle: 180; sweepAngle: 90
                }
            }
        }

        // Right zone tint (green)
        Shape {
            anchors.fill: parent
            ShapePath {
                strokeColor: "#6600e676"
                strokeWidth: dialArea.r * 0.09
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap
                PathAngleArc {
                    centerX: dialArea.cx; centerY: dialArea.cy
                    radiusX: dialArea.r;  radiusY: dialArea.r
                    startAngle: 270; sweepAngle: 90
                }
            }
        }

        // Active arc
        Shape {
            anchors.fill: parent
            visible: root.dialValue !== 0
            ShapePath {
                strokeColor: root.animatedDialColor
                strokeWidth: dialArea.r * 0.09
                fillColor: "transparent"
                capStyle: ShapePath.RoundCap
                PathAngleArc {
                    centerX: dialArea.cx; centerY: dialArea.cy
                    radiusX: dialArea.r;  radiusY: dialArea.r
                    startAngle: 270
                    sweepAngle: root.dialValue
                }
            }
        }

        // Tick marks
        Repeater {
            model: 13
            delegate: Item {
                anchors.fill: parent
                property real tickDeg:  -90 + index * 15
                property real angleDeg: tickDeg - 90
                property real angleRad: angleDeg * Math.PI / 180
                property bool isMajor:  (index % 3 === 0)
                property real outerR:   dialArea.r - 2

                Rectangle {
                    width:  isMajor ? dialArea.r * 0.022 : dialArea.r * 0.014
                    height: isMajor ? dialArea.r * 0.13  : dialArea.r * 0.08
                    color:  isMajor ? "#eeeeee" : "#888888"
                    x: dialArea.cx + outerR * Math.cos(angleRad) - width  / 2
                    y: dialArea.cy + outerR * Math.sin(angleRad) - height / 2
                    rotation: angleDeg + 90
                    transformOrigin: Item.Center
                }

                Text {
                    visible: isMajor
                    text: tickDeg
                    color: tickDeg < 0 ? "#ff5555" : tickDeg > 0 ? "#33ee88" : "#cccccc"
                    font.pixelSize: Math.max(8, dialArea.r * 0.17)
                    font.bold: true
                    font.family: "Arial"
                    property real labelR: dialArea.r - dialArea.r * 0.22
                    x: dialArea.cx + labelR * Math.cos(angleRad) - width  / 2
                    y: dialArea.cy + labelR * Math.sin(angleRad) - height / 2
                }
            }
        }

        // Needle
        Rectangle {
            id: needle
            width:  dialArea.r * 0.028
            height: dialArea.r * 0.7
            radius: 2
            color: "white"
            x: dialArea.cx - width / 2
            y: dialArea.cy - height
            transformOrigin: Item.Bottom
            rotation: root.dialValue
            Behavior on rotation {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }
        }

        // Center pivot
        Rectangle {
            width:  dialArea.r * 0.13
            height: dialArea.r * 0.13
            radius: width * 0.5
            color: "white"
            x: dialArea.cx - width  / 2
            y: dialArea.cy - height / 2
            Rectangle {
                width:  parent.width  * 0.5
                height: parent.height * 0.5
                radius: width * 0.5
                color: "#0d0d0d"
                anchors.centerIn: parent
            }
        }

        // L label
                Text {
                    text: "L"
                    color: root.dialValue < 0 ? "#ff3030" : "#444444"
                    font.bold: true
                    font.pixelSize: Math.max(8, dialArea.r * 0.2)
                    // Pin both L and R to the same y so they're level
                    x: dialArea.cx - dialArea.r - dialArea.r * 0.18 - width / 2+5+13
                    y: dialArea.cy - height / 2+13
                    Behavior on color { ColorAnimation { duration: 150 } }
                }

                // R label
                Text {
                    text: "R"
                    color: root.dialValue > 0 ? "#00e676" : "#444444"
                    font.bold: true
                    font.pixelSize: Math.max(8, dialArea.r * 0.2)
                    // Same y formula as L — guaranteed level
                    x: dialArea.cx + dialArea.r + dialArea.r * 0.06+3-14
                    y: dialArea.cy - height / 2+13
                    Behavior on color { ColorAnimation { duration: 150 } }
                }

        // Drag handler
        MouseArea {
            anchors.fill: parent
            onPositionChanged: (mouse) => {
                var dx  = mouse.x - dialArea.cx
                var dy  = mouse.y - dialArea.cy
                var rad = Math.atan2(dx, -dy)
                var deg = rad * (180 / Math.PI)
                root.dialValue = Math.max(-90, Math.min(90, Math.round(deg)))
            }
        }
    }
}