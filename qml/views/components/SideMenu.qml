import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0



Rectangle {
        id: sideMenu
        width: units.gu(30)
        height: parent.height
        color: theme.palette.normal.background
        visible: root.menuOpen
        z: 2

        Column {
            anchors.fill: parent
            spacing: units.gu(1)
            padding: units.gu(5)

            Label {
                text: i18n.tr("Menu")
                font.pixelSize : 20
                color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Seprator {}

            CustomButton {
                text: i18n.tr("Tasks")
                onClicked: root.menuOpen = false
            }

            Seprator {}

            CustomButton{
                text: i18n.tr("Calendar")
                name : "calendar"
                onClicked: root.menuOpen = false
            }


            Seprator {}

            CustomButton{
                text: i18n.tr("Projects")
                name : "note"
                onClicked: root.menuOpen = false
            }

             Seprator {}

            CustomButton{
                text: i18n.tr("TimeSheets")
                name : "appointment"
                onClicked: root.menuOpen = false
            }

            Seprator {}

            CustomButton{
                text: i18n.tr("Settings")
                name : "settings"
                onClicked: root.menuOpen = false
            }


            Seprator {}

            CustomButton{
                text: i18n.tr("About")
                name : "info"
                onClicked: root.menuOpen = false
            }

            Seprator{}
            
        }
    }

    