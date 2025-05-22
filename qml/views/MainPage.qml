import QtQuick 2.7
import Lomiri.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Layouts 1.3
import "components"

Item {
    id: mainPageRoot
    anchors.fill: parent

    property bool menuOpen: true // default open in desktop
    property bool isDesktop: width > 800

    // Desktop layout: SideMenu can be toggled, Page content resizes accordingly
    RowLayout {
        id: desktopLayout
        anchors.fill: parent
        visible: mainPageRoot.isDesktop

        // Only show SideMenu if menuOpen is true
        SideMenu {
            id: sideMenuDesktop
            Layout.preferredWidth: units.gu(30)
            Layout.fillHeight: true
            permanent: mainPageRoot.isDesktop
            visible: permanent ||  mainPageRoot.menuOpen
        }

        Page {
            id: mainPageDesktop
            // Take full width if menu is closed, else fill remaining space
            Layout.fillWidth: true
            Layout.fillHeight: true
            z: 1

            header: PageHeader {
                id: headerDesktop
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
                            Theme.name = theme.name === "Ubuntu.Components.Themes.SuruDark"
                                ? "Ubuntu.Components.Themes.Ambiance"
                                : "Ubuntu.Components.Themes.SuruDark";
                        }
                    }
                ]
            }
            // ...main page content...
        }
    }

    // Mobile layout: SideMenu overlays content
    Item {
        id: mobileLayout
        anchors.fill: parent
        visible: !mainPageRoot.isDesktop

        Page {
            id: mainPageMobile
            anchors.fill: parent
            z: 1

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
                            Theme.name = theme.name === "Ubuntu.Components.Themes.SuruDark"
                                ? "Ubuntu.Components.Themes.Ambiance"
                                : "Ubuntu.Components.Themes.SuruDark";
                        }
                    }
                ]
            }
            // ...main page content...
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