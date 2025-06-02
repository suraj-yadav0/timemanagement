import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: newProjectForm
    header: PageHeader {
        title: i18n.tr("New Project")
        StyleHints {
            backgroundColor: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "black" : "#1c355e"
            foregroundColor: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "white"
        }
        trailingActionBar {
            actions: [
                Action {
                    iconName: "close"
                    text: i18n.tr("Cancel")
                    onTriggered: cancelRequested()
                }
            ]
        }
    }
    
    signal saveRequested(var projectData)
    signal cancelRequested()
    
    // Track which selector is expanded
    property bool budgetSelectorExpanded: false
    property bool statusSelectorExpanded: false
    
    Flickable {
        id: flickable
        anchors {
            fill: parent
            topMargin: newProjectForm.header.height + units.gu(2)
            leftMargin: units.gu(2)
            rightMargin: units.gu(2)
            bottomMargin: units.gu(2)
        }
        
        contentHeight: columnContent.height + units.gu(4)
        contentWidth: width
        clip: true
        
        Column {
            id: columnContent
            width: parent.width
            spacing: units.gu(2)
            
            // Project name
            Column {
                width: parent.width
                spacing: units.gu(0.5)
                
                Label {
                    text: i18n.tr("Project Name")
                    width: parent.width
                }
                TextField {
                    id: nameField
                    width: parent.width
                    height: units.gu(5)
                    placeholderText: i18n.tr("Enter project name")
                }
            }
            
            // Client
            Column {
                width: parent.width
                spacing: units.gu(0.5)
                
                Label {
                    text: i18n.tr("Client")
                    width: parent.width
                }
                TextField {
                    id: clientField
                    width: parent.width
                    height: units.gu(5)
                    placeholderText: i18n.tr("Enter client name")
                }
            }
            
            // Deadline
            Column {
                width: parent.width
                spacing: units.gu(0.5)
                
                Label {
                    text: i18n.tr("Deadline")
                    width: parent.width
                }
                Button {
                    id: deadlineButton
                    width: parent.width
                    height: units.gu(5)
                    text: i18n.tr("Select deadline")
                    property string selectedDeadline: ""
                    onClicked: {
                        // Close any open selectors first
                        budgetSelectorExpanded = false
                        statusSelectorExpanded = false
                        
                        // In a real app, this would show a date picker
                        selectedDeadline = "December 31, 2023"
                        text = selectedDeadline
                    }
                }
            }
            
            // Budget
            Column {
                width: parent.width
                spacing: units.gu(0.5)
                
                Label {
                    text: i18n.tr("Budget")
                    width: parent.width
                }
                
                Row {
                    width: parent.width
                    spacing: units.gu(1)
                    
                    TextField {
                        id: budgetField
                        width: parent.width * 0.6
                        height: units.gu(5)
                        placeholderText: "0.00"
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        validator: DoubleValidator {
                            bottom: 0.0
                            decimals: 2
                        }
                        onFocusChanged: {
                            if (focus) {
                                budgetSelectorExpanded = false
                                statusSelectorExpanded = false
                            }
                        }
                    }
                    
                    OptionSelector {
                        id: budgetTypeField
                        width: parent.width * 0.35
                        selectedIndex: 0
                        model: [i18n.tr("Fixed"), i18n.tr("Hourly")]
                        
                        onDelegateClicked: {
                            // Close other selectors when this one is interacted with
                            statusSelectorExpanded = false
                        }
                        
                        // Custom expansion handling
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                statusSelectorExpanded = false
                                budgetSelectorExpanded = !budgetSelectorExpanded
                                
                                if (budgetSelectorExpanded) {
                                    // Ensure this selector is visible when expanded
                                    var itemY = budgetTypeField.mapToItem(flickable.contentItem, 0, 0).y
                                    var targetY = itemY - units.gu(5)
                                    if (targetY > 0) {
                                        scrollAnimation.to = targetY
                                        scrollAnimation.start()
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Expanded options for budget type (manual implementation)
                Column {
                    width: parent.width * 0.35
                    anchors.right: parent.right
                    visible: budgetSelectorExpanded
                    spacing: 0
                    
                    Repeater {
                        model: budgetTypeField.model
                        
                        Rectangle {
                            width: parent.width
                            height: units.gu(4)
                            color: budgetTypeMouseArea.pressed ? theme.palette.selected.background : 
                                   (index === budgetTypeField.selectedIndex ? theme.palette.highlighted.background : "transparent")
                            border.color: theme.palette.normal.base
                            border.width: units.dp(1)
                            
                            Label {
                                anchors.centerIn: parent
                                text: modelData
                                color: index === budgetTypeField.selectedIndex ? theme.palette.highlighted.backgroundText : theme.palette.normal.backgroundText
                            }
                            
                            MouseArea {
                                id: budgetTypeMouseArea
                                anchors.fill: parent
                                onClicked: {
                                    budgetTypeField.selectedIndex = index
                                    budgetSelectorExpanded = false
                                }
                            }
                        }
                    }
                }
            }
            
            // Status
            Column {
                width: parent.width
                spacing: units.gu(0.5)
                
                Label {
                    text: i18n.tr("Status")
                    width: parent.width
                }
                
                OptionSelector {
                    id: statusField
                    width: parent.width
                    selectedIndex: 0
                    model: [
                        i18n.tr("Not Started"),
                        i18n.tr("In Progress"),
                        i18n.tr("On Hold"),
                        i18n.tr("Completed")
                    ]
                    
                    onDelegateClicked: {
                        budgetSelectorExpanded = false
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            budgetSelectorExpanded = false
                            statusSelectorExpanded = !statusSelectorExpanded
                            
                            if (statusSelectorExpanded) {
                                var itemY = statusField.mapToItem(flickable.contentItem, 0, 0).y
                                var targetY = itemY - units.gu(5)
                                if (targetY > 0) {
                                    scrollAnimation.to = targetY
                                    scrollAnimation.start()
                                }
                            }
                        }
                    }
                }
                
                // Expanded options for status (manual implementation)
                Column {
                    width: parent.width
                    visible: statusSelectorExpanded
                    spacing: 0
                    
                    Repeater {
                        model: statusField.model
                        
                        Rectangle {
                            width: parent.width
                            height: units.gu(4)
                            color: statusMouseArea.pressed ? theme.palette.selected.background : 
                                   (index === statusField.selectedIndex ? theme.palette.highlighted.background : "transparent")
                            border.color: theme.palette.normal.base
                            border.width: units.dp(1)
                            
                            Label {
                                anchors.centerIn: parent
                                text: modelData
                                color: index === statusField.selectedIndex ? theme.palette.highlighted.backgroundText : theme.palette.normal.backgroundText
                            }
                            
                            MouseArea {
                                id: statusMouseArea
                                anchors.fill: parent
                                onClicked: {
                                    statusField.selectedIndex = index
                                    statusSelectorExpanded = false
                                }
                            }
                        }
                    }
                }
            }
            
            // Description
            Column {
                width: parent.width
                spacing: units.gu(0.5)
                
                Label {
                    text: i18n.tr("Description")
                    width: parent.width
                }
                TextArea {
                    id: descriptionField
                    width: parent.width
                    height: units.gu(12)
                    placeholderText: i18n.tr("Enter project description")
                    wrapMode: TextArea.Wrap
                    onFocusChanged: {
                        if (focus) {
                            budgetSelectorExpanded = false
                            statusSelectorExpanded = false
                        }
                    }
                }
            }
            
            // Team members
            Column {
                width: parent.width
                spacing: units.gu(0.5)
                
                Label {
                    text: i18n.tr("Team Members")
                    width: parent.width
                }
                TextField {
                    id: teamMembersField
                    width: parent.width
                    height: units.gu(5)
                    placeholderText: i18n.tr("Add team members (comma separated)")
                    onFocusChanged: {
                        if (focus) {
                            budgetSelectorExpanded = false
                            statusSelectorExpanded = false
                        }
                    }
                }
            }
            
            // Buttons section
            Column {
                width: parent.width
                spacing: units.gu(1)
                
                Button {
                    text: i18n.tr("Create Project")
                    color: UbuntuColors.green
                    width: parent.width
                    height: units.gu(6)
                    enabled: nameField.text.trim() !== ""
                    onClicked: {
                        // Close any expanded selectors
                        budgetSelectorExpanded = false
                        statusSelectorExpanded = false
                        
                        if (nameField.text.trim() === "") {
                            return
                        }
                        
                        saveRequested({
                            name: nameField.text,
                            client: clientField.text,
                            deadline: deadlineButton.selectedDeadline,
                            budget: budgetField.text,
                            budgetType: budgetTypeField.model[budgetTypeField.selectedIndex],
                            status: statusField.model[statusField.selectedIndex],
                            description: descriptionField.text,
                            teamMembers: teamMembersField.text
                        })
                    }
                }
                
                Button {
                    text: i18n.tr("Cancel")
                    width: parent.width
                    height: units.gu(6)
                    onClicked: {
                        cancelRequested()
                    }
                }
            }
        }
    }
    
    // Smooth scrolling animation
    NumberAnimation {
        id: scrollAnimation
        target: flickable
        property: "contentY"
        duration: 300
        easing.type: Easing.InOutQuad
    }
}