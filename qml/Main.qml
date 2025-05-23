import QtQuick 2.9
import Lomiri.Components 1.3

MainView {
    id: root
    applicationName: "timemanagement.app"
    automaticOrientation: true
    
    width: units.gu(60)
    height: units.gu(75)
    
    AdaptivePageLayout {
        id: pageLayout
        anchors.fill: parent
        primaryPage: mainPage
        
        // LEVEL 1: Main Menu Page
        Page {
            id: mainPage
            
            header: PageHeader {
                title: i18n.tr('Time Management')
            }
            
            ListView {
                anchors.fill: parent
                
                model: ListModel {
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
                
                delegate: ListItem {
                    height: units.gu(8)
                    
                    ListItemLayout {
                        title.text: model.name
                        subtitle.text: model.description
                        
                        Icon {
                            name: model.icon
                            width: units.gu(3)
                            height: units.gu(3)
                            SlotsLayout.position: SlotsLayout.Leading
                        }
                        
                        Icon {
                            name: "go-next"
                            width: units.gu(2)
                            height: units.gu(2)
                            SlotsLayout.position: SlotsLayout.Trailing
                        }
                    }
                    
                    onClicked: {
                        // Navigate to level 2 pages
                        if (model.name === "Projects") {
                            pageLayout.addPageToNextColumn(mainPage, projectsPage)
                        } else if (model.name === "Time Sheet") {
                            pageLayout.addPageToNextColumn(mainPage, timeSheetPage)
                        } else if (model.name === "Calendar") {
                            pageLayout.addPageToNextColumn(mainPage, calendarPage)
                        } else if (model.name === "Tasks") {
                            pageLayout.addPageToNextColumn(mainPage, tasksPage)
                        } else if (model.name === "Settings") {
                            pageLayout.addPageToNextColumn(mainPage, settingsPage)
                        }
                    }
                }
            }
        }
        
        // LEVEL 2: Projects Page
        Page {
            id: projectsPage
            
            header: PageHeader {
                title: i18n.tr('Projects')
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "add"
                        text: i18n.tr('New Project')
                        onTriggered: {
                            pageLayout.addPageToNextColumn(projectsPage, newProjectPage)
                        }
                    }
                ]
            }
            
            ListView {
                anchors.fill: parent
                
                model: ListModel {
                    ListElement { 
                        name: "Website Redesign"
                        progress: "75%"
                        deadline: "Oct 15, 2023"
                        priority: "High"
                    }
                    ListElement { 
                        name: "Mobile App Development"
                        progress: "30%"
                        deadline: "Dec 1, 2023"
                        priority: "Medium"
                    }
                    ListElement { 
                        name: "Marketing Campaign"
                        progress: "10%"
                        deadline: "Nov 20, 2023"
                        priority: "Low"
                    }
                }
                
                delegate: ListItem {
                    height: units.gu(10)
                    
                    ListItemLayout {
                        title.text: model.name
                        subtitle.text: "Due: " + model.deadline
                        summary.text: "Priority: " + model.priority
                        
                        ProgressBar {
                            SlotsLayout.position: SlotsLayout.Trailing
                            minimumValue: 0
                            maximumValue: 100
                            value: parseInt(model.progress)
                            width: units.gu(10)
                        }
                    }
                    
                    onClicked: {
                        projectDetailPage.projectData = {
                            "name": model.name,
                            "progress": model.progress,
                            "deadline": model.deadline,
                            "priority": model.priority
                        }
                        pageLayout.addPageToNextColumn(projectsPage, projectDetailPage)
                    }
                }
            }
        }
        
        // LEVEL 2: Time Sheet Page
        Page {
            id: timeSheetPage
            
            header: PageHeader {
                title: i18n.tr('Time Sheet')
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "add"
                        text: i18n.tr('Add Time Entry')
                        onTriggered: {
                            pageLayout.addPageToNextColumn(timeSheetPage, addTimeEntryPage)
                        }
                    }
                ]
            }
            
            ListView {
                anchors.fill: parent
                
                model: ListModel {
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
                
                section.property: "date"
                section.delegate: Item {
                    width: parent.width
                    height: units.gu(6)
                    
                    Rectangle {
                        anchors.fill: parent
                        color: theme.palette.normal.background
                    }
                    
                    Label {
                        text: section
                        fontSize: "medium"
                        anchors {
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                            margins: units.gu(2)
                        }
                        font.bold: true
                    }
                }
                
                delegate: ListItem {
                    height: units.gu(7)
                    
                    ListItemLayout {
                        title.text: model.project
                        subtitle.text: model.task
                        
                        Label {
                            text: model.hours
                            fontSize: "medium"
                            SlotsLayout.position: SlotsLayout.Trailing
                        }
                    }
                    
                    onClicked: {
                        timeEntryDetailPage.entryData = {
                            "date": model.date,
                            "project": model.project,
                            "hours": model.hours,
                            "task": model.task
                        }
                        pageLayout.addPageToNextColumn(timeSheetPage, timeEntryDetailPage)
                    }
                }
            }
        }
        
        // LEVEL 2: Calendar Page
        Page {
            id: calendarPage
            
            header: PageHeader {
                title: i18n.tr('Calendar')
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "add"
                        text: i18n.tr('New Event')
                        onTriggered: {
                            pageLayout.addPageToNextColumn(calendarPage, addEventPage)
                        }
                    }
                ]
            }
            
            Column {
                anchors.fill: parent
                spacing: units.gu(1)
                
                // Month header
                Rectangle {
                    width: parent.width
                    height: units.gu(8)
                    color: theme.palette.normal.background
                    
                    Row {
                        anchors.centerIn: parent
                        spacing: units.gu(2)
                        
                        Icon {
                            name: "go-previous"
                            width: units.gu(2)
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        
                        Label {
                            text: "October 2023"
                            fontSize: "large"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        
                        Icon {
                            name: "go-next"
                            width: units.gu(2)
                            height: width
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
                
                // Day names row
                Row {
                    width: parent.width
                    height: units.gu(5)
                    
                    Repeater {
                        model: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                        
                        Label {
                            width: parent.width / 7
                            height: parent.height
                            text: modelData
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                        }
                    }
                }
                
                // Calendar grid
                Grid {
                    width: parent.width
                    columns: 7
                    
                    Repeater {
                        model: 35 // 5 weeks
                        
                        Rectangle {
                            width: parent.width / 7
                            height: units.gu(8)
                            color: ((index + 1) >= 1 && (index + 1) <= 31) ? "transparent" : theme.palette.normal.background
                            border.width: 1
                            border.color: theme.palette.normal.base
                            
                            Column {
                                anchors.fill: parent
                                anchors.margins: units.gu(0.5)
                                
                                Label {
                                    text: (index + 1) > 31 ? "" : (index + 1).toString()
                                    font.bold: (index + 1) === 9 || (index + 1) === 10 || (index + 1) === 11 // Current dates
                                    color: (index + 1) === 9 || (index + 1) === 10 || (index + 1) === 11 ? theme.palette.normal.positive : theme.palette.normal.backgroundText
                                }
                                
                                // Event indicators
                                Rectangle {
                                    visible: (index + 1) === 15 || (index + 1) === 9 || (index + 1) === 20
                                    width: parent.width * 0.8
                                    height: units.gu(1)
                                    radius: height / 2
                                    color: theme.palette.normal.positive
                                }
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if ((index + 1) >= 1 && (index + 1) <= 31) {
                                        dayViewPage.date = "October " + (index + 1) + ", 2023"
                                        pageLayout.addPageToNextColumn(calendarPage, dayViewPage)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // LEVEL 2: Tasks Page
        Page {
            id: tasksPage
            
            header: PageHeader {
                title: i18n.tr('Tasks')
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "add"
                        text: i18n.tr('New Task')
                        onTriggered: {
                            pageLayout.addPageToNextColumn(tasksPage, addTaskPage)
                        }
                    }
                ]
            }
            
            ListView {
                anchors.fill: parent
                
                model: ListModel {
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
                
                delegate: ListItem {
                    height: units.gu(8)
                    
                    ListItemLayout {
                        title.text: model.name
                        subtitle.text: model.project
                        summary.text: "Due: " + model.dueDate
                        
                        CheckBox {
                            checked: model.completed
                            SlotsLayout.position: SlotsLayout.Leading
                            onClicked: model.completed = checked
                        }
                    }
                    
                    onClicked: {
                        taskDetailPage.taskData = {
                            "name": model.name,
                            "project": model.project,
                            "dueDate": model.dueDate,
                            "completed": model.completed
                        }
                        pageLayout.addPageToNextColumn(tasksPage, taskDetailPage)
                    }
                }
            }
        }
        
        // LEVEL 2: Settings Page
        Page {
            id: settingsPage
            
            header: PageHeader {
                title: i18n.tr('Settings')
            }
            
            ListView {
                anchors.fill: parent
                
                model: ListModel {
                    ListElement { name: "General"; description: "General app settings" }
                    ListElement { name: "Privacy"; description: "Privacy and security" }
                    ListElement { name: "Notifications"; description: "Notification preferences" }
                    ListElement { name: "About"; description: "App information" }
                }
                
                delegate: ListItem {
                    height: units.gu(7)
                    
                    ListItemLayout {
                        title.text: model.name
                        subtitle.text: model.description
                        
                        Icon {
                            name: "go-next"
                            width: units.gu(2)
                            height: units.gu(2)
                            SlotsLayout.position: SlotsLayout.Trailing
                        }
                    }
                    
                    onClicked: {
                        // Navigate to level 3 - settings detail pages
                        if (model.name === "General") {
                            pageLayout.addPageToNextColumn(settingsPage, generalSettingsPage)
                        } else if (model.name === "Privacy") {
                            pageLayout.addPageToNextColumn(settingsPage, privacySettingsPage)
                        } else if (model.name === "Notifications") {
                            pageLayout.addPageToNextColumn(settingsPage, notificationSettingsPage)
                        } else if (model.name === "About") {
                            pageLayout.addPageToNextColumn(settingsPage, aboutPage)
                        }
                    }
                }
            }
        }
        
        // LEVEL 3: Project Detail Page
        Page {
            id: projectDetailPage
            
            property var projectData: ({})
            
            header: PageHeader {
                title: projectDetailPage.projectData.name || ""
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "edit"
                        text: i18n.tr('Edit')
                        onTriggered: {
                            console.log("Edit project")
                        }
                    }
                ]
            }
            
            ScrollView {
                anchors.fill: parent
                
                Column {
                    width: parent.width
                    spacing: units.gu(2)
                    anchors.margins: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Progress')
                        font.bold: true
                    }
                    
                    ProgressBar {
                        width: parent.width
                        minimumValue: 0
                        maximumValue: 100
                        value: parseInt(projectDetailPage.projectData.progress)
                    }
                    
                    Row {
                        width: parent.width
                        spacing: units.gu(2)
                        
                        Label {
                            text: i18n.tr('Deadline:')
                            font.bold: true
                        }
                        
                        Label {
                            text: projectDetailPage.projectData.deadline || ""
                        }
                    }
                    
                    Row {
                        width: parent.width
                        spacing: units.gu(2)
                        
                        Label {
                            text: i18n.tr('Priority:')
                            font.bold: true
                        }
                        
                        Label {
                            text: projectDetailPage.projectData.priority || ""
                        }
                    }
                    
                    Rectangle {
                        width: parent.width
                        height: 1
                        color: theme.palette.normal.base
                    }
                    
                    Label {
                        text: i18n.tr('Project Tasks')
                        font.bold: true
                        fontSize: "large"
                    }
                    
                    // Tasks related to this project
                    ListView {
                        width: parent.width
                        height: units.gu(20)
                        clip: true
                        
                        model: ListModel {
                            ListElement { 
                                name: "Design homepage mockup"
                                status: "In Progress"
                            }
                            ListElement { 
                                name: "Implement responsive design"
                                status: "Not Started"
                            }
                            ListElement { 
                                name: "Review design with client"
                                status: "Not Started"
                            }
                        }
                        
                        delegate: ListItem {
                            ListItemLayout {
                                title.text: model.name
                                subtitle.text: model.status
                            }
                        }
                    }
                }
            }
        }
        
        // LEVEL 3: Add Time Entry Page
        Page {
            id: addTimeEntryPage
            
            header: PageHeader {
                title: i18n.tr('Add Time Entry')
                
                leadingActionBar.actions: [
                    Action {
                        iconName: "close"
                        text: i18n.tr('Cancel')
                        onTriggered: {
                            pageLayout.removePages(addTimeEntryPage)
                        }
                    }
                ]
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "save"
                        text: i18n.tr('Save')
                        onTriggered: {
                            console.log("Saving time entry...")
                            pageLayout.removePages(addTimeEntryPage)
                        }
                    }
                ]
            }
            
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: units.gu(2)
                }
                spacing: units.gu(2)
                
                Label {
                    text: i18n.tr('Date')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Select Date')
                    text: "October 12, 2023"
                }
                
                Label {
                    text: i18n.tr('Project')
                }
                
                OptionSelector {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    model: ["Website Redesign", "Mobile App Development", "Marketing Campaign"]
                    selectedIndex: 0
                }
                
                Label {
                    text: i18n.tr('Task')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Task Description')
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Column {
                        width: (parent.width - units.gu(2)) / 2
                        spacing: units.gu(1)
                        
                        Label {
                            text: i18n.tr('Start Time')
                        }
                        
                        TextField {
                            width: parent.width
                            placeholderText: i18n.tr('9:00 AM')
                        }
                    }
                    
                    Column {
                        width: (parent.width - units.gu(2)) / 2
                        spacing: units.gu(1)
                        
                        Label {
                            text: i18n.tr('End Time')
                        }
                        
                        TextField {
                            width: parent.width
                            placeholderText: i18n.tr('5:00 PM')
                        }
                    }
                }
                
                Label {
                    text: i18n.tr('Notes')
                }
                
                TextArea {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    height: units.gu(10)
                    placeholderText: i18n.tr('Additional notes (optional)')
                }
            }
        }
        
        // LEVEL 3: Time Entry Detail Page
        Page {
            id: timeEntryDetailPage
            
            property var entryData: ({})
            
            header: PageHeader {
                title: i18n.tr('Time Entry Details')
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "edit"
                        text: i18n.tr('Edit')
                        onTriggered: {
                            console.log("Edit time entry")
                        }
                    }
                ]
            }
            
            Column {
                anchors {
                    fill: parent
                    margins: units.gu(2)
                }
                spacing: units.gu(2)
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Date:')
                        font.bold: true
                    }
                    
                    Label {
                        text: timeEntryDetailPage.entryData.date || ""
                    }
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Project:')
                        font.bold: true
                    }
                    
                    Label {
                        text: timeEntryDetailPage.entryData.project || ""
                    }
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Task:')
                        font.bold: true
                    }
                    
                    Label {
                        text: timeEntryDetailPage.entryData.task || ""
                    }
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Hours:')
                        font.bold: true
                    }
                    
                    Label {
                        text: timeEntryDetailPage.entryData.hours || ""
                    }
                }
            }
        }
        
        // LEVEL 3: Add Task Page
        Page {
            id: addTaskPage
            
            header: PageHeader {
                title: i18n.tr('Add Task')
                
                leadingActionBar.actions: [
                    Action {
                        iconName: "close"
                        text: i18n.tr('Cancel')
                        onTriggered: {
                            pageLayout.removePages(addTaskPage)
                        }
                    }
                ]
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "save"
                        text: i18n.tr('Save')
                        onTriggered: {
                            console.log("Saving task...")
                            pageLayout.removePages(addTaskPage)
                        }
                    }
                ]
            }
            
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: units.gu(2)
                }
                spacing: units.gu(2)
                
                Label {
                    text: i18n.tr('Task Name')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Enter task name')
                }
                
                Label {
                    text: i18n.tr('Project')
                }
                
                OptionSelector {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    model: ["Website Redesign", "Mobile App Development", "Marketing Campaign"]
                    selectedIndex: 0
                }
                
                Label {
                    text: i18n.tr('Due Date')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Select due date')
                }
                
                Label {
                    text: i18n.tr('Priority')
                }
                
                OptionSelector {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    model: ["High", "Medium", "Low"]
                    selectedIndex: 1
                }
                
                Label {
                    text: i18n.tr('Description')
                }
                
                TextArea {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    height: units.gu(10)
                    placeholderText: i18n.tr('Task description')
                }
            }
        }
        
        // LEVEL 3: Task Detail Page
        Page {
            id: taskDetailPage
            
            property var taskData: ({})
            
            header: PageHeader {
                title: i18n.tr('Task Details')
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "edit"
                        text: i18n.tr('Edit')
                        onTriggered: {
                            console.log("Edit task")
                        }
                    }
                ]
            }
            
            Column {
                anchors {
                    fill: parent
                    margins: units.gu(2)
                }
                spacing: units.gu(2)
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Task:')
                        font.bold: true
                    }
                    
                    Label {
                        text: taskDetailPage.taskData.name || ""
                    }
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Project:')
                        font.bold: true
                    }
                    
                    Label {
                        text: taskDetailPage.taskData.project || ""
                    }
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Due Date:')
                        font.bold: true
                    }
                    
                    Label {
                        text: taskDetailPage.taskData.dueDate || ""
                    }
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Label {
                        text: i18n.tr('Status:')
                        font.bold: true
                    }
                    
                    Label {
                        text: taskDetailPage.taskData.completed ? i18n.tr("Completed") : i18n.tr("In Progress")
                    }
                }
            }
        }
        
        // LEVEL 3: Day View Page
        Page {
            id: dayViewPage
            
            property string date: ""
            
            header: PageHeader {
                title: dayViewPage.date
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "add"
                        text: i18n.tr('Add Event')
                        onTriggered: {
                            pageLayout.addPageToNextColumn(dayViewPage, addEventPage)
                        }
                    }
                ]
            }
            
            ListView {
                anchors.fill: parent
                
                model: ListModel {
                    ListElement { 
                        time: "9:00 AM" 
                        title: "Team Meeting"
                        location: "Conference Room A"
                    }
                    ListElement { 
                        time: "11:30 AM" 
                        title: "Client Call"
                        location: "Zoom"
                    }
                    ListElement { 
                        time: "2:00 PM" 
                        title: "Design Review"
                        location: "Office 302"
                    }
                    ListElement { 
                        time: "4:30 PM" 
                        title: "Project Planning"
                        location: "Main Meeting Room"
                    }
                }
                
                delegate: ListItem {
                    height: units.gu(8)
                    
                    ListItemLayout {
                        title.text: model.title
                        subtitle.text: model.location
                        
                        Label {
                            text: model.time
                            fontSize: "small"
                            SlotsLayout.position: SlotsLayout.Leading
                        }
                    }
                }
            }
        }
        
        // LEVEL 3: Add Event Page
        Page {
            id: addEventPage
            
            header: PageHeader {
                title: i18n.tr('Add Event')
                
                leadingActionBar.actions: [
                    Action {
                        iconName: "close"
                        text: i18n.tr('Cancel')
                        onTriggered: {
                            pageLayout.removePages(addEventPage)
                        }
                    }
                ]
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "save"
                        text: i18n.tr('Save')
                        onTriggered: {
                            console.log("Saving event...")
                            pageLayout.removePages(addEventPage)
                        }
                    }
                ]
            }
            
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: units.gu(2)
                }
                spacing: units.gu(2)
                
                Label {
                    text: i18n.tr('Event Title')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Enter event title')
                }
                
                Label {
                    text: i18n.tr('Date')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Select date')
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(2)
                    
                    Column {
                        width: (parent.width - units.gu(2)) / 2
                        spacing: units.gu(1)
                        
                        Label {
                            text: i18n.tr('Start Time')
                        }
                        
                        TextField {
                            width: parent.width
                            placeholderText: i18n.tr('9:00 AM')
                        }
                    }
                    
                    Column {
                        width: (parent.width - units.gu(2)) / 2
                        spacing: units.gu(1)
                        
                        Label {
                            text: i18n.tr('End Time')
                        }
                        
                        TextField {
                            width: parent.width
                            placeholderText: i18n.tr('10:00 AM')
                        }
                    }
                }
                
                Label {
                    text: i18n.tr('Location')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Enter location')
                }
                
                Label {
                    text: i18n.tr('Description')
                }
                
                TextArea {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    height: units.gu(10)
                    placeholderText: i18n.tr('Event description')
                }
            }
        }
        
        // LEVEL 3: New Project Page
        Page {
            id: newProjectPage
            
            header: PageHeader {
                title: i18n.tr('New Project')
                
                leadingActionBar.actions: [
                    Action {
                        iconName: "close"
                        text: i18n.tr('Cancel')
                        onTriggered: {
                            pageLayout.removePages(newProjectPage)
                        }
                    }
                ]
                
                trailingActionBar.actions: [
                    Action {
                        iconName: "save"
                        text: i18n.tr('Save')
                        onTriggered: {
                            console.log("Saving project...")
                            pageLayout.removePages(newProjectPage)
                        }
                    }
                ]
            }
            
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: units.gu(2)
                }
                spacing: units.gu(2)
                
                Label {
                    text: i18n.tr('Project Name')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Enter project name')
                }
                
                Label {
                    text: i18n.tr('Deadline')
                }
                
                TextField {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    placeholderText: i18n.tr('Select deadline')
                }
                
                Label {
                    text: i18n.tr('Priority')
                }
                
                OptionSelector {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    model: ["High", "Medium", "Low"]
                    selectedIndex: 1
                }
                
                Label {
                    text: i18n.tr('Description')
                }
                
                TextArea {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    height: units.gu(10)
                    placeholderText: i18n.tr('Project description')
                }
            }
        }
        
        // LEVEL 3: Settings Detail Pages 
        // ...existing code...
    }
}