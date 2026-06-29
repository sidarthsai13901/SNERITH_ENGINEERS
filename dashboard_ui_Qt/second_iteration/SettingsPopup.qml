import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id: root

    parent: Overlay.overlay

    x: 0
    y: 0
    width: ApplicationWindow.window.width
    height: ApplicationWindow.window.height

    modal: true
    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        color: "#000000"
        border.color: "#ffffff"
        border.width: 2
        radius: 8
    }

    // ── Close button (red ✕, top-right) ──────────────────────
    Rectangle {
        id: closeBtn
        width: 32
        height: 32
        color: "#cc0000"
        radius: 4

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 8
        z: 10

        Text {
            anchors.centerIn: parent
            text: "✕"
            color: "#ffffff"
            font.pixelSize: 16
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.close()
        }
    }

    // ── Settings label — top center ───────────────────────────
    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 12
        text: "Settings"
        color: "#ffffff"
        font.pixelSize: 28
    }
}