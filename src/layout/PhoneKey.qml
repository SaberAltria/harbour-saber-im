// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.0
import Sailfish.Silica 1.0


KeyBase {
    id: aCharKey

    property alias secondaryLabel: secondaryLabel.text
    property bool separator: true
    property bool landscape

    keyType: KeyType.CharacterKey
    text: secondaryLabel.text
    showPopper: false

    Column {
        width: parent.width
        anchors.centerIn: parent


        Text {
            id: mainLabel
            width: parent.width
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeExtraSmall
            color: pressed ? Theme.highlightColor : Theme.primaryColor
            text: caption
            opacity: 0.8
        }

        Text {
            id: secondaryLabel
            width: parent.width
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSizeMedium
            color: pressed ? Theme.highlightColor : Theme.primaryColor
            opacity: 0.8
        }
    }

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
        visible: separator
    }

    Rectangle {
        anchors.fill: parent
        z: -1
        color: Theme.highlightBackgroundColor
        opacity: 0.5
        visible: pressed
    }
}

