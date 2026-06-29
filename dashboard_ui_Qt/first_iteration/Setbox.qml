import QtQuick 2.15

Item {
    id: root

    property int upperValue: 0
    property int lowerValue: 0

    readonly property int upperMax: 900
    readonly property int lowerMax: 450

    property bool upperLocked: false

    property bool upperEditing: false
    property bool lowerEditing: false

    // ── Outer border ──────────────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        color:        "transparent"
        border.color: "#ffffff"
        border.width: 3
        radius:       8
    }

    // ── Layout ────────────────────────────────────────────────────
    readonly property real pad:   root.width * 0.035
    readonly property real gap:   root.width * 0.010

    readonly property real innerW: root.width  - pad * 2
    readonly property real innerH: root.height - pad * 2

    readonly property real col0W: innerW * 0.42
    readonly property real col1W: innerW * 0.29
    readonly property real col2W: innerW * 0.29

    readonly property real rowH:  (innerH - gap) * 0.50

    readonly property real x0: pad
    readonly property real x1: x0 + col0W + gap
    readonly property real x2: x1 + col1W + gap
    readonly property real y0: pad
    readonly property real y1: y0 + rowH  + gap

    // ── UPPER DISPLAY ─────────────────────────────────────────────
    Rectangle {
        x: root.x0;       y: root.y0
        width: root.col0W; height: root.rowH
        color: "#0f3460"
        border.color: "#ffffff"
        border.width: 1; radius: 6; clip: true

        Text {
            anchors.centerIn: parent
            text:  root.upperValue
            color: root.upperEditing ? "#ffffff" : "#666666"
            font.pixelSize: parent.height * 0.50
            font.bold: true; font.family: "Arial"
        }
    }

    // ── LOWER DISPLAY ─────────────────────────────────────────────
    Rectangle {
        x: root.x0;       y: root.y1
        width: root.col0W; height: root.rowH
        color: "#0f3460"
        border.color: "#ffffff"
        border.width: 1; radius: 6; clip: true

        Text {
            anchors.centerIn: parent
            text:  root.lowerValue
            color: root.lowerEditing ? "#ffffff" : "#666666"
            font.pixelSize: parent.height * 0.50
            font.bold: true; font.family: "Arial"
        }
    }

    // ── SET BUTTON — upper row ─────────────────────────────────────
    Rectangle {
        x: root.x1;       y: root.y0
        width: root.col1W; height: root.rowH
        color: root.upperEditing ? "#00e676" : "#0f3460"
        border.color: "#ffffff"
        border.width: 1; radius: 6; clip: true
        visible: !root.upperLocked

        Text {
            anchors.centerIn: parent
            text: "SET"
            color: "#ffffff"
            font.pixelSize: parent.height * 0.38
            font.bold: true; font.family: "Arial"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.upperEditing) {
                    root.upperEditing = false
                    root.upperLocked  = true
                }
            }
        }
    }

    // ── SET BUTTON — lower row ─────────────────────────────────────
    Rectangle {
        x: root.x1;       y: root.y1
        width: root.col1W; height: root.rowH
        color: root.lowerEditing ? "#00e676" : "#0f3460"
        border.color: "#ffffff"
        border.width: 1; radius: 6; clip: true
        visible: root.upperLocked

        Text {
            anchors.centerIn: parent
            text: "SET"
            color: "#ffffff"
            font.pixelSize: parent.height * 0.38
            font.bold: true; font.family: "Arial"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (root.lowerEditing) {
                    root.lowerEditing = false
                    root.upperLocked  = false
                }
            }
        }
    }

    // ── LOCK BUTTON — upper row slot ────────────────────────────────
    Rectangle {
        x: root.x1;       y: root.y0
        width: root.col1W; height: root.rowH
        color: "#0f3460"
        border.color: "#ffffff"
        border.width: 1; radius: 6; clip: true
        visible: root.upperLocked

        readonly property bool locksDisabled: root.upperEditing || root.lowerEditing

        Item {
            anchors.centerIn: parent
            width:  parent.height * 0.42
            height: parent.height * 0.42

            Rectangle {
                width:  parent.width * 0.62
                height: parent.width * 0.62
                radius: width / 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: bodyA.top
                anchors.bottomMargin: -height * 0.45
                color: "transparent"
                border.color: "#ff3333"
                border.width: Math.max(1.5, parent.width * 0.10)
            }

            Rectangle {
                id: bodyA
                width:  parent.width
                height: parent.height * 0.62
                anchors.bottom: parent.bottom
                radius: parent.width * 0.12
                color: "#ff3333"
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: !parent.locksDisabled
            onClicked: {
                root.upperLocked = false
            }
        }
    }

    // ── LOCK BUTTON — lower row slot ─────────────────────────────────
    Rectangle {
        x: root.x1;       y: root.y1
        width: root.col1W; height: root.rowH
        color: "#0f3460"
        border.color: "#ffffff"
        border.width: 1; radius: 6; clip: true
        visible: !root.upperLocked

        readonly property bool locksDisabled: root.upperEditing || root.lowerEditing

        Item {
            anchors.centerIn: parent
            width:  parent.height * 0.42
            height: parent.height * 0.42

            Rectangle {
                width:  parent.width * 0.62
                height: parent.width * 0.62
                radius: width / 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: bodyB.top
                anchors.bottomMargin: -height * 0.45
                color: "transparent"
                border.color: "#ff3333"
                border.width: Math.max(1.5, parent.width * 0.10)
            }

            Rectangle {
                id: bodyB
                width:  parent.width
                height: parent.height * 0.62
                anchors.bottom: parent.bottom
                radius: parent.width * 0.12
                color: "#ff3333"
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: !parent.locksDisabled
            onClicked: {
                root.upperLocked = true
            }
        }
    }

    // ── UP ARROW ──────────────────────────────────────────────────
    Rectangle {
        x: root.x2;       y: root.y0
        width: root.col2W; height: root.rowH
        color: "#ffffff"
        border.color: "#000000"
        border.width: 1; radius: 6; clip: true

        Text {
            anchors.centerIn: parent
            text: "▲"; color: "#000000"
            font.pixelSize: parent.height * 0.50
        }

        property real holdElapsed: 0

        Timer {
            id: upRepeatTimer
            interval: 150
            repeat: true
            onTriggered: {
                parent.holdElapsed += interval
                upArrowMouse.doIncrement()
            }
        }

        Timer {
            id: upHoldDelay
            interval: 400
            repeat: false
            onTriggered: {
                parent.holdElapsed = 400
                upRepeatTimer.start()
            }
        }

        MouseArea {
            id: upArrowMouse
            anchors.fill: parent

            function doIncrement() {
                var step
                if (parent.holdElapsed >= 5000)
                    step = 10
                else if (parent.holdElapsed >= 3000)
                    step = 5
                else
                    step = 1

                if (!root.upperLocked) {
                    root.upperValue   = Math.min(root.upperMax, root.upperValue + step)
                    root.upperEditing = true
                } else {
                    root.lowerValue   = Math.min(root.lowerMax, root.lowerValue + step)
                    root.lowerEditing = true
                }
            }

            onPressed: {
                parent.holdElapsed = 0
                doIncrement()
                upHoldDelay.restart()
            }

            onReleased: {
                upHoldDelay.stop()
                upRepeatTimer.stop()
                parent.holdElapsed = 0
            }

            onCanceled: {
                upHoldDelay.stop()
                upRepeatTimer.stop()
                parent.holdElapsed = 0
            }
        }
    }

    // ── DOWN ARROW ────────────────────────────────────────────────
    Rectangle {
        x: root.x2;       y: root.y1
        width: root.col2W; height: root.rowH
        color: "#ffffff"
        border.color: "#000000"
        border.width: 1; radius: 6; clip: true

        Text {
            anchors.centerIn: parent
            text: "▼"; color: "#000000"
            font.pixelSize: parent.height * 0.50
        }

        property real holdElapsed: 0

        Timer {
            id: downRepeatTimer
            interval: 150
            repeat: true
            onTriggered: {
                parent.holdElapsed += interval
                downArrowMouse.doDecrement()
            }
        }

        Timer {
            id: downHoldDelay
            interval: 400
            repeat: false
            onTriggered: {
                parent.holdElapsed = 400
                downRepeatTimer.start()
            }
        }

        MouseArea {
            id: downArrowMouse
            anchors.fill: parent

            function doDecrement() {
                var step
                if (parent.holdElapsed >= 5000)
                    step = 10
                else if (parent.holdElapsed >= 3000)
                    step = 5
                else
                    step = 1

                if (!root.upperLocked) {
                    root.upperValue   = Math.max(0, root.upperValue - step)
                    root.upperEditing = true
                } else {
                    root.lowerValue   = Math.max(0, root.lowerValue - step)
                    root.lowerEditing = true
                }
            }

            onPressed: {
                parent.holdElapsed = 0
                doDecrement()
                downHoldDelay.restart()
            }

            onReleased: {
                downHoldDelay.stop()
                downRepeatTimer.stop()
                parent.holdElapsed = 0
            }

            onCanceled: {
                downHoldDelay.stop()
                downRepeatTimer.stop()
                parent.holdElapsed = 0
            }
        }
    }
}