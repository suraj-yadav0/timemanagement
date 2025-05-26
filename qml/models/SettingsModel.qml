import QtQuick 2.9

QtObject {
    id: settingsModel

    property ListModel settingsItems: ListModel {
        ListElement {
            name: "General"
            description: "General app settings"
        }
         ListElement {
            name: "Sync"
            description: "Sync Data on with cloud"
        }
        ListElement {
            name: "Privacy"
            description: "Privacy and security"
        }
        ListElement {
            name: "Notifications"
            description: "Notification preferences"
        }
        ListElement {
            name: "About"
            description: "App information"
        }
    }

    // General Settings
    property bool darkTheme: false
    property string language: "English"
    property bool autoSave: true

    // Privacy Settings
    property bool analytics: false
    property bool crashReports: true

    // Notification Settings
    property bool pushNotifications: true
    property bool soundEnabled: true
    property bool vibrationEnabled: false

    function updateGeneralSetting(key, value) {
        switch (key) {
        case "darkTheme":
            darkTheme = value;
            break;
        case "language":
            language = value;
            break;
        case "autoSave":
            autoSave = value;
            break;
        }
    }

    function updatePrivacySetting(key, value) {
        switch (key) {
        case "analytics":
            analytics = value;
            break;
        case "crashReports":
            crashReports = value;
            break;
        }
    }

    function updateNotificationSetting(key, value) {
        switch (key) {
        case "pushNotifications":
            pushNotifications = value;
            break;
        case "soundEnabled":
            soundEnabled = value;
            break;
        case "vibrationEnabled":
            vibrationEnabled = value;
            break;
        }
    }
}
