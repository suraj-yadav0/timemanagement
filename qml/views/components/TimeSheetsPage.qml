import QtQuick 2.7
import Lomiri.Components 1.3
import "../models/TimeSheetModel.qml" as TSData

Page {
    title: i18n.tr("Time Sheets")
    TSData { id: tsModel }

    ListView {
        anchors.fill: parent
        model: tsModel
        delegate: ListItem {
            text: model.taskName
            subtext: "Hours: " + model.hours + " on " + model.date
            ListItemLayout { title.text: text; subtitle.text: subtext }
        }
    }
}
