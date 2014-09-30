import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0

BackgroundItem {
    width: 96
    height: 80

    visible: settings.emoji === "true"? true: false

    Label {
        anchors.centerIn: parent
        text: keyboard.layout.inEmojiView? "☻": "☺"
        font.pixelSize: Theme.fontSizeExtraLarge
        smooth: false
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    onClicked: {

        if ( !keyboard.layout.inEmojiView ) {
            keyboard.inSymView = false
            keyboard.inSymView2 = false

            keyboard.layout.inEmojiView = true
        } else {
            keyboard.layout.inEmojiView = false
        }
    }
}
