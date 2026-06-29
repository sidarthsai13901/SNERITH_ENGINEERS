import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent

    // ── Mode indices ──────────────────────────────────────────────
    readonly property int blueMode: 0
    readonly property int redMode:  1

    // ── State indices within each mode ───────────────────────────
    readonly property int onIdx:  0
    readonly property int offIdx: 1

    // ── Image sets per mode ───────────────────────────────────────
    readonly property var modeImages: [
        ["qrc:/icons/ai_cam_on.png",   "qrc:/icons/ai_cam_off.png"  ],   // blue
        ["qrc:/icons/eye_ai_cam_on.png", "qrc:/icons/eye_ai_cam_off.png"]    // red
    ]

    // ── Independent memory for each mode ─────────────────────────
    property int blueState: offIdx
    property int redState:  offIdx

    // ── Active mode ───────────────────────────────────────────────
    property int  currentMode: blueMode
    property bool topIsA:      true
    property bool longPressFired: false

    // ── Helper: state of whichever mode is currently active ───────
    function currentState() {
        return currentMode === blueMode ? blueState : redState
    }

    // ── Helper: write state back into the correct mode slot ───────
    function setCurrentState(val) {
        if (currentMode === blueMode) blueState = val
        else                          redState  = val
    }

    // ── Crossfade to any image path ───────────────────────────────
    function crossfadeTo(imgPath) {
        if (root.topIsA) {
            imageB.source = imgPath
            root.topIsA = false
        } else {
            imageA.source = imgPath
            root.topIsA = true
        }
    }

    // ── Single tap: toggle on/off within current mode ─────────────
    function handleTap() {
        var next = (currentState() === onIdx) ? offIdx : onIdx
        setCurrentState(next)
        crossfadeTo(root.modeImages[root.currentMode][next])
    }

    // ── Long press: switch mode, restore that mode's saved state ──
    function handleLongPress() {
        root.currentMode = (root.currentMode === blueMode) ? redMode : blueMode
        crossfadeTo(root.modeImages[root.currentMode][currentState()])
    }

    // ── Image A ───────────────────────────────────────────────────
    Image {
        id: imageA
        anchors.fill: parent
        anchors.margins: parent.width * 0.035
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.modeImages[root.blueMode][root.offIdx]
        opacity: root.topIsA ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
        }
    }

    // ── Image B ───────────────────────────────────────────────────
    Image {
        id: imageB
        anchors.fill: parent
        anchors.margins: parent.width * 0.035
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.modeImages[root.blueMode][root.offIdx]
        opacity: root.topIsA ? 0 : 1
        Behavior on opacity {
            NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
        }
    }

    // ── Input handler ─────────────────────────────────────────────
    MouseArea {
        anchors.fill: parent
        onPressed: {
            root.longPressFired = false
            longPressTimer.start()
        }
        onReleased: {
            longPressTimer.stop()
            if (!root.longPressFired) {
                tapDelay.start()
            }
        }
        onCanceled: {
            longPressTimer.stop()
        }
    }

    // ── Long press timer ──────────────────────────────────────────
    Timer {
        id: longPressTimer
        interval: 1200        // change to 4000 for production
        repeat: false
        onTriggered: {
            root.longPressFired = true
            root.handleLongPress()
        }
    }

    // ── Short delay before tap crossfade fires ────────────────────
    Timer {
        id: tapDelay
        interval: 150
        repeat: false
        onTriggered: root.handleTap()
    }
}