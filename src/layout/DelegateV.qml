import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {
    id: root

    width: textV.width + Theme.paddingMedium * 2
    height: 80
    opacity: visible? 1: 0

    Behavior on opacity { FadeAnimation {  } }

    onReleased: help.visible = false

    onClicked: {

        if ( preedit !== "" ) {
            commit(candidate)
            candidateList.pushKY(candidate)
            candidateList.loadWD(candidate)

        } else {
            commit(candidate)
            candidateList.pushWD(candidate)

        }

        fetchMany = false
    }

    Text {
        id: textV
        anchors.centerIn: parent
        textFormat: Text.PlainText
        color: ( parent.down || index === 0 ) ? Theme.highlightColor : Theme.primaryColor
        font { pixelSize: Theme.fontSizeMedium }
        text: candidate
    }
}
