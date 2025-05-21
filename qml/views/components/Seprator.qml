import QtQuick 2.7

Rectangle {
    id: separator
    width: parent.width / 1.5
    height: units.gu(0.1)
    color: theme.name === "Ubuntu.Components.Themes.SuruDark" ? "white" : "black"
    anchors.horizontalCenter: parent.horizontalCenter
}
