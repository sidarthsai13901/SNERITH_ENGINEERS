import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent

    // ── Base icon — always visible, pump with exclamation mark ──────
    readonly property string baseIcon: "qrc:/icons/hyd_flow_war.png"

    // ── Overlay icons — numbered valve badges 1 through 6 ────────────
    readonly property var overlays: [
        "qrc:/icons/cp_1.png",
        "qrc:/icons/cp_2.png",
        "qrc:/icons/cp_3.png",
        "qrc:/icons/cp_4.png",
        "qrc:/icons/cp_5.png",
        "qrc:/icons/cp_6.png"
    ]

    // 0 = no overlay (base only), 1-6 = which valve overlay is showing
    property int currentState: 0
    property bool topIsA: true

    // ── Base icon — always present, never fades ────────────────────
    Image {
        id: baseImage
        anchors.fill: parent
        anchors.margins: parent.width * 0.035
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.baseIcon
    }

    // ── Overlay crossfade — two stacked slots, identical pattern ────
    // to the cyclic widget. Both start fully transparent since
    // currentState begins at 0 (no overlay).
    Image {
        id: overlayA
        anchors.fill: parent
        anchors.margins: parent.width * 0.08
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.currentState > 0 ? root.overlays[root.currentState - 1] : ""
        opacity: (root.topIsA && root.currentState > 0) ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
        }
    }

    Image {
        id: overlayB
        anchors.fill: parent
        anchors.margins: parent.width * 0.08
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: ""
        opacity: (!root.topIsA && root.currentState > 0) ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
        }
    }

    // ── Swap logic — identical crossfade pattern as the cyclic widget ─
    function swapTo(newState) {
        root.currentState = newState

        if (newState === 0) {
            // returning to base-only: fade out whichever overlay is visible
            // (no need to load a new source, opacity binding handles the fade)
            return
        }

        var nextSource = root.overlays[newState - 1]

        if (root.topIsA) {
            overlayB.source = nextSource
            root.topIsA = false
        } else {
            overlayA.source = nextSource
            root.topIsA = true
        }
    }

    // ── Tap to cycle: 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 0 -> ... ────
    MouseArea {
        anchors.fill: parent
        onClicked: {
            activationDelay.start()
        }
    }

    Timer {
        id: activationDelay
        interval: 150
        repeat: false
        onTriggered: {
            var next = (root.currentState + 1) % 7   // 0..6, then wraps to 0
            root.swapTo(next)
        }
    }
}