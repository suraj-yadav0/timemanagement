import QtQuick 2.9
import Lomiri.Components 1.3
import"../components"


Page {
    id: calendarView
    header: PageHeader {
        title: i18n.tr("Calendar")
        subtitle: model ? model.currentMonth : ""
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
    
    property var model
    property string selectedDate: Qt.formatDate(new Date(), "MMMM d, yyyy")
    signal newEventRequested()
    signal dateSelected(string selectedDate)
    
    Column {
        anchors {
            fill: parent
            topMargin: calendarView.header.height
            margins: units.gu(2)
        }
        spacing: units.gu(2)
        
        // Month view (simplified - in a real app you'd use a proper calendar component)
        Rectangle {
            id: calendarGrid
            width: parent.width
            height: width * 0.75
            color: theme.palette.normal.background
            border.color: theme.palette.normal.base
            
            Column {
                anchors.fill: parent
                anchors.margins: units.gu(1)
                spacing: units.gu(1)
                
                // Days of week header
                Row {
                    width: parent.width
                    height: units.gu(4)
                    Repeater {
                        model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
                        Label {
                            width: parent.width / 7
                            height: parent.height
                            text: modelData
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                        }
                    }
                }
                
                // Calendar days (simplified)
                Grid {
                    width: parent.width
                    columns: 7
                    Repeater {
                        model: 31 // Simplified
                        Rectangle {
                            width: parent.width / 7
                            height: width
                            color: index + 1 === 9 ? theme.palette.normal.backgroundSecondary : "transparent"
                            border.color: theme.palette.normal.base
                            border.width: 0.5
                            
                            Label {
                                anchors.centerIn: parent
                                text: index + 1
                            }
                            
                            // Visual indicator for days with events
                            Rectangle {
                                visible: index + 1 === 9
                                width: units.gu(0.6)
                                height: width
                                radius: width / 2
                                color: theme.palette.normal.positive
                                anchors {
                                    bottom: parent.bottom
                                    bottomMargin: units.gu(0.5)
                                    horizontalCenter: parent.horizontalCenter
                                }
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    var date = "October " + (index + 1) + ", 2023" // Simplified
                                    calendarView.selectedDate = date
                                    dateSelected(date)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // Today's events
        Item {
            width: parent.width
            height: parent.height - calendarGrid.height - parent.spacing
            
            Column {
                anchors.fill: parent
                spacing: units.gu(1)
                
                Label {
                    text: i18n.tr("Today's Events")
                    fontSize: "large"
                }
                
                ListView {
                    width: parent.width
                    height: parent.height - y
                    clip: true
                    model: calendarView.model ? calendarView.model.events : null
                    delegate: ListItem {
                        ListItemLayout {
                            title.text: title
                            subtitle.text: location
                            summary.text: time
                        }
                        onClicked: {
                            dateSelected(date)
                        }
                    }
                    
                    EmptyState {
                        anchors.centerIn: parent
                        visible: parent.count === 0
                        title: i18n.tr("No events today")
                        iconName: "calendar"
                    }
                }
            }
        }
    }
}
