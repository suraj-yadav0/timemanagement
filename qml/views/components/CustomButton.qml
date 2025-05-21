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
     color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
        name: "notebook"
        width: units.gu(2.5)
        height: units.gu(2.7)
    }
    Rectangle {

        width: 116
        height: 26
        color: "lightgrey"
        border.color: "slategrey"
        radius : 7

        Text {
            id: label
            anchors.centerIn: parent
            text: text
           // color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                customButton.clicked();
            }
        }
    }
}
