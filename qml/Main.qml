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

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Time Management App')

            leadingActionBar.actions: [
                Action {
                    iconName: "navigation-menu"
                    onTriggered: drawer.open()
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
