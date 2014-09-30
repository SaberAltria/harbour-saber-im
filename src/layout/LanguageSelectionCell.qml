// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: selectionCell

    property int index
    property bool active: selectionPopup.activeCell === index
    property alias text: textItem.text

    width: textItem.width + geometry.languageSelectionCellMargin * 2
    height: parent.height

    Text {
        id: textItem
        width: paintedWidth
        height: parent.height
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Theme.primaryColor
        opacity: selectionCell.active ? 1 : .35
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSizeMedium
    }
}
