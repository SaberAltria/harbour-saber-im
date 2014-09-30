import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

PasteButton {
    visible: Clipboard.hasText
    onClicked: {
        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
        buttonPressEffect.play()

        if ( preedit.length > 0 ) {
            commit(preedit)
        }
        commit(Clipboard.text)
        keyboard.expandedPaste = false
    }

    onPressAndHold: popup.visible = true

    onReleased: {
        if ( popup.visible && popup.containsMouse )
            Clipboard.text = ""
        popup.visible = false
    }

    onCanceled: popup.visible = false

    onPositionChanged: {
        if (!popup.visible) {
            return
        }

        var pos = mapToItem(popup, mouse.x, mouse.y)
        var wasSelected = popup.containsMouse
        popup.containsMouse = popup.contains(Qt.point(pos.x, pos.y - geometry.clearPasteTouchDelta))
        if (wasSelected != popup.containsMouse) {
            SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
            buttonPressEffect.play()
        }
    }
}
