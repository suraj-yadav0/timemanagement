import QtQuick 2.9

QtObject {
    id: calendarModel
    
    property ListModel events: ListModel {
        ListElement { 
            time: "9:00 AM" 
            title: "Team Meeting"
            location: "Conference Room A"
            date: "October 9, 2023"
        }
        ListElement { 
            time: "11:30 AM" 
            title: "Client Call"
            location: "Zoom"
            date: "October 9, 2023"
        }
        ListElement { 
            time: "2:00 PM" 
            title: "Design Review"
            location: "Office 302"
            date: "October 9, 2023"
        }
        ListElement { 
            time: "4:30 PM" 
            title: "Project Planning"
            location: "Main Meeting Room"
            date: "October 9, 2023"
        }
    }
    
    property string currentMonth: "October 2023"
    
    function addEvent(eventData) {
        events.append({
            "time": eventData.time || "",
            "title": eventData.title || "",
            "location": eventData.location || "",
            "date": eventData.date || ""
        })
    }
    
    function getEventsForDate(date) {
        var filteredEvents = []
        for (var i = 0; i < events.count; i++) {
            var event = events.get(i)
            if (event.date === date) {
                filteredEvents.push(event)
            }
        }
        return filteredEvents
    }
    
    function updateEvent(index, eventData) {
        if (index >= 0 && index < events.count) {
            events.setProperty(index, "time", eventData.time)
            events.setProperty(index, "title", eventData.title)
            events.setProperty(index, "location", eventData.location)
            events.setProperty(index, "date", eventData.date)
        }
    }
    
    function removeEvent(index) {
        if (index >= 0 && index < events.count) {
            events.remove(index)
        }
    }
}
