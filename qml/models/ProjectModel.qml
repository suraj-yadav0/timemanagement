import QtQuick 2.9

QtObject {
    id: projectsModel
    
    property ListModel projects: ListModel {
        ListElement { 
            name: "Website Redesign"
            progress: "75"
            deadline: "Oct 15, 2023"
            priority: "High"
        }
        ListElement { 
            name: "Mobile App Development"
            progress: "30"
            deadline: "Dec 1, 2023"
            priority: "Medium"
        }
        ListElement { 
            name: "Marketing Campaign"
            progress: "10"
            deadline: "Nov 20, 2023"
            priority: "Low"
        }
    }
    
    function addProject(projectData) {
        projects.append({
            "name": projectData.name || "",
            "progress": projectData.progress || "0",
            "deadline": projectData.deadline || "",
            "priority": projectData.priority || "Medium"
        })
    }
    
    function updateProject(index, projectData) {
        if (index >= 0 && index < projects.count) {
            projects.setProperty(index, "name", projectData.name)
            projects.setProperty(index, "progress", projectData.progress)
            projects.setProperty(index, "deadline", projectData.deadline)
            projects.setProperty(index, "priority", projectData.priority)
        }
    }
    
    function removeProject(index) {
        if (index >= 0 && index < projects.count) {
            projects.remove(index)
        }
    }
}
