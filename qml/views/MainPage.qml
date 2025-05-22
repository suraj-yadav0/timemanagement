import QtQuick 2.7
import Lomiri.Components 1.3
import Ubuntu.Components.Popups 1.3
import QtQuick.Layouts 1.3
import "components"

Item {
    id: mainPageRoot
    anchors.fill: parent

    property bool menuOpen: false
    property bool isDesktop: width > 800

    RowLayout {
        anchors.fill: parent

        SideMenu {
            id: sideMenu
            Layout.preferredWidth: units.gu(30)
            Layout.fillHeight: true
            permanent: mainPageRoot.isDesktop
            // Only allow overlay toggle in mobile mode
            visible: permanent || mainPageRoot.menuOpen
        }

        Page {
            id: mainPage
            Layout.fillWidth: true
            Layout.fillHeight: true
            z: 1

            header: PageHeader {
                id: header
                title: i18n.tr('Time Management App')

                leadingActionBar.actions: [
                    Action {
                        iconName: "navigation-menu"
                        onTriggered: {
                            if (!mainPageRoot.isDesktop)
                                mainPageRoot.menuOpen = !mainPageRoot.menuOpen
                        }
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

    // Overlay for closing menu in mobile mode
    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.3
        visible: menuOpen && !isDesktop
        z: 999
        MouseArea {
            anchors.fill: parent
            onClicked: mainPageRoot.menuOpen = false
        }
    }
}