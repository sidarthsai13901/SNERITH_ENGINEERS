import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent

    // ── Base icon — always visible, solenoid coil ───────────────────
    readonly property string baseIcon: "qrc:/icons/solenoid_coil.png"

    // ── Number overlay icons — badges 1 through 6 ────────────────────
    readonly property var numberOverlays: [
        "qrc:/icons/sc_1.png",
        "qrc:/icons/sc_2.png",
        "qrc:/icons/sc_3.png",
        "qrc:/icons/sc_4.png",
        "qrc:/icons/sc_5.png",
        "qrc:/icons/sc_6.png"
    ]

    // ── Letter overlay icons — A and B ────────────────────────────────
    readonly property string letterA: "qrc:/icons/sc_a.png"
    readonly property string letterB: "qrc:/icons/sc_b.png"

    // 0 = no overlay (base only), 1-6 = which numbered state is showing
    property int currentState: 0

    // separate topIsA trackers for each independent crossfade layer
    property bool numTopIsA: true
    property bool letTopIsA: true

    // odd states (1,3,5) -> letter A | even states (2,4,6) -> letter B
    readonly property string currentLetter: (currentState % 2 === 1) ? root.letterA : root.letterB

    // ── Base icon — always present, never fades ─────────────────────
    Image {
        id: baseImage
        anchors.fill: parent
        anchors.margins: parent.width * 0.035
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.baseIcon
    }

    // ── NUMBER badge crossfade — two stacked slots ───────────────────
    Image {
        id: numOverlayA
        anchors.fill: parent
        anchors.margins: parent.width * 0.08
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.currentState > 0 ? root.numberOverlays[root.currentState - 1] : ""
        opacity: (root.numTopIsA && root.currentState > 0) ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
        }
    }

    Image {
        id: numOverlayB
        anchors.fill: parent
        anchors.margins: parent.width * 0.08
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: ""
        opacity: (!root.numTopIsA && root.currentState > 0) ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
        }
    }

    // ── LETTER badge crossfade — two stacked slots, independent layer ─
    Image {
        id: letOverlayA
        anchors.fill: parent
        anchors.margins: parent.width * 0.08
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.currentState > 0 ? root.currentLetter : ""
        opacity: (root.letTopIsA && root.currentState > 0) ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
        }
    }

    Image {
        id: letOverlayB
        anchors.fill: parent
        anchors.margins: parent.width * 0.08
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: ""
        opacity: (!root.letTopIsA && root.currentState > 0) ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 400; easing.type: Easing.InOutQuad }
        }
    }

    // ── Swap logic — drives both independent crossfade layers ────────
    function swapTo(newState) {
        root.currentState = newState

        if (newState === 0) {
            // returning to base-only: both layers fade out via their
            // opacity bindings, no new source needs loading
            return
        }

        // number layer crossfade
        var nextNumSource = root.numberOverlays[newState - 1]
        if (root.numTopIsA) {
            numOverlayB.source = nextNumSource
            root.numTopIsA = false
        } else {
            numOverlayA.source = nextNumSource
            root.numTopIsA = true
        }

        // letter layer crossfade — computed AFTER currentState is set,
        // so currentLetter already reflects the new state
        var nextLetSource = root.currentLetter
        if (root.letTopIsA) {
            letOverlayB.source = nextLetSource
            root.letTopIsA = false
        } else {
            letOverlayA.source = nextLetSource
            root.letTopIsA = true
        }
    }

    // ── Tap to cycle: 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 0 -> ... ─────
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