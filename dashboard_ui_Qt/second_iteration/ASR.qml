import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent

    readonly property int onIdx:  0
    readonly property int offIdx: 1

    readonly property var images: [
        "qrc:/icons/asr_on1.png",
        "qrc:/icons/asr_off.png"
    ]

    property int currentIndex: onIdx   // defaults to ON state
    property bool topIsA: true

    // ── Toggle logic ────────────────────────────────────────────
    function nextIndex() {
        return (currentIndex === onIdx) ? offIdx : onIdx
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
        source: root.images[root.onIdx]   // starts as ON
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
        source: root.images[root.onIdx]
        opacity: root.topIsA ? 0 : 1

        Behavior on opacity {
            NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
        }
    }

    // ── Simple tap toggle ──────────────────────────────────────
    MouseArea {
        anchors.fill: parent
        onClicked: {
            activationDelay.start()
        }
    }

    // ── Delay before the crossfade actually triggers ──────────────
    Timer {
        id: activationDelay
        interval: 150
        repeat: false
        onTriggered: {
            root.swapTo(root.nextIndex())
        }
    }
}