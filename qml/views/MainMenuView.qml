import QtQuick 2.9
import Lomiri.Components 1.3


Page {
    id: mainMenuView
    header: PageHeader {
        title: i18n.tr("Time Management")



         trailingActionBar.actions: [
                    Action {
                        iconName: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "weather-clear-night" : "weather-clear"
                        text: theme.name === "Ubuntu.Components.Themes.SuruDark" ? i18n.tr("Light Mode") : i18n.tr("Dark Mode")
                        onTriggered: {
                            Theme.name = theme.name === "Ubuntu.Components.Themes.SuruDark" ? "Ubuntu.Components.Themes.Ambiance" : "Ubuntu.Components.Themes.SuruDark";
                        }
                    }
                ]
    }
    
       
    property var model
    signal itemSelected(string itemName)
    
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
            color: theme.palette.normal.backgroundTertiaryText
        }
    }
}
