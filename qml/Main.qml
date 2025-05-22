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
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import "views/components"
import "views"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'timemanagement.surajyadav'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property bool menuOpen: false

    Rectangle {
        id: menuOverlay
        visible: root.menuOpen
        z: 2

        opacity: 0.5
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: root.menuOpen = false
        }
    }

    SideMenu {
         stackView: pageStack  
                                                                                        
    }

    PageStack {
        id: pageStack
        Component.onCompleted: push(mainPage)

        MainPage {
            id: mainPage
        }
    }
}
