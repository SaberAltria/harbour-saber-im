// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.0
import Sailfish.Silica 1.0

CharacterKey {
    property alias languageLabel: textField.text

    caption: " "
    captionShifted: " "
    showPopper: false
    separator: false
    showHighlight: false
    width: spacebarKeyWidth
    key: Qt.Key_Space

    Rectangle {
        color: parent.pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
        opacity: parent.pressed ? 0.6 : 0.08
        radius: geometry.keyRadius

        anchors.fill: parent
        anchors.margins: Theme.paddingMedium
    }

    Text {
        id: textField
        width: parent.width
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text:  canvas.layoutModel.get(canvas.activeIndex).name
        color: Theme.primaryColor
        opacity: 0.4
        font.pixelSize: Theme.fontSizeSmall
    }
}
