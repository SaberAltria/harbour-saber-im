import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {
    id: footer
    width: 52
    height: parent.height
    visible: ( candidateList.count >= 8 && !fetchMany && !keyboard.inSymView && !keyboard.inSymView2 )? true: false
    opacity: visible? 1: 0
    Behavior on opacity { FadeAnimation {  } }
    z: 768

    Image {
        source: "image://theme/icon-lock-more?" + Theme.highlightColor
        anchors.centerIn: parent
    }

    onClicked: {
        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
        buttonPressEffect.play()

        if ( preedit !== "" && candidateList.count >= 8 ) {
            candidateList.loadMKY(preedit)
        }

        fetchMany = true

    }
}
