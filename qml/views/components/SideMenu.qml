import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0


Rectangle {
    id: sideMenu
    property bool permanent: false
    property var stackView
    
    width: units.gu(30)
    height: parent.height
    color: theme.palette.normal.background
    border.color: "lightgrey"
    radius: 2
    
    // Only visible if permanent or menuOpen is true
    visible: permanent || root.menuOpen
    
    // Function to find stackView if not provided
    function findStackView() {
        if (stackView) {
            return stackView;
        }
        
        // Try to find stackView in parent hierarchy
        var parentItem = parent;
        while (parentItem) {
            // Look for StackView in parent
            for (var i = 0; i < parentItem.children.length; i++) {
                var child = parentItem.children[i];
                if (child.toString().indexOf("StackView") !== -1) {
                    console.log("Found StackView:", child);
                    return child;
                }
            }
            parentItem = parentItem.parent;
        }
        
        console.log("No StackView found");
        return null;
    }
    
    Column {
        anchors.fill: parent
        spacing: units.gu(1)
        padding: units.gu(5)
        
        Rectangle {
            id: menuHeader
            width: parent.width / 2
            height: units.gu(5)
            color: theme.palette.normal.background
        }
        
        Label {
            text: i18n.tr("MENU")
            font.pixelSize: 24
            color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        Seprator {}
        
        CustomButton {
            text: i18n.tr("Home")
            name: "home"
            onClicked: {
                console.log("Tasks clicked")
                stackView = findStackView();
                  var mainPageUrl = Qt.resolvedUrl("MainPage.qml")
                    console.log("Resolved URL:", mainPageUrl)
                    stackView.push(mainPageUrl)
                root.menuOpen = false
            }
        }
        
        Seprator {}
        
        CustomButton {
            text: i18n.tr("Calendar")
            name: "calendar"
            onClicked: mainPageRoot.menuOpen = !mainPageRoot.menuOpen
        }
        
        Seprator {}
        
        CustomButton {
            text: i18n.tr("Projects")
            name: "note"
            onClicked: {
                mainPageRoot.menuOpen = !mainPageRoot.menuOpen
                console.log("Projects clicked")
                console.log("stackView exists:", stackView !== null)
                console.log("stackView type:", stackView)
                
                if (stackView) {
                    console.log("Navigating to ProjectList.qml")
                    // Try different paths based on your project structure
                    var projectListUrl = Qt.resolvedUrl("ProjectList.qml")
                    console.log("Resolved URL:", projectListUrl)
                    stackView.push(projectListUrl)
                } else {
                    console.log("ERROR: stackView is null or undefined")
                }
            }
        }
        
        Seprator {}
        
        CustomButton {
            text: i18n.tr("TimeSheets")
            name: "appointment"
            onClicked: root.menuOpen = false
        }
        
        Seprator {}
        
        CustomButton {
            text: i18n.tr("Settings")
            name: "settings"
            onClicked: root.menuOpen = false
        }
        
        Seprator {}
        
        CustomButton {
            text: i18n.tr("About")
            name: "info"
            onClicked: root.menuOpen = false
        }
        
        Seprator {}
    }
}