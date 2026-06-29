import QtQuick 2.15
Item {
    id: root
    anchors.fill: parent
    readonly property var images: [
        "qrc:/icons/low_beam_F.png",
        "qrc:/icons/high_beam_F.png",
        "qrc:/icons/headlight_off_F.png"
    ]
    readonly property int lowIndex:  0
    readonly property int highIndex: 1
    readonly property int offIndex:  2
    property int  currentIndex: lowIndex
    property bool topIsA: true
    property bool longPressFired: false
    Image {
        id: imageA
        anchors.fill: parent
        anchors.margins: parent.width * 0.035
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: root.images[root.lowIndex]
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
        source: root.images[root.lowIndex]
        opacity: root.topIsA ? 0 : 1
        Behavior on opacity {
            NumberAnimation { duration: 600; easing.type: Easing.InOutQuad }
        }
    }
    function crossfadeTo(nextIndex) {
        currentIndex = nextIndex
        if (root.topIsA) {
            imageB.source = root.images[nextIndex]
            root.topIsA = false
        } else {
            imageA.source = root.images[nextIndex]
            root.topIsA = true
        }
    }
    function handleTap() {
        if (currentIndex === offIndex) return
        crossfadeTo(currentIndex === lowIndex ? highIndex : lowIndex)
    }
    function handleLongPress() {
        crossfadeTo(currentIndex === offIndex ? lowIndex : offIndex)
    }
    MouseArea {
        anchors.fill: parent
        onPressed: {
            root.longPressFired = false
            longPressTimer.start()
        }
        onReleased: {
            longPressTimer.stop()
            if (!root.longPressFired) {
                activationDelay.start()
            }
        }
        onCanceled: {
            longPressTimer.stop()
        }
    }
    Timer {
        id: longPressTimer
        interval: 400
        repeat: false
        onTriggered: {
            root.longPressFired = true
            root.handleLongPress()
        }
    }
    Timer {
        id: activationDelay
        interval: 300
        repeat: false
        onTriggered: root.handleTap()
    }
}