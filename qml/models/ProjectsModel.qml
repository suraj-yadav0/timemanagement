import QtQuick 2.9

QtObject {
    id: projectsModel
    
    property ListModel projects: ListModel {
        ListElement { 
            name: "Website Redesign"
            client: "ABC Company"
            deadline: "Dec 15, 2023"
            status: "In Progress"
            progress: "45"
            priority: "High"
        }
        ListElement { 
            name: "Mobile App Development"
            client: "XYZ Corp"
            deadline: "Jan 30, 2024"
            status: "Not Started"
            progress: "30"
            priority: "Medium"
        }
        ListElement { 
            name: "Marketing Campaign"
            client: "123 Industries"
            deadline: "Nov 1, 2023"
            status: "In Progress"
            progress: "90"
            priority: "High"
        }
    }
    
    function addProject(projectData) {
        projects.append({
            "name": projectData.name || "",
            "client": projectData.client || "",
            "deadline": projectData.deadline || "",
            "status": projectData.status || "",
            "progress": projectData.progress || "0",
            "priority": projectData.priority || "Medium"
        })
    }
    
    function updateProject(index, projectData) {
        if (index >= 0 && index < projects.count) {
            projects.setProperty(index, "name", projectData.name)
            projects.setProperty(index, "client", projectData.client)
            projects.setProperty(index, "deadline", projectData.deadline)
            projects.setProperty(index, "status", projectData.status)
            projects.setProperty(index, "progress", projectData.progress)
            projects.setProperty(index, "priority", projectData.priority)
        }
    }
    
    function removeProject(index) {
        if (index >= 0 && index < projects.count) {
            projects.remove(index)
        }
    }
}
