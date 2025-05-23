import QtQuick 2.7
import Lomiri.Components 1.3

Page {
    property var project
    header: PageHeader { title: project ? project.name : "" }

    ScrollView {
        anchors.fill: parent
        Column { spacing: units.gu(2); padding: units.gu(2)
            Label { text: project ? project.description : "" }
            Label { text: project ? project.details     : "" }
        }
    }
}
