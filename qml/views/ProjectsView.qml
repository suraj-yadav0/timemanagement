import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: projectsView
    
    property alias model: listView.model
    signal newProjectRequested()
    signal projectSelected(var projectData)
    
    header: PageHeader {
        title: i18n.tr('Projects')
        
        trailingActionBar.actions: [
            Action {
                iconName: "add"
                text: i18n.tr('New Project')
                onTriggered: {
                    projectsView.newProjectRequested()
                }
            }
        ]
    }
    
    ListView {
        id: listView
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: parent.header.bottom
        }
        
        model: projectsView.model ? projectsView.model.projects : null
        
        delegate: ListItem {
            height: units.gu(10)
            
            ListItemLayout {
                title.text: model.name
                subtitle.text: "Due: " + model.deadline
                summary.text: "Priority: " + model.priority
                
                ProgressBar {
                    SlotsLayout.position: SlotsLayout.Trailing
                    minimumValue: 0
                    maximumValue: 100
                    value: parseInt(model.progress)
                    width: units.gu(10)
                }
            }
            
            onClicked: {
                projectsView.projectSelected({
                    "name": model.name,
                    "progress": model.progress,
                    "deadline": model.deadline,
                    "priority": model.priority
                })
            }
        }
    }
}