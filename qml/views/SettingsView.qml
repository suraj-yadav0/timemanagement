import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: settingsView
    header: PageHeader {
        title: i18n.tr("Settings")
           StyleHints {
            backgroundColor:  theme.name === "Ubuntu.Components.Themes.SuruDark" ? "black" : "#1c355e"
		foregroundColor: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "white"
	}
    }
    
    property var model
    signal settingsItemSelected(string itemName)
    
    ListView {
        anchors {
            fill: parent
            topMargin: settingsView.header.height
            margins: units.gu(2)
        }
        
        model: settingsView.model ? settingsView.model.settingsItems : null
        
        delegate: ListItem {
            height: layout.height + divider.height
            
            ListItemLayout {
                id: layout
                title.text: name
                subtitle.text: description
                
                ProgressionSlot {}
            }
            
            onClicked: {
                settingsItemSelected(name)
            }
        }
    }
    
    // Bottom footer with app info
    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: units.gu(5)
        color: theme.palette.normal.background
        
        Label {
            anchors.centerIn: parent
            text: i18n.tr("Time Management App v1.0")
            fontSize: "small"
            color: theme.palette.normal.backgroundTertiaryText
        }
    }
}
