import QtQuick 2.9

QtObject {
    id: tasksModel
    
    property ListModel tasks: ListModel {
        ListElement { 
            name: "Design homepage mockup"
            project: "Website Redesign"
            dueDate: "Oct 12, 2023"
            completed: false
        }
        ListElement { 
            name: "Fix login API bugs"
            project: "Mobile App Development"
            dueDate: "Oct 15, 2023"
            completed: false
        }
        ListElement { 
            name: "Create content calendar"
            project: "Marketing Campaign"
            dueDate: "Oct 18, 2023"
            completed: true
        }
        ListElement { 
            name: "Review design with client"
            project: "Website Redesign"
            dueDate: "Oct 20, 2023"
            completed: false
        }
    }
    
    function addTask(taskData) {
        tasks.append({
            "name": taskData.name || "",
            "project": taskData.project || "",
            "dueDate": taskData.dueDate || "",
            "completed": taskData.completed || false
        })
    }
    
    function updateTask(index, taskData) {
        if (index >= 0 && index < tasks.count) {
            tasks.setProperty(index, "name", taskData.name)
            tasks.setProperty(index, "project", taskData.project)
            tasks.setProperty(index, "dueDate", taskData.dueDate)
            tasks.setProperty(index, "completed", taskData.completed)
        }
    }
    
    function toggleTaskCompletion(index) {
        if (index >= 0 && index < tasks.count) {
            var current = tasks.get(index).completed
            tasks.setProperty(index, "completed", !current)
        }
    }
    
    function removeTask(index) {
        if (index >= 0 && index < tasks.count) {
            tasks.remove(index)
        }
    }
}