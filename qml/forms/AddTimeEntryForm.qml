import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: addTimeEntryForm
    header: PageHeader {
        title: i18n.tr("Add Time Entry")
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
    
    signal saveRequested(var entryData)
    signal cancelRequested()
    
    property var projects: ["Website Redesign", "Mobile App Development", "Marketing Campaign"]
    
    Column {
        anchors {
            fill: parent
            topMargin: addTimeEntryForm.header.height
            margins: units.gu(2)
        }
        spacing: units.gu(2)
        
        // Date
        Label {
            text: i18n.tr("Date")
        }
        
        Button {
            id: dateButton
            width: parent.width
            text: Qt.formatDate(new Date(), "dddd, MMM d")
            onClicked: {
                // In a real app, this would show a date picker
            }
        }
        
        // Project
        Label {
            text: i18n.tr("Project")
        }
        
        OptionSelector {
            id: projectSelector
            width: parent.width
            model: projects
            selectedIndex: 0
        }
        
        // Task
        Label {
            text: i18n.tr("Task")
        }
        
        TextField {
            id: taskField
            width: parent.width
            placeholderText: i18n.tr("What did you work on?")
        }
        
        // Hours
        Label {
            text: i18n.tr("Hours")
        }
        
        Row {
            width: parent.width
            spacing: units.gu(1)
            
            TextField {
                id: hoursField
                width: parent.width / 2 - parent.spacing / 2
                placeholderText: "0.0"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
            
            Button {
                width: parent.width / 2 - parent.spacing / 2
                text: i18n.tr("Start Timer")
                color: UbuntuColors.blue
                
                onClicked: {
                    // Timer logic would go here
                }
            }
        }
        
        // Notes
        Label {
            text: i18n.tr("Notes (Optional)")
        }
        
        TextArea {
            id: notesField
            width: parent.width
            height: units.gu(8)
            placeholderText: i18n.tr("Add notes about this time entry")
        }
        
        // Billable toggle
        ListItem {
            height: billableLayout.height + divider.height
            
            ListItemLayout {
                id: billableLayout
                title.text: i18n.tr("Billable")
                
                Switch {
                    id: billableSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: true
                }
            }
            
            onClicked: billableSwitch.checked = !billableSwitch.checked
        }
        
        // Save button
        Button {
            text: i18n.tr("Save Time Entry")
            color: UbuntuColors.green
            width: parent.width
            
            onClicked: {
                if (hoursField.text === "") {
                    hoursField.text = "1.0"
                }
                
                saveRequested({
                    date: dateButton.text,
                    project: projectSelector.model[projectSelector.selectedIndex],
                    hours: hoursField.text + " hrs",
                    task: taskField.text,
                    notes: notesField.text,
                    billable: billableSwitch.checked
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
