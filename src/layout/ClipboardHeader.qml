// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.0
import com.meego.maliitquick 1.0
import Sailfish.Silica 1.0
import com.jolla 1.0

// Basic integration with InputHandler:
//
//    InputHandler {
//        ...
//        topItem: Component {
//            SilicaListView {
//                id: listViewId
//                orientation: ListView.Horizontal
//                height: headerItem && headerItem.visible ? Theme.itemSizeSmall : 0
//                header: ClipboardHeader {
//                    listView: listViewId
//                }
//            }
//        }
//        ...
//    }

BackgroundItem {
    property Item listView

    visible: label.text !== ""
    width: visible ? Math.min((listView ? (listView.count > 0 ? listView.width / 2 : listView.width)
                                        : Theme.itemSizeExtraLarge),
                              label.implicitWidth + icon.width + Theme.paddingLarge * 2 + Theme.paddingSmall)
                   : 0
    height: listView ? listView.height : 0

    onClicked: {
        // TODO: InputHandler should commit its state before this.
        MInputMethodQuick.sendCommit(clipboard.text + " ")
        if (listView && listView.count > 0) {
            hideAnimation.restart()
        }
    }

    Label {
        id: label
        anchors {
            left: parent.left
            leftMargin: Theme.paddingLarge
            right: icon.left
            rightMargin: Theme.paddingSmall
            verticalCenter: parent.verticalCenter
        }
        color: highlighted ? Theme.highlightColor : Theme.primaryColor
        truncationMode: TruncationMode.Fade
        textFormat: Text.PlainText
        maximumLineCount: 1
        font { pixelSize: Theme.fontSizeSmall; family: Theme.fontFamily }
        onTextChanged: if (listView) listView.contentX = -parent.width
    }

    Image {
        id: icon
        anchors {
            right: parent.right
            rightMargin: Theme.paddingLarge
            verticalCenter: parent.verticalCenter
        }
        height: Theme.itemSizeExtraSmall
        width: Theme.itemSizeExtraSmall
        // TODO: Replace with the correct icon once available.
        source: "image://theme/icon-m-search"
    }

    Clipboard {
        id: clipboard
        onTextChanged: {
            // Replace any whitespace (including line breaks) with ordinary space
            label.text = text.replace(/s/g, " ")
        }
    }

    NumberAnimation {
        id: hideAnimation
        target: listView
        property: listView ? "contentX" : ""
        to: 0
        duration: 64
    }
}
