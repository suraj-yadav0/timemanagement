# Chapter 1

In this chapter we will be creating `UI` for our Time management app.

### Task 1

In the Page header section we will add Menu Button and Side Drawer that will act as Navigation For Us. After Clicking on the Menu Button a Side Drawer Will appear which will contain a list of different options Like Projects, Time sheets , calendar, settings etc.

We will be following a Model View architecture. So writing clean , reusable code will also be a priority.

1. Create a Views Directory inside the `qml` folder.
2. In the views folder create a file called `MainPage.qml` and create a folder called components.
3. In the components folder create 3 files named : `CustomButton.qml` , `Seprator.qml`, `SideMenu.qml`
4. Change Your `Main.qml` file code to this, be mindful about the `applicationName` : 

```jsx
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
            onClicked : root.menuOpen = false

            }

           
        }

    SideMenu{}

    PageStack {
        id: pageStack
        Component.onCompleted: push(mainPage)
        
        MainPage {
            id: mainPage
           
            
          
        }
        
    
    }
}

```

In this we are simply calling the `SideMenu` and `MainPage.qml` using `PageStack`. So `PageStack` can be used when you want to place one page on top of another like Stack Data structure.

1. Add this code to `MainPage.qml` : 

```jsx
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
```

In this section there is the Page with `PageHeader` which has a toggle button to switch theme between light and dark mode. 

Add Image Here..!!

1. Next Add this code to `SideMenu.qml` in the components folder: 

```jsx
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
        border.color: "lightgrey"
        radius :2

        Column {
            anchors.fill: parent
            spacing: units.gu(1)
            padding: units.gu(5)

            Label {
                text: i18n.tr("MENU")
                font.pixelSize : 24
                color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
               // font.bold: true
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

    
```

This is the `Side Menu` of Our App. It contains a few Buttons listed down which is being built by a a Custom Button and the `Seprator`  here is nothing but a rectangle acting as a line break for us. Lets add code for this `Seprator` and Custom Button Next.

Code for `Seprator`: 

```jsx
import QtQuick 2.7

Rectangle {
    id: separator
    width: parent.width / 1.5
    height: units.gu(0.1)
    color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
    anchors.horizontalCenter: parent.horizontalCenter
}

```

Code for Custom Button : 

```jsx
import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Row {
    id: customButton
    
    property alias text: label.text

    property alias name : icon.name

    signal clicked

    anchors.horizontalCenter: parent.horizontalCenter
    spacing: units.gu(1)

    Icon {
        id: icon
     color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
        name: "notebook"
        width: units.gu(2.5)
        height: units.gu(2.7)
    }
    Rectangle {

        width: 116
        height: 26
        color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "lightgrey" : "white"
        border.color: "slategrey"
        radius : 7

        Text {
            id: label
            anchors.centerIn: parent
            text: text
           // color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                customButton.clicked();
            }
        }
    }
}

```

This Custom Button Takes Input for the Icon , Title and you can also change it width to suit your requirements.