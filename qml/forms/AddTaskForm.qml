import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: addTaskForm
    header: PageHeader {
        title: i18n.tr("Add Task")
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
    
    signal saveRequested(var taskData)
    signal cancelRequested()
    
    property var projects: ["Website Redesign", "Mobile App Development", "Marketing Campaign"]
    
    ScrollView {
        anchors {
            fill: parent
            topMargin: addTaskForm.header.height
            margins: units.gu(2)
        }
        
        Column {
            width: parent.width
            spacing: units.gu(2)
            
            // Task name
            Label {
                text: i18n.tr("Task Name")
            }
            
            TextField {
                id: nameField
                width: parent.width
                placeholderText: i18n.tr("Enter task name")
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
            
            // Due date
            Label {
                text: i18n.tr("Due Date")
            }
            
            Button {
                id: dueDateButton
                width: parent.width
                text: i18n.tr("Select due date")
                onClicked: {
                    // In a real app, this would show a date picker
                    text = "Oct 25, 2023"
                }
            }
            
            // Priority
            Label {
                text: i18n.tr("Priority")
            }
            
            OptionSelector {
                id: prioritySelector
                width: parent.width
                model: [
                    i18n.tr("Low"),
                    i18n.tr("Medium"),
                    i18n.tr("High"),
                    i18n.tr("Urgent")
                ]
                selectedIndex: 1 // Default to Medium
            }
            
            // Estimated time
            Label {
                text: i18n.tr("Estimated Hours")
            }
            
            TextField {
                id: estimatedHoursField
                width: parent.width
                placeholderText: "0.0"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
            
            // Description
            Label {
                text: i18n.tr("Description")
            }
            
            TextArea {
                id: descriptionField
                width: parent.width
                height: units.gu(8)
                placeholderText: i18n.tr("Enter task description")
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
            
            // Save button
            Button {
                text: i18n.tr("Create Task")
                color: UbuntuColors.green
                width: parent.width
                
                onClicked: {
                    saveRequested({
                        name: nameField.text,
                        project: projectSelector.model[projectSelector.selectedIndex],
                        dueDate: dueDateButton.text !== i18n.tr("Select due date") ? dueDateButton.text : "",
                        completed: false,
                        priority: prioritySelector.model[prioritySelector.selectedIndex],
                        estimatedHours: estimatedHoursField.text,
                        description: descriptionField.text,
                        reminder: reminderSwitch.checked
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
