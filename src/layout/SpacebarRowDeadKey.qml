// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.0
import ".."

KeyboardRow {
    id: spacebarRow

    property alias deadKeyCaption: deadKey.caption
    property alias deadKeyCaptionShifted: deadKey.captionShifted

    SymbolKey {
        width: symbolKeyWidthNarrow
    }
    DeadKey {
        id: deadKey
        width: punctuationKeyWidthNarrow
        fixedWidth: true
        separator: false
    }
    ContextAwareCommaKey {
        width: punctuationKeyWidthNarrow
    }
    SpacebarKey {
        fixedWidth: true
    }
    CharacterKey {
        caption: "."
        captionShifted: "."
        width: punctuationKeyWidthNarrow
        fixedWidth: true
        separator: false
    }
    EnterKey {}
}
