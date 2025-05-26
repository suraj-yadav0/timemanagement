import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: timeEntryDetailView
    header: PageHeader {
        title: i18n.tr("Time Entry Details")
        trailingActionBar {
            actions: [
                Action {
                    iconName: "edit"
                    text: i18n.tr("Edit")
                    onTriggered: editRequested()
                },
                Action {
                    iconName: "delete"
                    text: i18n.tr("Delete")
                    onTriggered: deleteRequested()
                }
            ]
        }
    }
    
    property var entryData: ({
        date: "",
        project: "",
        hours: "",
        task: ""
    })
    
    signal editRequested()
    signal deleteRequested()
    
    Column {
        anchors {
            fill: parent
            topMargin: timeEntryDetailView.header.height
            margins: units.gu(2)
        }
        spacing: units.gu(2)
        
        // Time summary card
        Rectangle {
            width: parent.width
            height: units.gu(12)
            color: theme.palette.normal.background
            border.color: theme.palette.normal.base
            radius: units.gu(1)
            
            Column {
                anchors.centerIn: parent
                spacing: units.gu(1)
                
                Label {
                    text: entryData.hours
                    fontSize: "x-large"
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Label {
                    text: entryData.date
                    fontSize: "medium"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        
        // Entry details
        ListItem {
            height: projectLayout.height + divider.height
            
            ListItemLayout {
                id: projectLayout
                title.text: i18n.tr("Project")
                subtitle.text: entryData.project
                
                Icon {
                    SlotsLayout.position: SlotsLayout.Leading
                    name: "folder"
                    width: units.gu(2)
                    height: width
                }
            }
        }
        
        ListItem {
            height: taskLayout.height + divider.height
            
            ListItemLayout {
                id: taskLayout
                title.text: i18n.tr("Task")
                subtitle.text: entryData.task
                
                Icon {
                    SlotsLayout.position: SlotsLayout.Leading
                    name: "task"
                    width: units.gu(2)
                    height: width
                }
            }
        }
        
        // Notes section
        Item { 
            width: parent.width
            height: units.gu(2)
        }
        
        Label {
            text: i18n.tr("Notes")
            fontSize: "medium"
            font.bold: true
        }
        
        TextArea {
            width: parent.width
            height: units.gu(15)
            readOnly: true
            text: i18n.tr("No notes available for this time entry.")
        }
        
        // Actions
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: units.gu(2)
            
            Button {
                text: i18n.tr("Duplicate")
                color: UbuntuColors.blue
                onClicked: {
                    // Duplicate logic would go here
                }
            }
            
            Button {
                text: i18n.tr("Continue Timer")
                color: UbuntuColors.green
                onClicked: {
                    // Timer continuation logic would go here
                }
            }
        }
    }
}
