import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent

    // ── Static image source ─────────────────────────────────────
    property string iconSource: "qrc:/icons/EB_temp_high.png"

    // ── Visibility state — starts hidden, toggled by click ────────
    property bool iconVisible: false

    // ── Future hook: bind this to a real transducer value ────────
    property real currentValue: 0
    property real threshold:    100

    readonly property bool overThreshold: currentValue > threshold

    Image {
        id: icon
        anchors.fill: parent
        anchors.margins: parent.width * 0.035
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.iconSource

        // hidden until toggled on; opacity also drives the blink once visible
        opacity: root.iconVisible ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
    }

    // ── Click toggles the icon's visibility ───────────────────────
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.iconVisible = !root.iconVisible
        }
    }

    // ── Blink animation — only runs when visible AND overThreshold ──
    SequentialAnimation {
        id: blinkAnim
        running: root.iconVisible && root.overThreshold
        loops: Animation.Infinite

        NumberAnimation {
            target: icon
            property: "opacity"
            to: 0.2
            duration: 300
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: icon
            property: "opacity"
            to: 1.0
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    // ensure icon snaps back to its correct state if blinking stops mid-fade
    onOverThresholdChanged: {
        if (!overThreshold && icon) {
            blinkAnim.stop()
            icon.opacity = root.iconVisible ? 1.0 : 0.0
        }
    }
}