import QtQuick 2.7

Rectangle {
    width: 100
    height: 40
    color: "lightblue"
    border.color: "black"
    border.width: 1
    radius: 5

    Text {
        anchors.centerIn: parent
        text: "Click Me"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("Button clicked!")
        }
    }
}