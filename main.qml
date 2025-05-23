import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Layouts 1.3

MainView {
    id: mainView
    applicationName: "TimeManagementApp"
    width: units.gu(50); height: units.gu(80)

    property alias contentItem: adaptiveLayout

    AdaptivePageLayout {
        id: adaptiveLayout
        anchors.fill: parent
        property var selectedProject: null

        navigationModel: ListModel {
            ListElement { sectionTitle: "Projects";   pageUrl: "views/ProjectsListPage.qml"; icon: "applets" }
            ListElement { sectionTitle: "Tasks";      pageUrl: "views/TasksPage.qml";        icon: "tasks" }
            ListElement { sectionTitle: "TimeSheets"; pageUrl: "views/TimeSheetsPage.qml";  icon: "history" }
            ListElement { sectionTitle: "Calendar";   pageUrl: "views/CalendarPage.qml";    icon: "calendar" }
            ListElement { sectionTitle: "Settings";   pageUrl: "views/SettingsPage.qml";    icon: "settings" }
        }

        primaryPageSource: currentIndex >= 0
                            ? Qt.resolvedUrl(navigationModel.get(currentIndex).pageUrl)
                            : ""
        secondaryPageSource: selectedProject && navigationModel.get(currentIndex).sectionTitle === "Projects"
                             ? Qt.resolvedUrl("views/ProjectDetailsPage.qml") : ""
        secondaryPageProperties: { project: selectedProject }

        onCurrentIndexChanged: selectedProject = null
        Component.onCompleted: currentIndex = 0
    }
}
