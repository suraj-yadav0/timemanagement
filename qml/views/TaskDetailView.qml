import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: taskDetailView
    header: PageHeader {
        title: i18n.tr("Task Details")
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
    
    property var taskData: ({
        name: "",
        project: "",
        dueDate: "",
        completed: false
    })
    
    signal editRequested()
    signal deleteRequested()
    signal taskToggled()
    
    ScrollView {
        anchors {
            fill: parent
            topMargin: taskDetailView.header.height
            margins: units.gu(2)
        }
        
        Column {
            width: parent.width
            spacing: units.gu(2)
            
            // Task completion status
            ListItem {
                height: statusLayout.height + divider.height
                
                ListItemLayout {
                    id: statusLayout
                    title.text: i18n.tr("Status")
                    
                    CheckBox {
                        SlotsLayout.position: SlotsLayout.Trailing
                        checked: taskDetailView.taskData.completed
                        onClicked: {
                            taskDetailView.taskData.completed = !taskDetailView.taskData.completed
                            taskToggled()
                        }
                    }
                }
            }
            
            // Task name
            ListItem {
                height: nameLayout.height + divider.height
                
                ListItemLayout {
                    id: nameLayout
                    title.text: i18n.tr("Task Name")
                    subtitle.text: taskDetailView.taskData.name
                }
            }
            
            // Project
            ListItem {
                height: projectLayout.height + divider.height
                
                ListItemLayout {
                    id: projectLayout
                    title.text: i18n.tr("Project")
                    subtitle.text: taskDetailView.taskData.project
                }
            }
            
            // Due Date
            ListItem {
                height: dueDateLayout.height + divider.height
                
                ListItemLayout {
                    id: dueDateLayout
                    title.text: i18n.tr("Due Date")
                    subtitle.text: taskDetailView.taskData.dueDate
                    
                    Icon {
                        SlotsLayout.position: SlotsLayout.Trailing
                        name: "calendar"
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
                text: i18n.tr("No notes available for this task.")
            }
            
            // Related items section
            Item { 
                width: parent.width
                height: units.gu(2)
            }
            
            Label {
                text: i18n.tr("Related Items")
                fontSize: "medium"
                font.bold: true
            }
            
            ListItem {
                height: relatedLayout.height + divider.height
                
                ListItemLayout {
                    id: relatedLayout
                    title.text: i18n.tr("No related items")
                }
            }
        }
    }
}
