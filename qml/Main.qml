/*
 * Copyright (C) 2025  Suraj Yadav
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * timemanagement is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'timemanagement.surajyadav'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property bool menuOpen: false

    // Overlay to close menu when clicking outside
    Rectangle {
        id: menuOverlay
        visible: root.menuOpen
        z: 1
        color: "black"
        opacity: 0.3
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: root.menuOpen = false
        }
    }

    Rectangle {
        id: sideMenu
        width: units.gu(30)
        height: parent.height
        color: theme.palette.normal.background
        visible: root.menuOpen
        z: 2

        Column {
            anchors.fill: parent
            spacing: units.gu(2)
            padding: units.gu(2)

            Label {
                text: i18n.tr("Menu")
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: i18n.tr("Dashboard")
                onClicked: root.menuOpen = false
            }
            Button {
                text: i18n.tr("Tasks")
                onClicked: root.menuOpen = false
            }
            Button {
                text: i18n.tr("Calendar")
                onClicked: root.menuOpen = false
            }
            Button {
                text: i18n.tr("Pomodoro Timer")
                onClicked: root.menuOpen = false
            }
            Button {
                text: i18n.tr("Statistics")
                onClicked: root.menuOpen = false
            }
            Button {
                text: i18n.tr("Settings")
                onClicked: root.menuOpen = false
            }
            Button {
                text: i18n.tr("About")
                onClicked: root.menuOpen = false
            }
        }
    }

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
                iconName: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "weather-clear" : "weather-clear-night"
                text: theme.name === "Ubuntu.Components.Themes.SuruDark" ? i18n.tr("Light Mode") : i18n.tr("Dark Mode")
                onTriggered: {
                Theme.name = theme.name === "Ubuntu.Components.Themes.SuruDark" ? 
                        "Ubuntu.Components.Themes.Ambiance" : 
                        "Ubuntu.Components.Themes.SuruDark";
                }
            }
            ]
        }

        Label {
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            text: i18n.tr('Hello World!')

            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
        }
    }
}
