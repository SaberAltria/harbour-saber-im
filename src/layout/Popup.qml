import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {
    id: popup
    z: 8192
    property bool containsMouse
    visible: false
    opacity: visble? 1: 0
    Behavior on opacity { FadeAnimation {  } }
    width: childrenRect.width + geometry.clearPasteMargin
    height: childrenRect.height + geometry.clearPasteMargin
    x: 0
    anchors.bottom: parent.top
    radius: geometry.popperRadius
    color: Qt.darker(Theme.highlightBackgroundColor, 1.2)

    onVisibleChanged: containsMouse = false

    Label {
        anchors.centerIn: parent
        color: parent.containsMouse ? Theme.primaryColor : Theme.highlightColor
        text: qsTrId("text_input-la-clear_clipboard")
    }
}
