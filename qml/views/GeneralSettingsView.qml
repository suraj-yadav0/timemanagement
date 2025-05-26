import QtQuick 2.9
import Lomiri.Components 1.3

Page {
    id: generalSettingsView
    header: PageHeader {
        title: i18n.tr("General Settings")
    }
    
    property var model: pageStack && pageStack.mainApp ? pageStack.mainApp.settingsModel : null
    
    ListView {
        anchors {
            fill: parent
            topMargin: generalSettingsView.header.height
            margins: units.gu(2)
        }
        
        model: ListModel {
            id: settingsListModel
            
            ListElement { 
                title: "Theme" 
                type: "switch"
                key: "darkTheme"
            }
            ListElement { 
                title: "Language" 
                type: "selector"
                key: "language"
            }
            ListElement { 
                title: "Auto-Save" 
                type: "switch"
                key: "autoSave"
            }
        }
        
        delegate: ListItem {
            height: layout.height + divider.height
            
            ListItemLayout {
                id: layout
                title.text: title
                
                Loader {
                    id: controlLoader
                    SlotsLayout.position: SlotsLayout.Trailing
                    width: type === "selector" ? units.gu(12) : units.gu(4)
                    
                    sourceComponent: {
                        switch(type) {
                            case "switch":
                                return switchComponent
                            case "selector":
                                return selectorComponent
                            default:
                                return null
                        }
                    }
                    
                    Component {
                        id: switchComponent
                        
                        Switch {
                            checked: generalSettingsView.model ? generalSettingsView.model[key] : false
                            onCheckedChanged: {
                                if (generalSettingsView.model) {
                                    generalSettingsView.model.updateGeneralSetting(key, checked)
                                }
                            }
                        }
                    }
                    
                    Component {
                        id: selectorComponent
                        
                        OptionSelector {
                            model: ["English", "Spanish", "French", "German"]
                            selectedIndex: {
                                if (generalSettingsView.model) {
                                    return model.indexOf(generalSettingsView.model[key])
                                }
                                return 0
                            }
                            onSelectedIndexChanged: {
                                if (generalSettingsView.model) {
                                    generalSettingsView.model.updateGeneralSetting(key, model[selectedIndex])
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
