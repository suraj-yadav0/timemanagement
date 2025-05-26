import QtQuick 2.9

ListModel {
    id: menuModel
    
    ListElement { 
        name: "Projects" 
        description: "Manage your projects"
        icon: "folder"
    }
    ListElement { 
        name: "Time Sheet" 
        description: "Track your work hours"
        icon: "clock"
    }
    ListElement { 
        name: "Calendar" 
        description: "View your schedule"
        icon: "calendar"
    }
    ListElement { 
        name: "Tasks" 
        description: "Manage your to-do list"
        icon: "task"
    }
    ListElement { 
        name: "Settings" 
        description: "Application settings"
        icon: "settings"
    }
}