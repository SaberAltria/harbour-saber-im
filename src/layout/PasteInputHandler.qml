// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.0
import Sailfish.Silica 1.0

InputHandler {
    topItem: Component {
        TopItem {
            SilicaFlickable {
                anchors.fill: parent
                flickableDirection: Flickable.HorizontalFlick
                boundsBehavior: !keyboard.expandedPaste && Clipboard.hasText ? Flickable.DragOverBounds : Flickable.StopAtBounds

                onDraggingChanged: {
                    if (!dragging && !keyboard.expandedPaste && contentX < -Theme.paddingLarge) {
                        keyboard.expandedPaste = true
                        contentX = 0
                    }
                }
                PasteButton {
                    onClicked: {
                        MInputMethodQuick.sendCommit(Clipboard.text)
                        keyboard.expandedPaste = false
                    }
                }
            }
        }
    }

    function handleKeyClick() {
        keyboard.expandedPaste = false
        return false
    }
}
