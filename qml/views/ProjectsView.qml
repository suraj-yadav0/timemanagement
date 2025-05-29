import QtQuick 2.9
import QtQuick.Controls 2.5
import Lomiri.Components 1.3
import Ubuntu.Components.Styles 1.3

import "../models"
import "../components"

Page {
    id: projectsView

    property var model

    signal newProjectRequested
    signal projectSelected(var projectData)
    signal deleteProjectRequested(var projectData) // Add signal for delete
    signal editProjectRequested(var projectData)   // Add signal for edit

    header: PageHeader {

        // color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#1c355e" : "#fac34d"
        title: i18n.tr('Projects')

        trailingActionBar.actions: [
            Action {
                iconName: "add"
                text: i18n.tr('New Project')
                onTriggered: {
                    projectsView.newProjectRequested();
                }
            }
        ]
    }

    ListView {
        id: listView
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: parent.header.bottom
        }
        clip: true // Solves the Overlay Error of the ListView while Swiping

        model: projectsView.model ? projectsView.model.projects : null

        delegate: ListItem {
            height: units.gu(10)

            leadingActions: ListItemActions {
                actions: [
                    Action {
                        iconName: "edit"
                        text: i18n.tr("Edit")
                        onTriggered: {
                            projectsView.editProjectRequested({
                                "name": model.name,
                                "progress": model.progress,
                                "deadline": model.deadline,
                                "priority": model.priority
                            });
                        }
                    }
                ]
            }

            trailingActions: ListItemActions {
                actions: [
                    Action {
                        iconName: "delete"
                        text: i18n.tr("Delete")
                        onTriggered: {
                            projectsView.deleteProjectRequested({
                                "name": model.name,
                                "progress": model.progress,
                                "deadline": model.deadline,
                                "priority": model.priority
                            });
                        }
                    }
                ]
            }

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
                projectsView.projectSelected({
                    "name": model.name,
                    "progress": model.progress,
                    "deadline": model.deadline,
                    "priority": model.priority
                });
            }
        }
    }

    // Visible swipe-up indicator
    Rectangle {
        id: swipeIndicator
        width: units.gu(6)
        height: units.gu(0.7)
        radius: height / 2
        color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "#fac34d" : "#1c355e"
        opacity: 0.7
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: swipeUpArea.top
        anchors.bottomMargin: units.gu(0.5)
        z: 1000
    }

    // Add Projects swipe-up gesture area at the bottom
    MultiPointTouchArea {
        id: swipeUpArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: units.gu(6)
        minimumTouchPoints: 1
        maximumTouchPoints: 1

        property real startY: 0

        onPressed: {
            startY = touchPoints[0].y;
        }
        onReleased: {
            var endY = touchPoints[0].y;
            // Detect upward swipe (swipe up: startY > endY)
            if (startY - endY > units.gu(3)) {
                // threshold for swipe
                projectsView.newProjectRequested();
            }
        }
        z: 999 // Ensure it's above other content

        Rectangle {
            anchors.fill: parent
            color: "lightgray"
            opacity: 0.0// Make it invisible but still interactive
        }
    }
}
