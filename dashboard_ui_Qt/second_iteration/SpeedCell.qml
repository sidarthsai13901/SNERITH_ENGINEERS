import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent

    // index constants for clarity
    readonly property int snailIdx:    0
    readonly property int tortoiseIdx: 1
    readonly property int rabbitIdx:   2

    readonly property var images: [
        "qrc:/icons/snail.png",
        "qrc:/icons/tortoise.png",
        "qrc:/icons/rabbit.png"
    ]

    property int currentIndex: snailIdx
    property bool topIsA: true

    // ── Transition table ────────────────────────────────────────
    // returns the next index given current index and whether it was a long press
    function nextIndex(longPress) {
        if (currentIndex === snailIdx)
            return longPress ? rabbitIdx : tortoiseIdx
        else if (currentIndex === tortoiseIdx)
            return longPress ? rabbitIdx : snailIdx
        else // rabbitIdx
            return longPress ? snailIdx : tortoiseIdx
    }

    // ── Crossfade swap logic ────────────────────────────────────
    function swapTo(newIndex) {
        root.currentIndex = newIndex

        if (root.topIsA) {
            imageB.source = root.images[newIndex]
            root.topIsA = false
        } else {
            imageA.source = root.images[newIndex]
            root.topIsA = true
        }
    }

    Image {
        id: imageA
        anchors.fill: parent
        anchors.margins: parent.width * 0.035
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.images[0]
        opacity: root.topIsA ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
        }
    }

    Image {
        id: imageB
        anchors.fill: parent
        anchors.margins: parent.width * 0.035
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.images[0]
        opacity: root.topIsA ? 0 : 1

        Behavior on opacity {
            NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
        }
    }

    // ── Press / long-press detection ─────────────────────────────
    MouseArea {
        id: cellMouse
        anchors.fill: parent

        property bool longPressTriggered: false

        onPressed: {
            longPressTriggered = false
            longPressTimer.start()
        }

        onReleased: {
            longPressTimer.stop()
            // only fire the tap action if long press hadn't already fired
            if (!longPressTriggered) {
                activationDelay.longPress = false
                activationDelay.start()
            }
        }

        onCanceled: {
            longPressTimer.stop()
        }

        Timer {
            id: longPressTimer
            interval: 500          // hold duration to count as "long press"
            repeat: false
            onTriggered: {
                cellMouse.longPressTriggered = true
                activationDelay.longPress = true
                activationDelay.start()
            }
        }
    }

    // ── Delay before the crossfade actually triggers ──────────────
    Timer {
        id: activationDelay
        property bool longPress: false
        interval: 150
        repeat: false
        onTriggered: {
            root.swapTo(root.nextIndex(longPress))
        }
    }
}