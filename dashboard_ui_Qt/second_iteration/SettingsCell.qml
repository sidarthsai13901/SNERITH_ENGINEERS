import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Effects

Item {
    anchors.fill: parent

    Image {
        id: settingsIcon
        anchors.centerIn: parent
        width: parent.width * 0.92
        height: parent.height * 0.92
        source: "qrc:/icons/settings.png"
        fillMode: Image.PreserveAspectFit
        smooth: true
        layer.enabled: true
    }

    MultiEffect {
        source: settingsIcon
        anchors.centerIn: parent
        width: settingsIcon.width
        height: settingsIcon.height
        maskEnabled: true
        maskSource: ShaderEffectSource {
            sourceItem: Rectangle {
                width: settingsIcon.width
                height: settingsIcon.height
                radius: 8
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: settingsPopup.open()
    }

    SettingsPopup {
        id: settingsPopup
    }
}