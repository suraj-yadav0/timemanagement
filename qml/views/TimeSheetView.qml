import QtQuick 2.9
import Lomiri.Components 1.3

import "../components"

Page {
    id: timeSheetView
    header: PageHeader {
        title: i18n.tr("Time Sheet")
        trailingActionBar {
            actions: [
                Action {
                    iconName: "add"
                    text: i18n.tr("New Entry")
                    onTriggered: newTimeEntryRequested()
                }
            ]
        }
    }
    
    property var model
    signal newTimeEntryRequested()
    signal timeEntrySelected(var entryData)
    
    ListView {
        anchors {
            fill: parent
            topMargin: timeSheetView.header.height
            margins: units.gu(2)
        }
        
        model: timeSheetView.model ? timeSheetView.model.entries : null
        
        section.property: "date"
        section.delegate: ListItemHeader {
            title: section
        }
        
        delegate: ListItem {
            height: layout.height + divider.height
            
            ListItemLayout {
                id: layout
                title.text: project
                subtitle.text: task
                summary.text: hours
                
                ProgressionSlot {}
            }
            
            onClicked: {
                timeEntrySelected({
                    date: date,
                    project: project,
                    hours: hours,
                    task: task
                })
            }
        }
        
        EmptyState {
            anchors.centerIn: parent
            visible: parent.count === 0
            title: i18n.tr("No time entries")
            subTitle: i18n.tr("Add your first time entry to start tracking")
            iconName: "alarm-clock"
        }
    }
}
