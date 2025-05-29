import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: newProjectForm
    header: PageHeader {
        title: i18n.tr("New Project")
           StyleHints {
            backgroundColor:  theme.name === "Ubuntu.Components.Themes.SuruDark" ? "black" : "#1c355e"
		foregroundColor: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "white"
	}
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
    
    signal saveRequested(var projectData)
    signal cancelRequested()
    
    ScrollView {
        anchors {
            fill: parent
            topMargin: newProjectForm.header.height
            margins: units.gu(2)
        }
        
        Column {
            width: parent.width
            spacing: units.gu(2)
            
            // Project name
            Label {
                text: i18n.tr("Project Name")
            }
            
            TextField {
                id: nameField
                width: parent.width
                placeholderText: i18n.tr("Enter project name")
            }
            
            // Client
            Label {
                text: i18n.tr("Client")
            }
            
            TextField {
                id: clientField
                width: parent.width
                placeholderText: i18n.tr("Enter client name")
            }
            
            // Deadline
            Label {
                text: i18n.tr("Deadline")
            }
            
            Button {
                id: deadlineButton
                width: parent.width
                text: i18n.tr("Select deadline")
                onClicked: {
                    // In a real app, this would show a date picker
                    text = "December 31, 2023"
                }
            }
            
            // Budget
            Label {
                text: i18n.tr("Budget")
            }
            
            Row {
                width: parent.width
                spacing: units.gu(1)
                
                TextField {
                    id: budgetField
                    width: parent.width - budgetTypeField.width - parent.spacing
                    placeholderText: "0.00"
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                }
                
                OptionSelector {
                    id: budgetTypeField
                    width: units.gu(15)
                    model: [i18n.tr("Fixed"), i18n.tr("Hourly")]
                }
            }
            
            // Status
            Label {
                text: i18n.tr("Status")
            }
            
            OptionSelector {
                id: statusField
                width: parent.width
                model: [
                    i18n.tr("Not Started"),
                    i18n.tr("In Progress"),
                    i18n.tr("On Hold"),
                    i18n.tr("Completed")
                ]
            }
            
            // Description
            Label {
                text: i18n.tr("Description")
            }
            
            TextArea {
                id: descriptionField
                width: parent.width
                height: units.gu(10)
                placeholderText: i18n.tr("Enter project description")
                autoSize: true
            }
            
            // Team members
            Label {
                text: i18n.tr("Team Members")
            }
            
            TextField {
                id: teamMembersField
                width: parent.width
                placeholderText: i18n.tr("Add team members (comma separated)")
            }
            
            // Save button
            Button {
                text: i18n.tr("Create Project")
                color: UbuntuColors.green
                width: parent.width
                
                onClicked: {
                    saveRequested({
                        name: nameField.text,
                        client: clientField.text,
                        deadline: deadlineButton.text !== i18n.tr("Select deadline") ? deadlineButton.text : "",
                        budget: budgetField.text,
                        budgetType: budgetTypeField.currentText,
                        status: statusField.currentText,
                        description: descriptionField.text,
                        teamMembers: teamMembersField.text
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
