import QtQuick 2.9
import Lomiri.Components 1.3
import"../components"


Page {
    id: tasksView
    header: PageHeader {
        title: i18n.tr("Tasks")
           StyleHints {
            backgroundColor:  theme.name === "Ubuntu.Components.Themes.SuruDark" ? "black" : "#1c355e"
		foregroundColor: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "white"
	}
        trailingActionBar {
            actions: [
                Action {
                    iconName: "add"
                    text: i18n.tr("New Task")
                    onTriggered: newTaskRequested()
                }
            ]
        }
    }
    
    property var model
    signal newTaskRequested()
    signal taskSelected(var taskData)
    
    ListView {
        anchors {
            fill: parent
            topMargin: tasksView.header.height
            margins: units.gu(2)
        }
        
        model: tasksView.model ? tasksView.model.tasks : null
        
        section.property: "project"
        section.delegate: ListItemHeader {
            title: section
        }
        
        delegate: ListItem {
            height: layout.height + divider.height
            
            ListItemLayout {
                id: layout
                title.text: name
                subtitle.text: dueDate
                
                CheckBox {
                    SlotsLayout.position: SlotsLayout.Leading
                    checked: completed
                    onClicked: {
                        // Call model's toggle function
                        tasksView.model.toggleTaskCompletion(index)
                    }
                }
                
                ProgressionSlot {}
            }
            
            onClicked: {
                taskSelected({
                    name: name,
                    project: project,
                    dueDate: dueDate,
                    completed: completed
                })
            }
        }
        
        EmptyState {
            anchors.centerIn: parent
            visible: parent.count === 0
            title: i18n.tr("No tasks")
            subTitle: i18n.tr("Add your first task to get started")
            iconName: "task"
        }
    }
}
