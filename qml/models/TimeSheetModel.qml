import QtQuick 2.9

QtObject {
    id: timeSheetModel
    
    property ListModel entries: ListModel {
        ListElement { 
            date: "Monday, Oct 9"
            project: "Website Redesign"
            hours: "4.5 hrs"
            task: "UI Design"
        }
        ListElement { 
            date: "Monday, Oct 9"
            project: "Mobile App Development"
            hours: "3.0 hrs"
            task: "API Integration"
        }
        ListElement { 
            date: "Tuesday, Oct 10"
            project: "Website Redesign"
            hours: "6.0 hrs"
            task: "Frontend Development"
        }
        ListElement { 
            date: "Wednesday, Oct 11"
            project: "Marketing Campaign"
            hours: "2.5 hrs"
            task: "Content Creation"
        }
    }
    
    function addEntry(entryData) {
        entries.append({
            "date": entryData.date || "",
            "project": entryData.project || "",
            "hours": entryData.hours || "",
            "task": entryData.task || ""
        })
    }
    
    function updateEntry(index, entryData) {
        if (index >= 0 && index < entries.count) {
            entries.setProperty(index, "date", entryData.date)
            entries.setProperty(index, "project", entryData.project)
            entries.setProperty(index, "hours", entryData.hours)
            entries.setProperty(index, "task", entryData.task)
        }
    }
    
    function removeEntry(index) {
        if (index >= 0 && index < entries.count) {
            entries.remove(index)
        }
    }
}