import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent

    Image {
        id: searchIcon
        anchors.centerIn: parent
        width: parent.width*0.93
        height: parent.height*0.93
        source: "qrc:/icons/search.png"
        fillMode: Image.PreserveAspectFit

        MouseArea {
            anchors.fill: parent
            onClicked: {
                searchPopup.open()
            }
        }
    }

    SearchPopup {
        id: searchPopup
    }
}