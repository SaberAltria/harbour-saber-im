import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {
    width: textH.width + Theme.paddingLarge * 2
    height: parent.height

    Text {
        id: textH
        anchors.centerIn: parent
        color: (parent.down || index === 0) ? Theme.highlightColor : Theme.primaryColor
        font { pixelSize: Theme.fontSizeMedium }
        text: candidate
        textFormat: Text.PlainText
    }

    onReleased: help.visible = false

    onClicked: {

        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
        buttonPressEffect.play()

        if ( preedit !== "" ) {
            commit(model.candidate)
            candidateList.pushKY(model.candidate)
            candidateList.loadWD(model.candidate)
        } else {
            commit(model.candidate)
            candidateList.pushWD(model.candidate)

            empty()
        }
    }
}
