import QtQuick 2.0
import Sailfish.Silica 1.0

Rectangle {

    visible: keyboard.inputHandler.fetchMany && candidateList.count > 0 === true
    color: Theme.highlightDimmerColor
    anchors.fill: parent
    opacity: visible? 0.96: 0
    Behavior on opacity { FadeAnimation {  } }
    z: 1024
    onVisibleChanged: {
        parent = keyboard
        anchors.fill = parent
    }

    clip: true
    parent: keyboard

    MultiPointTouchArea {
        // prevent events leaking below
        anchors.fill: parent
        z: -1
    }
}
