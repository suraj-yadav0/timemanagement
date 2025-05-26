import QtQuick 2.9
import Lomiri.Components 1.3

Item {
    id: emptyState
    
    property string title: ""
    property string subTitle: ""
    property string iconName: "question"
    
    anchors.fill: parent
    visible: false
    
    Column {
        anchors.centerIn: parent
        spacing: units.gu(2)
        width: parent.width * 0.7
        
        Icon {
            width: units.gu(10)
            height: width
            name: emptyState.iconName
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.5
        }
        
        Label {
            width: parent.width
            text: emptyState.title
            fontSize: "large"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }
        
        Label {
            width: parent.width
            text: emptyState.subTitle
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            opacity: 0.7
        }
    }
}
