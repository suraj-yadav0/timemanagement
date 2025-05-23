import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Page {
    id: projectListPage

    // Main content
    Column {
        anchors {
            fill: parent
            margins: units.gu(2)
            topMargin: units.gu(2)
        }
        spacing: units.gu(2)

        // Top row with Projects label and menu button
        Row {
            width: parent.width
            spacing: units.gu(2)

              Button {
                visible: width < 800
                anchors.verticalCenter: parent.verticalCenter
                
                width: units.gu(5)
                height: units.gu(5)
                background: Rectangle {
                    color: theme.palette.normal.background
                    radius: units.gu(1)
                }
                onClicked: {
                    mainPageRoot.menuOpen = !mainPageRoot.menuOpen
                }
                contentItem: Icon {
                    anchors.centerIn: parent
                    name: "navigation-menu"
                    width: units.gu(3)
                    height: units.gu(3)
                }
            }


            Label {
                text: i18n.tr("Projects")
                font.pixelSize: units.gu(4)
                font.weight: Font.DemiBold
                color: theme.palette.normal.Text
                verticalAlignment: Text.AlignVCenter
            }

           

        }
        
        // Sample project list - replace with your actual data
        Repeater {
            model: [
                { name: "Sample Project 1", description: "This is a sample project", status: "Active" },
                { name: "Sample Project 2", description: "Another sample project", status: "Completed" },
                { name: "Sample Project 3", description: "Third sample project", status: "In Progress" }
            ]
            
            delegate: ListItem {
                height: units.gu(8)
                divider.visible: false
                
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: units.gu(1)
                    color: theme.palette.normal.foreground
                    radius: units.gu(1)
                    border.color: theme.palette.normal.base
                    border.width: 1
                    
                    Column {
                        anchors {
                            left: parent.left
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            margins: units.gu(2)
                        }
                        spacing: units.gu(0.5)
                        
                        Row {
                            spacing: units.gu(2)
                            width: parent.width
                            
                            Label {
                                text: modelData.name
                                font.weight: Font.DemiBold
                                color: theme.palette.normal.backgroundText
                            }
                            
                            Label {
                                text: "• " + modelData.status
                                color: modelData.status === "Active" ? "green" : 
                                       modelData.status === "Completed" ? "blue" : "orange"
                                font.pixelSize: units.gu(1.5)
                            }
                        }
                        
                        Label {
                            text: modelData.description
                            color: theme.palette.normal.backgroundSecondaryText
                            font.pixelSize: units.gu(1.8)
                            wrapMode: Text.WordWrap
                            width: parent.width
                        }
                    }
                }
                
                onClicked: {
                    console.log("Project clicked:", modelData.name)
                    // TODO: Navigate to project details
                }
            }
        }
        
        // Empty state when no projects
        Item {
            width: parent.width
            height: units.gu(20)
            visible: false // Set to true when no projects exist
            
            Column {
                anchors.centerIn: parent
                spacing: units.gu(2)
                
                Icon {
                    name: "note"
                    width: units.gu(8)
                    height: units.gu(8)
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: theme.palette.normal.backgroundTertiaryText
                }
                
                Label {
                    text: i18n.tr("No projects yet")
                    font.pixelSize: units.gu(2.5)
                    color: theme.palette.normal.backgroundSecondaryText
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Label {
                    text: i18n.tr("Tap the + button to create your first project")
                    color: theme.palette.normal.backgroundTertiaryText
                    anchors.horizontalCenter: parent.horizontalCenter
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}