import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: notificationSettingsView
    header: PageHeader {
        title: i18n.tr("Notification Settings")
    }
    
    property var model: pageStack && pageStack.mainApp ? pageStack.mainApp.settingsModel : null
    
    Column {
        anchors {
            fill: parent
            topMargin: notificationSettingsView.header.height
            margins: units.gu(2)
        }
        spacing: units.gu(2)
        
        // Master toggle
        ListItem {
            height: masterLayout.height + divider.height
            
            ListItemLayout {
                id: masterLayout
                title.text: i18n.tr("Enable Notifications")
                subtitle.text: i18n.tr("Turn on/off all notifications")
                
                Switch {
                    id: pushNotificationsSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: notificationSettingsView.model ? notificationSettingsView.model.pushNotifications : false
                    onCheckedChanged: {
                        if (notificationSettingsView.model) {
                            notificationSettingsView.model.updateNotificationSetting("pushNotifications", checked)
                        }
                    }
                }
            }
        }
        
        // Sound toggle
        ListItem {
            height: soundLayout.height + divider.height
            enabled: pushNotificationsSwitch.checked
            opacity: enabled ? 1.0 : 0.5
            
            ListItemLayout {
                id: soundLayout
                title.text: i18n.tr("Sound")
                subtitle.text: i18n.tr("Play sound with notifications")
                
                Switch {
                    id: soundSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: notificationSettingsView.model ? notificationSettingsView.model.soundEnabled : false
                    onCheckedChanged: {
                        if (notificationSettingsView.model) {
                            notificationSettingsView.model.updateNotificationSetting("soundEnabled", checked)
                        }
                    }
                }
            }
        }
        
        // Vibration toggle
        ListItem {
            height: vibrationLayout.height + divider.height
            enabled: pushNotificationsSwitch.checked
            opacity: enabled ? 1.0 : 0.5
            
            ListItemLayout {
                id: vibrationLayout
                title.text: i18n.tr("Vibration")
                subtitle.text: i18n.tr("Vibrate with notifications")
                
                Switch {
                    id: vibrationSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: notificationSettingsView.model ? notificationSettingsView.model.vibrationEnabled : false
                    onCheckedChanged: {
                        if (notificationSettingsView.model) {
                            notificationSettingsView.model.updateNotificationSetting("vibrationEnabled", checked)
                        }
                    }
                }
            }
        }
        
        // Notification types section
        Label {
            text: i18n.tr("Notification Types")
            fontSize: "large"
            font.bold: true
           // topPadding: units.gu(2)
            enabled: pushNotificationsSwitch.checked
            opacity: enabled ? 1.0 : 0.5
        }
        
        // Task reminders
        ListItem {
            height: taskLayout.height + divider.height
            enabled: pushNotificationsSwitch.checked
            opacity: enabled ? 1.0 : 0.5
            
            ListItemLayout {
                id: taskLayout
                title.text: i18n.tr("Task Reminders")
                
                Switch {
                    id: taskSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: true
                }
            }
            
            onClicked: taskSwitch.checked = !taskSwitch.checked
        }
        
        // Calendar events
        ListItem {
            height: calendarLayout.height + divider.height
            enabled: pushNotificationsSwitch.checked
            opacity: enabled ? 1.0 : 0.5
            
            ListItemLayout {
                id: calendarLayout
                title.text: i18n.tr("Calendar Events")
                
                Switch {
                    id: calendarSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: true
                }
            }
            
            onClicked: calendarSwitch.checked = !calendarSwitch.checked
        }
        
        // Project deadlines
        ListItem {
            height: deadlineLayout.height + divider.height
            enabled: pushNotificationsSwitch.checked
            opacity: enabled ? 1.0 : 0.5
            
            ListItemLayout {
                id: deadlineLayout
                title.text: i18n.tr("Project Deadlines")
                
                Switch {
                    id: deadlineSwitch
                    SlotsLayout.position: SlotsLayout.Trailing
                    checked: true
                }
            }
            
            onClicked: deadlineSwitch.checked = !deadlineSwitch.checked
        }
        
        // Timing settings
        Label {
            text: i18n.tr("Daily Reminder Time")
            fontSize: "medium"
           
           
           // topPadding: units.gu(2)
            enabled: pushNotificationsSwitch.checked
            opacity: enabled ? 1.0 : 0.5
        }
        
        Button {
            width: parent.width
            text: "9:00 AM"
            enabled: pushNotificationsSwitch.checked
            opacity: enabled ? 1.0 : 0.5
            onClicked: {
                // In a real app, this would show a time picker
            }
        }
    }
}
