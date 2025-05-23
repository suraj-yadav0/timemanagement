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
            visible: true
            stackView: stackViewDesktop
        }

        StackView {
            id: stackViewDesktop
            Layout.fillWidth: true
            Layout.fillHeight: true
            initialItem: Page {
                id: mainPageDesktop
                header: PageHeader {
                    id: headerDesktop
                    title: i18n.tr('Time Management App')
                    leadingActionBar.actions: [
                        Action {
                            iconName: "navigation-menu"
                            visible: false // Hide in desktop mode
                            onTriggered: mainPageRoot.menuOpen = !mainPageRoot.menuOpen
                        }
                    ]
                    trailingActionBar.actions: [
                        Action {
                            iconName: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "weather-clear-night" : "weather-clear"
                            text: theme.name === "Ubuntu.Components.Themes.SuruDark" ? i18n.tr("Light Mode") : i18n.tr("Dark Mode")
                            onTriggered: {
                                Theme.name = theme.name === "Ubuntu.Components.Themes.SuruDark" ? "Ubuntu.Components.Themes.Ambiance" : "Ubuntu.Components.Themes.SuruDark";
                            }
                        }
                    ]
                }
                Label {
                    text: i18n.tr("Welcome to the Time Management App!")
                    anchors.centerIn: parent
                    font.pixelSize: units.gu(4)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
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
            initialItem: Page {
                id: mainPageMobile
                header: PageHeader {
                    id: headerMobile
                    title: i18n.tr('Time Management App')
                    leadingActionBar.actions: [
                        Action {
                            iconName: "navigation-menu"
                            onTriggered: mainPageRoot.menuOpen = !mainPageRoot.menuOpen
                        }
                    ]
                    trailingActionBar.actions: [
                        Action {
                            iconName: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "weather-clear-night" : "weather-clear"
                            text: theme.name === "Ubuntu.Components.Themes.SuruDark" ? i18n.tr("Light Mode") : i18n.tr("Dark Mode")
                            onTriggered: {
                                Theme.name = theme.name === "Ubuntu.Components.Themes.SuruDark" ? "Ubuntu.Components.Themes.Ambiance" : "Ubuntu.Components.Themes.SuruDark";
                            }
                        }
                    ]
                }
                Label {
                    text: i18n.tr("Welcome to the Time Management App!")
                    anchors.centerIn: parent
                    font.pixelSize: units.gu(2)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        SideMenu {
            id: sideMenuMobile
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: units.gu(30)
            permanent: false
            visible: mainPageRoot.menuOpen
            z: 2
            stackView: stackViewMobile
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
