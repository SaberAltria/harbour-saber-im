import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
    id: root
    z: 8192
    property string label
    width: childrenRect.width + Theme.paddingMedium
    height: 52
    radius: geometry.popperRadius
    color: Qt.darker(Theme.highlightBackgroundColor, 1.2)
    anchors.bottom: parent.top
    visible: false

    Text {
        id: label
        anchors.centerIn: parent
        color: Theme.primaryColor
        text: parent.label
    }
}
