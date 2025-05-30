import QtQuick 2.9

QtObject {
    id: menuModel
    
    property ListModel menuItems: ListModel {
        ListElement { 
            name: "Projects"
            description: "Manage your projects" 
            icon: "folder-symbolic"
        }
        ListElement { 
            name: "Time Sheet" 
            description: "Track your time"
            icon: "clock"
        }
        ListElement { 
            name: "Calendar" 
            description: "Schedule events"
            icon: "calendar"
        }
        ListElement { 
            name: "Tasks" 
            description: "Manage your tasks"
            icon: "tick"
        }
        ListElement { 
            name: "Activities" 
            description: "Plan your day to day activities"
            icon: "empty-symbolic"
        }
        ListElement { 
            name: "Settings" 
            description: "Application settings"
            icon: "settings"
        }
    }
    
    // Debug function to check if model is working
    function getItemCount() {
        return menuItems.count
    }
}