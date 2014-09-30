import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {
    property string direction
    property int keyType: KeyType.FunctionKey

    width: 96
    height: 80

    Image {
        id: image
        anchors.centerIn: parent
        source: "image://theme/icon-l-" + direction + (pressed ? ("?" + Theme.highlightColor) : "")
    }

    onClicked: {
        if ( direction === "left" ) {
            MInputMethodQuick.sendKey(Qt.Key_Left)
        } else if ( direction === "right" ) {
            MInputMethodQuick.sendKey(Qt.Key_Right)
        } if ( direction === "up" ) {
            MInputMethodQuick.sendKey(Qt.Key_Up)
        } if ( direction === "down" ) {
            MInputMethodQuick.sendKey(Qt.Key_Down)
        }
    }
}
