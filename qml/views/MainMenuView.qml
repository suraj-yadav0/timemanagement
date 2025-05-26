import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: mainMenuView
    
    property alias model: listView.model
    signal itemSelected(string itemName)
    
    header: PageHeader {
        title: i18n.tr('Time Management')
    }
    
    ListView {
        id: listView
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: parent.header.bottom
        }
        
        delegate: ListItem {
            height: units.gu(8)
            
            ListItemLayout {
                title.text: model.name
                subtitle.text: model.description
                
                Icon {
                    name: model.icon
                    width: units.gu(3)
                    height: units.gu(3)
                    SlotsLayout.position: SlotsLayout.Leading
                }
                
                Icon {
                    name: "go-next"
                    width: units.gu(2)
                    height: units.gu(2)
                    SlotsLayout.position: SlotsLayout.Trailing
                }
            }
            
            onClicked: {
                mainMenuView.itemSelected(model.name)
            }
        }
    }
}
