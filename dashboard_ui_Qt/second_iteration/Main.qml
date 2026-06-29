import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root
    visible: true

    readonly property int appWidth: 1024
    readonly property int appHeight: 768
    property var row1Widgets: [
        "SpeedCell.qml", "F_HeadlightCell.qml", "R_HeadlightCell.qml", "Safetylightcell.qml","Cameracell.qml","Aicamera.qml","ASR.qml", "SearchCell.qml", "SettingsCell.qml"
    ]
    property var row2Widgets: [
        "Batterytemp.qml", "EB_temp.qml","Hydr_meter.qml","Motor_temp_high.qml", "Oil_temp_warning.qml","Oil_level_warning.qml","Hydra_low.qml","Hydra_high.qml","Solenoid.qml"
    ]
    property var row3Widgets: [
        "Park.qml","Slip.qml","topple.qml","Warning.qml", null, null, null, null, null
    ]
    width: appWidth
    height: appHeight

    title: "Dashboard"
    color: "#000000"

    Rectangle {
        id: leftPanel

        x: 0
        y: 0

        width: root.appWidth * 0.625
        height: rowsGroupBorder.y + rowsGroupBorder.height + 20

        color: "#000000"

        Rectangle {
            id: space

            anchors.fill: parent
            anchors.margins: 5

            color: "#000000"

            readonly property int cols: 9
            readonly property int cellSpacing: 2

            readonly property int gapRow1toRow2: 15
            readonly property int gapRow2toRow3: 2

            readonly property real cellSize:
                (row1Border.width - 10 - 6 - cellSpacing * (cols - 1)) / cols

            // =========================================================
            // ROW 1 OUTER BORDER
            // =========================================================

            Rectangle {
                id: row1Border

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.topMargin: 15
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                height: space.cellSize + 16

                color: "transparent"
                border.color: "#ffffff"
                border.width: 3
                radius: 6

                Rectangle {
                    id: row1Inner

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 5
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5

                    height: space.cellSize + 6

                    color: "transparent"
                    border.color: "#000000"
                    border.width: 2
                    radius: 4

                    Row {
                        anchors.fill: parent
                        anchors.margins: 3

                        spacing: space.cellSpacing

                        Repeater {
                            model: space.cols

                            Rectangle {
                                width: space.cellSize
                                height: space.cellSize

                                color: "#ffffff"
                                border.color: "#ffffff"
                                border.width: 1
                                radius: 4
                                clip: true

                                Loader {
                                    anchors.fill: parent
                                    active: index < root.row1Widgets.length && root.row1Widgets[index] !== null
                                    source: (index < root.row1Widgets.length && root.row1Widgets[index] !== null)
                                            ? root.row1Widgets[index]
                                            : ""
                                }
                            }
                        }
                    }
                }
            }

            // =========================================================
            // ROWS 2,3,4 OUTER BORDER
            // =========================================================

            Rectangle {
                id: rowsGroupBorder

                anchors.top: row1Border.bottom
                anchors.left: row1Border.left
                anchors.right: row1Border.right

                anchors.topMargin: space.gapRow1toRow2

                height:
                    5 +
                    (space.cellSize + 6) +
                    space.gapRow2toRow3 +
                    (space.cellSize + 6) +
                    5

                color: "transparent"

                border.color: "#ffffff"
                border.width: 3

                radius: 6

                // =====================================================
                // ROW 2
                // =====================================================

                Rectangle {
                    id: row2Border

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 5
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5

                    height: space.cellSize + 6

                    color: "transparent"
                    border.color: "#000000"
                    border.width: 2
                    radius: 4

                    Row {
                        anchors.fill: parent
                        anchors.margins: 3

                        spacing: space.cellSpacing

                        Repeater {
                            model: space.cols

                            Rectangle {
                                width: space.cellSize
                                height: space.cellSize

                                color: "#ffffff"

                                border.color: "#ffffff"
                                border.width: 1

                                radius: 6
                                clip: true
                                Loader {
                                           anchors.fill: parent
                                           active: index < root.row2Widgets.length && root.row2Widgets[index] !== null
                                           source: (index < root.row2Widgets.length && root.row2Widgets[index] !== null)
                                                   ? root.row2Widgets[index]
                                                   : ""
                                       }
                            }
                        }
                    }
                }

                // =====================================================
                // ROW 3
                // =====================================================

                Rectangle {
                    id: row3Border

                    anchors.top: row2Border.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: space.gapRow2toRow3
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5

                    height: space.cellSize + 6

                    color: "transparent"
                    border.color: "#000000"
                    border.width: 2
                    radius: 4

                    Row {
                        anchors.fill: parent
                        anchors.margins: 3

                        spacing: space.cellSpacing

                        Repeater {
                            model: space.cols

                            Rectangle {
                                width: space.cellSize
                                height: space.cellSize

                                color: "#ffffff"

                                border.color: "#ffffff"
                                border.width: 1

                                radius: 6
                                clip: true
                                Loader {
                                           anchors.fill: parent
                                           active: index < root.row3Widgets.length && root.row3Widgets[index] !== null
                                           source: (index < root.row3Widgets.length && root.row3Widgets[index] !== null)
                                                   ? root.row3Widgets[index]
                                                   : ""
                                       }
                            }
                        }
                    }
                }


            }
        }
    }

    // =========================================================
    // EXTRA ROW PANEL — extension below leftPanel (5 cells)
    // =========================================================
    Rectangle {
        id: extraPanel

        x: 0
        y: root.appHeight * 0.3486  // was leftPanel.y + leftPanel.height - 15

        width:  root.appWidth  * 0.3566   // was extraRowBorder.x + extraRowBorder.width + 10
        height: root.appHeight * 0.1435   // was extraRowBorder.y + extraRowBorder.height + 15

        color: "#000000"

        Rectangle {
            id: extraRowBorder

            x: 15
            y: 15

            width: 5 * space.cellSize + 4 * space.cellSpacing + 16
            height: space.cellSize + 16

            color: "transparent"
            border.color: "#ffffff"
            border.width: 3
            radius: 6

            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.topMargin: 5
                anchors.leftMargin: 5
                anchors.rightMargin: 5

                height: space.cellSize + 6

                color: "transparent"
                border.color: "#000000"
                border.width: 2
                radius: 4

                Row {
                    anchors.fill: parent
                    anchors.margins: 3
                    spacing: space.cellSpacing

                    Repeater {
                        model: 5

                        Rectangle {
                            width: space.cellSize
                            height: space.cellSize

                            color: "#0f3460"
                            border.color: "#ffffff"
                            border.width: 1

                            radius: 6
                            clip: true
                        }
                    }
                }
            }
        }
    }



    // =========================================================
    // BATTERY PANEL — position as ratio of appWidth/appHeight
    // =========================================================
    Rectangle {
            id: batPanel

            x: root.appWidth  * 0.3663 + 68
            y: 190                                 // start from top, same as leftPanel


            width:  100
            height: 265

            color: "#000000"
            border.color: "#000000"
            rotation: 90

            Battery {
                anchors.fill: parent
            }
        }

    // =========================================================
    // STEERING PANEL — position as ratio of appWidth/appHeight
    // =========================================================
    Rectangle {
            id: steerpanel

            x: root.appWidth  * 0.6445-17
            y: root.appHeight * 0.0130+10


            width:  210
            height: 180


            color:        "#000000"
            border.color: "#000000"   // hides the default border causing corner artifacts
            border.width: 3

            Steer {
                anchors.fill: parent
            }
        }
    // =========================================================
    // SPEEDO BOX — position as ratio of appWidth/appHeight
    // =========================================================
    Rectangle {
        id: speedoBox

        x: root.appWidth  * 0.01465
        y: root.appHeight * 0.4946+2

        width:  root.appWidth  * 0.35 -15-115
        height: root.appHeight * 0.1760-40

        color:        "#000000"        // ← was "transparent"
        border.color: "#ffffff"
        border.width: 8
        radius:       8

        Speed {
            anchors.fill: parent
        }
    }

    Setbox {
            x:      root.appWidth  * 0.3500
            y:      root.appHeight * 0.4946
            width:  root.appWidth  * 0.2600
            height: root.appHeight * 0.1760-40
        }
    // =========================================================
        // RIGHT BOTTOM BLOCK — below steer dial, right side
        // =========================================================
    // =========================================================
        // RIGHT BOTTOM BLOCK — below steer dial, right side
        // =========================================================
        Rectangle {
            id: rightBottomBlock

            x:      root.appWidth  * 0.6445-20
            y:      root.appHeight * 0.2800

            width:  root.appWidth  * 0.3400+20
            height: root.appHeight * 0.6900+10

            color:        "transparent"
            border.color: "#ffffff"
            border.width: 3
            radius:       8
        }

        // =========================================================
        // BOTTOM BLOCK — below speedoBox/setbox, left span
        // =========================================================
        Rectangle {
            id: bottomBlock

            x:      root.appWidth  * 0.0100
            y:      root.appHeight * 0.6400

            width:  root.appWidth  * 0.6150-15
            height: root.appHeight * 0.3400

            color:        "transparent"
            border.color: "#ffffff"
            border.width: 3
            radius:       8
        }
        Rectangle {
            id: date_block

            x:      root.appWidth  * 0.0100+850
            y:      root.appHeight * 0.025

            width:  root.appWidth  * 0.145
            height: 180

            color:        "transparent"
            border.color: "#ffffff"
            border.width: 3
            radius:       8

            Date_time {
                anchors.fill: parent
            }

        }
        Rectangle {
            id: height_block

            x:      root.appWidth  * 0.0100+240
            y:      root.appHeight * 0.025+362

            width:  root.appWidth  * 0.1
            height: 93

            color:        "transparent"
            border.color: "#ffffff"
            border.width: 3
            radius:       8
            Rectangle {
                id: smallbox

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.topMargin: 7
                anchors.leftMargin: 7
                anchors.rightMargin: 7

                height: 40

                color: "transparent"
                border.color: "#ffffff"
                border.width: 2
                radius: 4


            }
            Text {
                id: unit_text
                text: "mm"
                color: "#ffffff"
                font.bold: true
                font.pixelSize: 20
                font.family: "Arial"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 60
            }
        }
}