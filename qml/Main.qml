import QtQuick 2.9
import Lomiri.Components 1.3
import "models"
import "views"
import "forms"
import "components"

MainView {
    id: root
    applicationName: "timemanagement.app"
    automaticOrientation: true
    
    width: units.gu(60)
    height: units.gu(75)
    
    // Data Models
    MenuModel {
        id: menuModel
    }
    
    ProjectsModel {
        id: projectsModel
    }
    
    TimeSheetModel {
        id: timeSheetModel
    }
    
    TasksModel {
        id: tasksModel
    }
    
    SettingsModel {
        id: settingsModel
    }
    
    CalendarModel {
        id: calendarModel
    }
    
    AdaptivePageLayout {
        id: pageLayout
        anchors.fill: parent
        primaryPage: mainPage
        
        // LEVEL 1: Main Menu
        MainMenuView {
            id: mainPage
            model: menuModel
            onItemSelected: {
                switch(itemName) {
                    case "Projects":
                        pageLayout.addPageToNextColumn(mainPage, projectsPage)
                        break
                    case "Time Sheet":
                        pageLayout.addPageToNextColumn(mainPage, timeSheetPage)
                        break
                    case "Calendar":
                        pageLayout.addPageToNextColumn(mainPage, calendarPage)
                        break
                    case "Tasks":
                        pageLayout.addPageToNextColumn(mainPage, tasksPage)
                        break
                    case "Settings":
                        pageLayout.addPageToNextColumn(mainPage, settingsPage)
                        break
                }
            }
        }
        
        // LEVEL 2: Projects
        ProjectsView {
            id: projectsPage
            model: projectsModel
            onNewProjectRequested: {
                pageLayout.addPageToNextColumn(projectsPage, newProjectPage)
            }
            onProjectSelected: {
                projectDetailPage.projectData = projectData
                pageLayout.addPageToNextColumn(projectsPage, projectDetailPage)
            }
        }
        
        // LEVEL 2: Time Sheet
        TimeSheetView {
            id: timeSheetPage
            model: timeSheetModel
            onNewTimeEntryRequested: {
                pageLayout.addPageToNextColumn(timeSheetPage, addTimeEntryPage)
            }
            onTimeEntrySelected: {
                timeEntryDetailPage.entryData = entryData
                pageLayout.addPageToNextColumn(timeSheetPage, timeEntryDetailPage)
            }
        }
        
        // LEVEL 2: Calendar
        CalendarView {
            id: calendarPage
            model: calendarModel
            onNewEventRequested: {
                pageLayout.addPageToNextColumn(calendarPage, addEventPage)
            }
            onDateSelected: {
                dayViewPage.date = selectedDate
                pageLayout.addPageToNextColumn(calendarPage, dayViewPage)
            }
        }
        
        // LEVEL 2: Tasks
        TasksView {
            id: tasksPage
            model: tasksModel
            onNewTaskRequested: {
                pageLayout.addPageToNextColumn(tasksPage, addTaskPage)
            }
            onTaskSelected: {
                taskDetailPage.taskData = taskData
                pageLayout.addPageToNextColumn(tasksPage, taskDetailPage)
            }
        }
        
        // LEVEL 2: Settings
        SettingsView {
            id: settingsPage
            model: settingsModel
            onSettingsItemSelected: {
                switch(itemName) {
                    case "General":
                        pageLayout.addPageToNextColumn(settingsPage, generalSettingsPage)
                        break
                    case "Sync":
                        // Sync settings can be added later
                        console.warn("Sync settings not implemented yet")
                        pageLayout.addPageToNextColumn(settingsPage, generalSettingsPage)
                        break
                    case "Privacy":
                        pageLayout.addPageToNextColumn(settingsPage, privacySettingsPage)
                        break
                    case "Notifications":
                        pageLayout.addPageToNextColumn(settingsPage, notificationSettingsPage)
                        break
                    case "About":
                        pageLayout.addPageToNextColumn(settingsPage, aboutPage)
                        break
                }
            }
        }
        
        // LEVEL 3: Detail and Form Pages
        // ProjectDetailView {
        //     id: projectDetailPage
        // }
        
        // TimeEntryDetailView {
        //     id: timeEntryDetailPage
        // }
        
        // TaskDetailView {
        //     id: taskDetailPage
        // }
        
        // DayView {
        //     id: dayViewPage
        //     onNewEventRequested: {
        //         pageLayout.addPageToNextColumn(dayViewPage, addEventPage)
        //     }
        // }
        
        // Form Pages
        NewProjectForm {
            id: newProjectPage
            onSaveRequested: {
                projectsModel.addProject(projectData)
                pageLayout.removePages(newProjectPage)
            }
            onCancelRequested: {
                pageLayout.removePages(newProjectPage)
            }
        }
        
        AddTimeEntryForm {
            id: addTimeEntryPage
            onSaveRequested: {
                timeSheetModel.addEntry(entryData)
                pageLayout.removePages(addTimeEntryPage)
            }
            onCancelRequested: {
                pageLayout.removePages(addTimeEntryPage)
            }
        }
        
        AddTaskForm {
            id: addTaskPage
            onSaveRequested: {
                tasksModel.addTask(taskData)
                pageLayout.removePages(addTaskPage)
            }
            onCancelRequested: {
                pageLayout.removePages(addTaskPage)
            }
        }
        
        AddEventForm {
            id: addEventPage
            onSaveRequested: {
                calendarModel.addEvent(eventData)
                pageLayout.removePages(addEventPage)
            }
            onCancelRequested: {
                pageLayout.removePages(addEventPage)
            }
        }
        
        // Settings Detail Pages
        GeneralSettingsView {
            id: generalSettingsPage
        }
        
        PrivacySettingsView {
            id: privacySettingsPage
        }
        
        NotificationSettingsView {
            id: notificationSettingsPage
        }
        
        AboutView {
            id: aboutPage
        }
    }
    
    // Add debugging to check model initialization
    Component.onCompleted: {
        console.log("Main component loaded")
        console.log("Menu items: " + (menuModel ? menuModel.getItemCount() : "not available"))
    }
}
