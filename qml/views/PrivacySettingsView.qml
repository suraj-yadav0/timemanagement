import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: privacySettingsView
    header: PageHeader {
        title: i18n.tr("Privacy Settings")
    }
    
    property var model: pageStack && pageStack.mainApp ? pageStack.mainApp.settingsModel : null
    
    Column {
        anchors {
            fill: parent
            topMargin: privacySettingsView.header.height
            margins: units.gu(2)
        }
        spacing: units.gu(2)
        
        // Analytics
        ListItem {
            height: analyticsLayout.height + divider.height
            
            ListItemLayout {
                id: analyticsLayout
                title.text: i18n.tr("Usage Analytics")
                subtitle.text: i18n.tr("Help improve the app by sending anonymous usage data")
                
                Switch {
                    id: analyticsSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: privacySettingsView.model ? privacySettingsView.model.analytics : false
                    onCheckedChanged: {
                        if (privacySettingsView.model) {
                            privacySettingsView.model.updatePrivacySetting("analytics", checked)
                        }
                    }
                }
            }
        }
        
        // Crash reports
        ListItem {
            height: crashLayout.height + divider.height
            
            ListItemLayout {
                id: crashLayout
                title.text: i18n.tr("Crash Reports")
                subtitle.text: i18n.tr("Send automatic crash reports to help fix bugs")
                
                Switch {
                    id: crashSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: privacySettingsView.model ? privacySettingsView.model.crashReports : false
                    onCheckedChanged: {
                        if (privacySettingsView.model) {
                            privacySettingsView.model.updatePrivacySetting("crashReports", checked)
                        }
                    }
                }
            }
        }
        
        // Data storage info section
        Label {
            text: i18n.tr("Data Storage")
            fontSize: "large"
            font.bold: true
            //topPadding: units.gu(2)
        }
        
        Label {
            width: parent.width
            text: i18n.tr("All your data is stored locally on your device and is not shared with any third parties unless you explicitly choose to enable analytics.")
            wrapMode: Text.WordWrap
            fontSize: "small"
        }
        
        // Clear data buttons
        Item { width: 1; height: units.gu(2) } // Spacer
        
        Row {
            width: parent.width
            spacing: units.gu(2)
            
            Button {
                width: (parent.width - parent.spacing) / 2
                text: i18n.tr("Clear Cache")
                onClicked: {
                    // Clear cache logic would go here
                }
            }
            
            Button {
                width: (parent.width - parent.spacing) / 2
                text: i18n.tr("Reset All Data")
                color: UbuntuColors.red
                onClicked: {
                    // Reset data logic would go here
                }
            }
        }
        
        // Privacy policy
        Item { width: 1; height: units.gu(2) } // Spacer
        
        Button {
            width: parent.width
            text: i18n.tr("View Privacy Policy")
            onClicked: {
                // Open privacy policy
            }
        }
    }
}
