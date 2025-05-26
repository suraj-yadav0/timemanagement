import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: addEventForm
    header: PageHeader {
        title: i18n.tr("New Event")
        trailingActionBar {
            actions: [
                Action {
                    iconName: "close"
                    text: i18n.tr("Cancel")
                    onTriggered: cancelRequested()
                }
            ]
        }
    }
    
    signal saveRequested(var eventData)
    signal cancelRequested()
    
    property var initialData: ({
        time: "",
        title: "",
        location: "",
        date: Qt.formatDate(new Date(), "MMMM d, yyyy")
    })
    
    ScrollView {
        anchors {
            fill: parent
            topMargin: addEventForm.header.height
            margins: units.gu(2)
        }
        
        Column {
            width: parent.width
            spacing: units.gu(2)
            
            // Event title
            Label {
                text: i18n.tr("Event Title")
            }
            
            TextField {
                id: titleField
                width: parent.width
                placeholderText: i18n.tr("Enter event title")
                text: initialData.title
            }
            
            // Date
            Label {
                text: i18n.tr("Date")
            }
            
            Button {
                id: dateButton
                width: parent.width
                text: initialData.date
                onClicked: {
                    // In a real app, this would show a date picker dialog
                    // For now, we'll use the initialData date
                }
            }
            
            // Time
            Label {
                text: i18n.tr("Time")
            }
            
            Button {
                id: timeButton
                width: parent.width
                text: initialData.time || i18n.tr("Select time")
                onClicked: {
                    // In a real app, this would show a time picker dialog
                    // For now, we'll just toggle between some example times
                    var times = ["9:00 AM", "12:00 PM", "3:00 PM", "6:00 PM"]
                    var currentIndex = times.indexOf(text)
                    var nextIndex = (currentIndex + 1) % times.length
                    text = times[nextIndex]
                }
            }
            
            // Location
            Label {
                text: i18n.tr("Location")
            }
            
            TextField {
                id: locationField
                width: parent.width
                placeholderText: i18n.tr("Enter location")
                text: initialData.location
            }
            
            // Notes
            Label {
                text: i18n.tr("Notes")
            }
            
            TextArea {
                id: notesField
                width: parent.width
                height: units.gu(10)
                placeholderText: i18n.tr("Enter any additional notes")
            }
            
            // Reminder
            ListItem {
                height: reminderLayout.height + divider.height
                
                ListItemLayout {
                    id: reminderLayout
                    title.text: i18n.tr("Set Reminder")
                    
                    Switch {
                        id: reminderSwitch
                        SlotsLayout.position: SlotsLayout.Trailing
                    }
                }
                
                onClicked: reminderSwitch.checked = !reminderSwitch.checked
            }
            
            // Attendees
            Label {
                text: i18n.tr("Attendees")
            }
            
            TextField {
                id: attendeesField
                width: parent.width
                placeholderText: i18n.tr("Add attendees (comma separated)")
            }
            
            // Save button
            Button {
                text: i18n.tr("Save Event")
                color: UbuntuColors.green
                width: parent.width
                
                onClicked: {
                    saveRequested({
                        time: timeButton.text !== i18n.tr("Select time") ? timeButton.text : "",
                        title: titleField.text,
                        location: locationField.text,
                        date: dateButton.text
                    })
                }
            }
            
            // Cancel button
            Button {
                text: i18n.tr("Cancel")
                width: parent.width
                
                onClicked: {
                    cancelRequested()
                }
            }
        }
    }
}
