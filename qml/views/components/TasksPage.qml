import QtQuick 2.7
import Lomiri.Components 1.3
import "../models/TaskModel.qml" as TaskData

Page {
    title: i18n.tr("Tasks")
    TaskData { id: taskModel }

    ListView {
        anchors.fill: parent
        model: taskModel
        delegate: ListItem {
            text: model.name; subtext: model.status
            ListItemLayout { title.text: text; subtitle.text: subtext }
        }
    }
}
