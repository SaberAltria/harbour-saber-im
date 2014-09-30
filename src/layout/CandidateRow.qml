import QtQuick 2.0
import Sailfish.Silica 1.0
import com.meego.maliitquick 1.0

SilicaListView {
    id: listView
    orientation: ListView.Horizontal
    height: parent.height
    Behavior on width{ SmoothedAnimation{ easing.type: Easing.InQuad } }
    flickDeceleration: 1024
    snapMode: ListView.SnapToItem
    clip: true
    z: 256
    boundsBehavior: ( !keyboard.expandedPaste && Clipboard.hasText ) || ( footer.visible ) ? Flickable.DragOverBounds : Flickable.StopAtBounds
    model: candidateList

    header: Row {
        id: header
        height: parent.height

        Paste {
            id: paste
        }

        EmojiKey {
            visible: settings.emoji === "true" && candidateList.count === 0  && canvas.layoutModel.get(canvas.activeIndex).name !== "T9拼音"? true: false
        }

        CursorKey {
            direction: "left"
            visible: candidateList.count === 0? true: false
        }

        CursorKey {
            direction: "right"
            visible: candidateList.count === 0? true: false
        }

        CursorKey {
            direction: "up"
            visible: candidateList.count === 0? true: false
        }

        CursorKey {
            direction: "down"
           visible: candidateList.count === 0? true: false
        }
    }

    Connections {
        target: candidateList
        onCandidatesUpdated: listView.positionViewAtBeginning()
    }

    Connections {
        target: keyboard
        onLayoutChanged: {

        }
        onFocusTargetChanged: {

        }

        onInputMethodReset: {
        }
    }

    Connections {
        target: Clipboard
        onTextChanged: {
            if (Clipboard.hasText) {
                // need to have updated width before repositioning view
                positionerTimer.restart()
            }
        }
    }

    Timer {
        id: positionerTimer
        interval: 8
        onTriggered: listView.positionViewAtBeginning()
    }
}


