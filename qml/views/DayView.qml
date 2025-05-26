import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: dayView
    header: PageHeader {
        title: date
        trailingActionBar {
            actions: [
                Action {
                    iconName: "add"
                    text: i18n.tr("New Event")
                    onTriggered: newEventRequested()
                }
            ]
        }
    }
    
    property string date: "October 9, 2023"
    property var events: []
    signal newEventRequested()
    signal eventSelected(var eventData)
    
    Component.onCompleted: {
        if (pageStack && pageStack.mainApp && pageStack.mainApp.calendarModel) {
            events = pageStack.mainApp.calendarModel.getEventsForDate(date)
        }
    }
    
    ListView {
        anchors {
            fill: parent
            topMargin: dayView.header.height
            margins: units.gu(2)
        }
        
        model: events
        
        section {
            property: "time"
            delegate: ListItemHeader {
                title: section
            }
        }
        
        delegate: ListItem {
            height: layout.height + divider.height
            
            ListItemLayout {
                id: layout
                title.text: model.title
                subtitle.text: model.location
                
                Icon {
                    SlotsLayout.position: SlotsLayout.Leading
                    name: "calendar"
                    width: units.gu(2)
                    height: width
                }
            }
            
            onClicked: {
                eventSelected({
                    time: model.time,
                    title: model.title,
                    location: model.location,
                    date: model.date
                })
            }
        }
        
        EmptyState {
            anchors.centerIn: parent
            visible: parent.count === 0
            title: i18n.tr("No events for this day")
            subTitle: i18n.tr("Add an event to get started")
            iconName: "calendar"
        }
    }
    
    // Timeline visualization
    Rectangle {
        id: timeline
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            topMargin: dayView.header.height
            rightMargin: units.gu(1)
        }
        width: units.dp(2)
        color: UbuntuColors.silk
        
        // Current time indicator
        Rectangle {
            width: units.gu(3)
            height: units.dp(3)
            radius: height / 2
            color: UbuntuColors.red
            anchors {
                horizontalCenter: parent.horizontalCenter
                // Position based on current time (simplified)
                top: parent.top
                topMargin: parent.height * 0.3 // Just an example position
            }
        }
    }
}
