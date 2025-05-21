import QtQuick 2.7
import Lomiri.Components 1.3
import Ubuntu.Components.Popups 1.3
import "components"

 Page {
        anchors.fill: parent
        z: 1

        header: PageHeader {
            id: header
            title: i18n.tr('Time Management App')

            leadingActionBar.actions: [
                Action {
                    iconName: "navigation-menu"
                    
                    onTriggered: root.menuOpen = true
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
    }