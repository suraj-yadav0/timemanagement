import QtQuick 2.9
import Lomiri.Components 1.3

Item {
    id: listItemHeader
    width: parent.width
    height: units.gu(4)
    
    property alias title: headerLabel.text
    
    Rectangle {
        anchors.fill: parent
        color: theme.palette.normal.background
    }
    
    Label {
        id: headerLabel
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: units.gu(2)
            rightMargin: units.gu(2)
        }
        fontSize: "medium"
        font.bold: true
        color: theme.palette.normal.backgroundSecondaryText
    }
    
    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: units.dp(1)
        color: theme.palette.normal.base
    }
}
