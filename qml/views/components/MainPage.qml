import QtQuick 2.7
import Lomiri.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
// import "views/components"

Item {
    id: mainPageRoot
    anchors.fill: parent

    property bool menuOpen: false
    property bool isDesktop: width > 800

    //––– New menu model ––––––––––––––––––––––––––––––––––––––––––––––
    ListModel {
        id: menuModel
        ListElement { title: "Projects";   iconName: "folder";   source: "ProjectList.qml"   }
        ListElement { title: "Tasks";      iconName: "tasks";    source: "TasksPage.qml"     }
        ListElement { title: "TimeSheets"; iconName: "history";  source: "TimeSheetsPage.qml"}
        ListElement { title: "Calendar";   iconName: "calendar"; source: "CalendarPage.qml"  }
        ListElement { title: "Settings";   iconName: "settings"; source: "SettingsPage.qml"  }
    }
    //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

    // Desktop layout: SideMenu always visible, Page content to the right
    RowLayout {
        id: desktopLayout
        anchors.fill: parent
        visible: mainPageRoot.isDesktop

        SideMenu {
            id: sideMenuDesktop
            Layout.preferredWidth: units.gu(30)
            Layout.fillHeight: true
            permanent: true

            Column {
                anchors.fill: parent
                Repeater {
                    model: menuModel
                    delegate: Button {
                        text: model.title
                        icon.name: model.iconName
                        onClicked: stackViewDesktop.push( Qt.resolvedUrl(model.source) )
                    }
                }
            }
        }

        StackView {
            id: stackViewDesktop
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: Qt.resolvedUrl("ProjectList.qml")       // start on Projects
        }
    }

    // Mobile layout: SideMenu overlays content
    Item {
        id: mobileLayout
        anchors.fill: parent
        visible: !mainPageRoot.isDesktop

        StackView {
            id: stackViewMobile
            anchors.fill: parent
            initialItem: Qt.resolvedUrl("ProjectList.qml")
        }

        SideMenu {
            id: sideMenuMobile
            anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
            width: units.gu(30)
            permanent: false
            visible: mainPageRoot.menuOpen
            z: 2

            Column {
                anchors.fill: parent
                Repeater {
                    model: menuModel
                    delegate: Button {
                        text: model.title
                        icon.name: model.iconName
                        onClicked: {
                            stackViewMobile.push( Qt.resolvedUrl(model.source) )
                            mainPageRoot.menuOpen = false
                        }
                    }
                }
            }
        }

        // Overlay for closing menu in mobile mode
        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: 0.3
            visible: mainPageRoot.menuOpen
            z: 1
            MouseArea {
                anchors.fill: parent
                onClicked: mainPageRoot.menuOpen = false
            }
        }
    }
}
