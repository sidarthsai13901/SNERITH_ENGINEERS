import QtQuick 2.15

Item {
    id: root
    anchors.fill: parent
    anchors.margins: parent.width * 0.05


    // ── Refresh every second ──────────────────────────────────────
    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            timeLabel.text = Qt.formatDateTime(new Date(), "hh:mm:ss")
            dateLabel.text = Qt.formatDateTime(new Date(), "dd MMM yyyy")
        }
    }

    // ── Time ──────────────────────────────────────────────────────
    Text {
        id: timeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.20
        text: Qt.formatDateTime(new Date(), "hh:mm:ss")
        color: "#ffffff"
        font.pixelSize: parent.height * 0.1
        font.bold: true
    }

    // ── Date ──────────────────────────────────────────────────────
    Text {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.58
        text: Qt.formatDateTime(new Date(), "dd MMM yyyy")
        color: "#ffffff"
        font.pixelSize: parent.height * 0.1
        font.bold: false
    }
}