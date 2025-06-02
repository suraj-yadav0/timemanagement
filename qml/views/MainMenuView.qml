import QtQuick 2.9
import Lomiri.Components 1.3
import"../components"
import "../models"
import "../forms"


Page {
    id: mainMenuView
    header: PageHeader {
        title: i18n.tr("Time Management")
        StyleHints {
            backgroundColor:  theme.name === "Ubuntu.Components.Themes.SuruDark" ? "black" : "#1c355e"
		foregroundColor: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "white"
	}



         trailingActionBar.actions: [
                    Action {
                        iconName: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "weather-clear-night-symbolic" : "weather-clear-symbolic"
                        text: theme.name === "Ubuntu.Components.Themes.SuruDark" ? i18n.tr("Light Mode") : i18n.tr("Dark Mode")
                        onTriggered: {
                            Theme.name = theme.name === "Ubuntu.Components.Themes.SuruDark" ? "Ubuntu.Components.Themes.Ambiance" : "Ubuntu.Components.Themes.SuruDark";
                        }
                    }
                ]
    }
    
       
    property var model
    signal itemSelected(string itemName)
        signal newTimeEntryRequested()
    
    ListView {
        id: menuListView
        anchors {
            fill: parent
            topMargin: mainMenuView.header.height
            margins: units.gu(2)
        }
        
        model: mainMenuView.model ? mainMenuView.model.menuItems : null
        
        delegate: ListItem {
            height: layout.height + divider.height
            
            ListItemLayout {
                id: layout
                title.text: name
                subtitle.text: description
                
                Icon {
                    SlotsLayout.position: SlotsLayout.Leading
                    width: units.gu(3)
                    height: width
                    name: icon || "document"
                    color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "#1c355e"
                }
                
                ProgressionSlot {
                   color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "#1c355e"
                }
            }
            
            onClicked: {
                mainMenuView.itemSelected(name)
            }
        }
        
        // Debug output - prints to console to help diagnose issues
        Component.onCompleted: {
            console.log("MainMenuView loaded, model items: " + 
                      (mainMenuView.model && mainMenuView.model.menuItems ? 
                       mainMenuView.model.menuItems.count : "none"))
        }
    }

     // Visible swipe-up indicator
    Rectangle {
        id: swipeIndicator
        width: units.gu(6)
        height: units.gu(0.7)
        radius: height / 2
        color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "#1c355e"
        opacity: 0.7
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: swipeUpArea.top
        anchors.bottomMargin: units.gu(0.5)
        z: 1000
    }


    MultiPointTouchArea {
        id: swipeUpArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: units.gu(6)
        minimumTouchPoints: 1
        maximumTouchPoints: 1

        property real startY: 0

        onPressed: {
            startY = touchPoints[0].y;
        }
        onReleased: {
            var endY = touchPoints[0].y;
            // Detect upward swipe (swipe up: startY > endY)
            if (startY - endY > units.gu(3)) {
                // threshold for swipe
                
            mainMenuView.newTimeEntryRequested()
            }
        }
        z: 999 // Ensure it's above other content

        Rectangle {
            anchors.fill: parent
            color: "lightgray"
            opacity: 0.1// Make it invisible but still interactive
        }
    }
    
    // App version at bottom
    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: units.gu(4)
        color: theme.palette.normal.background
        
        Label {
            anchors.centerIn: parent
            text: "Time Management v1.0"
            fontSize: "small"
            color:  theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "#1c355e"
        }
    }
}
