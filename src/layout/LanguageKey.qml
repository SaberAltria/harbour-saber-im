import QtQuick 2.0
import Sailfish.Silica 1.0

FunctionKey {
    width: functionKeyWidth
    keyType: KeyType.SymbolKey

    caption: keyboard.inputHandler === xt9Handler? "中": "英"

    Rectangle {
        color: parent.pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
        opacity: parent.pressed ? 0.6 : 0.16
        radius: geometry.keyRadius
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium
    }

    onClicked: {

        if  ( keyboard.inputHandler === xt9Handler ) {

            keyboard.layout.inEmojiView = false

            keyboard.inSymView = false
            keyboard.inSymView2 = false

            keyboard.layout.type = "Saber"
            keyboard.layout.languageCode = "SB"

            keyboard.inputHandler.active = false
            keyboard.inputHandler = keyboard.layout.inputHandler
            keyboard.inputHandler.active = true

        } else {

            keyboard.layout.inEmojiView = false

            keyboard.inSymView = false
            keyboard.inSymView2 = false


            keyboard.layout.type = ""
            keyboard.layout.languageCode = "EN"

            keyboard.inputHandler.active = false
            keyboard.inputHandler = xt9Handler
            keyboard.inputHandler.active = true
        }
    }


}
