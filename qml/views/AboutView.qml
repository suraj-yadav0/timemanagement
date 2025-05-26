import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: aboutView
    header: PageHeader {
        title: i18n.tr("About Time Management")
    }
    
    ScrollView {
        anchors {
            fill: parent
            topMargin: aboutView.header.height
            margins: units.gu(2)
        }
        
        Column {
            width: parent.width
            spacing: units.gu(2)
            
            // App logo
            UbuntuShape {
                width: units.gu(10)
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                backgroundColor: UbuntuColors.blue
                
                Icon {
                    anchors.centerIn: parent
                    width: parent.width * 0.6
                    height: width
                    name: "alarm-clock"
                    color: "white"
                }
            }
            
            // App title and version
            Label {
                width: parent.width
                text: i18n.tr("Time Management")
                fontSize: "x-large"
                fontWeight: Font.Bold
                horizontalAlignment: Text.AlignHCenter
            }
            
            Label {
                width: parent.width
                text: i18n.tr("Version 1.0.0")
                fontSize: "medium"
                horizontalAlignment: Text.AlignHCenter
                opacity: 0.8
            }
            
            // Separator
            Rectangle {
                width: parent.width
                height: units.dp(1)
                color: theme.palette.normal.base
            }
            
            // App description
            Label {
                width: parent.width
                text: i18n.tr("A comprehensive time management application for professionals and teams.")
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }
            
            // Developer info
            Item { width: 1; height: units.gu(2) } // Spacer
            
            Label {
                width: parent.width
                text: i18n.tr("Developed by")
                fontSize: "small"
                horizontalAlignment: Text.AlignHCenter
                opacity: 0.8
            }
            
            Label {
                width: parent.width
                text: "Suraj Developer"
                fontSize: "medium"
                horizontalAlignment: Text.AlignHCenter
            }
            
            // Contact links
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: units.gu(3)
                
                Button {
                    text: i18n.tr("Website")
                    color: UbuntuColors.blue
                    onClicked: Qt.openUrlExternally("https://example.com")
                }
                
                Button {
                    text: i18n.tr("GitHub")
                    color: UbuntuColors.blue
                    onClicked: Qt.openUrlExternally("https://github.com/example/timemanagement")
                }
            }
            
            // Copyright
            Item { width: 1; height: units.gu(2) } // Spacer
            
            Label {
                width: parent.width
                text: "© 2023 Time Management App. All rights reserved."
                fontSize: "small"
                horizontalAlignment: Text.AlignHCenter
                opacity: 0.7
            }
            
            // License information
            Label {
                width: parent.width
                text: i18n.tr("This application is released under the GNU General Public License v3.")
                fontSize: "small"
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                opacity: 0.7
            }
            
            // Credits
            Item { width: 1; height: units.gu(2) } // Spacer
            
            Label {
                width: parent.width
                text: i18n.tr("Credits")
                fontSize: "medium"
                fontWeight: Font.Bold
                horizontalAlignment: Text.AlignHCenter
            }
            
            Label {
                width: parent.width
                text: i18n.tr("Icons: Ubuntu Icon Theme\nFramework: Lomiri/Ubuntu Touch SDK\nTesting: QA Team")
                fontSize: "small"
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                lineHeight: 1.5
            }
        }
    }
}
