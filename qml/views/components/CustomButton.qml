import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Row {
    id: customButton
    
    property alias text: label.text

    property alias name : icon.name

    signal clicked

    anchors.horizontalCenter: parent.horizontalCenter
    spacing: units.gu(1)

    Icon {
        id: icon
        name: "notebook"
        width: units.gu(2)
        height: units.gu(2)
    }
    Rectangle {

        width: 116
        height: 26
        color: "lightsteelblue"
        border.color: "slategrey"
        radius : 10

        Text {
            id: label
            anchors.centerIn: parent
            text: text
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                customButton.clicked();
            }
        }
    }
}
