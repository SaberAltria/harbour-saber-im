/*
 * Copyright (C) 2012-2013 Jolla ltd and/or its subsidiary(-ies). All rights reserved.
 *
 * Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Jolla Ltd nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.saber.engine 1.0
import "../saber"

KeyboardLayout {
    type: "Saber"
    id: layout

    property int keyWidth: ( parent.width - shiftKeyWidth ) / 12
    property bool inEmojiView: false

    Component.onCompleted: init()

    Connections {
        target: keyboard
        onInputHandlerChanged: handlerChanged()
    }

    function init() {
        // force onInputHandlerChanged signal by
        // making sure that the input handler was not
        // previously pasteInputHandler
        if (keyboard.allowLayoutChanges) {
            var oldHandler = keyboard.inputHandler
            keyboard.inputHandler = xt9Handler.item
            oldHandler.active = false
            keyboard.inputHandler.active = true
        }
    }

    LayoutModel {
        id: layoutModel
    }

    Settings {
        id: settings
        property string emoji: settings.load("emoji")
    }

    property Item inputHandler: CangJieHandler {
        id: quick5Handler
    }

    Xt9InputHandler {
        id: xt9Handler
    }

    EmojiKeyboard {
        visible: ( settings.emoji === "true" && keyboard.layout.inEmojiView )? true: false
    }

    //EnKeyobard
    KeyboardRow {
        visible: ( !keyboard.layout.inEmojiView && keyboard.inputHandler === xt9Handler  )? true: false

        CharacterKey { caption: "q"; captionShifted: "Q"; symView: "1"; symView2: "€" }
        CharacterKey { caption: "w"; captionShifted: "W"; symView: "2"; symView2: "£" }
        CharacterKey { caption: "e"; captionShifted: "E"; symView: "3"; symView2: "$" }
        CharacterKey { caption: "r"; captionShifted: "R"; symView: "4"; symView2: "¥" }
        CharacterKey { caption: "t"; captionShifted: "T"; symView: "5"; symView2: "₹" }
        CharacterKey { caption: "y"; captionShifted: "Y"; symView: "6"; symView2: "%" }
        CharacterKey { caption: "u"; captionShifted: "U"; symView: "7"; symView2: "<" }
        CharacterKey { caption: "i"; captionShifted: "I"; symView: "8"; symView2: ">" }
        CharacterKey { caption: "o"; captionShifted: "O"; symView: "9"; symView2: "[" }
        CharacterKey { caption: "p"; captionShifted: "P"; symView: "0"; symView2: "]" }
    }

    KeyboardRow {
        visible: ( !keyboard.layout.inEmojiView && keyboard.inputHandler === xt9Handler  )? true: false

        CharacterKey { caption: "a"; captionShifted: "A"; symView: "*"; symView2: "`" }
        CharacterKey { caption: "s"; captionShifted: "S"; symView: "#"; symView2: "^" }
        CharacterKey { caption: "d"; captionShifted: "D"; symView: "+"; symView2: "|" }
        CharacterKey { caption: "f"; captionShifted: "F"; symView: "-"; symView2: "_" }
        CharacterKey { caption: "g"; captionShifted: "G"; symView: "="; symView2: "§" }
        CharacterKey { caption: "h"; captionShifted: "H"; symView: "("; symView2: "{" }
        CharacterKey { caption: "j"; captionShifted: "J"; symView: ")"; symView2: "}" }
        CharacterKey { caption: "k"; captionShifted: "K"; symView: "!"; symView2: "¡" }
        CharacterKey { caption: "l"; captionShifted: "L"; symView: "?"; symView2: "¿" }
    }

    KeyboardRow {
        visible: ( !keyboard.layout.inEmojiView && keyboard.inputHandler === xt9Handler  )? true: false
        ShiftKey { }

        CharacterKey { caption: "z"; captionShifted: "Z"; symView: "@"; symView2: "«" }
        CharacterKey { caption: "x"; captionShifted: "X"; symView: "&"; symView2: "»" }
        CharacterKey { caption: "c"; captionShifted: "C"; symView: "/"; symView2: "\"" }
        CharacterKey { caption: "v"; captionShifted: "V"; symView: "\\"; symView2: "“" }
        CharacterKey { caption: "b"; captionShifted: "B"; symView: "'"; symView2: "”" }
        CharacterKey { caption: "n"; captionShifted: "N"; symView: ";"; symView2: "„" }
        CharacterKey { caption: "m"; captionShifted: "M"; symView: ":"; symView2: "~" }

        BackspaceKey {  }
    }

    KeyboardRow {
        visible: ( keyboard.inputHandler !== xt9Handler && !keyboard.layout.inEmojiView )? true: false

        CharacterKey { caption: "手"; captionShifted: "手"; symView: "1"; symView2: "€" }
        CharacterKey { caption: "田"; captionShifted: "田"; symView: "2"; symView2: "£" }
        CharacterKey { caption: "水"; captionShifted: "水"; symView: "3"; symView2: "$" }
        CharacterKey { caption: "口"; captionShifted: "口"; symView: "4"; symView2: "¥" }
        CharacterKey { caption: "廿"; captionShifted: "廿"; symView: "5"; symView2: "₹" }
        CharacterKey { caption: "卜"; captionShifted: "卜"; symView: "6"; symView2: "%" }
        CharacterKey { caption: "山"; captionShifted: "山"; symView: "7"; symView2: "<" }
        CharacterKey { caption: "戈"; captionShifted: "戈"; symView: "8"; symView2: ">" }
        CharacterKey { caption: "人"; captionShifted: "人"; symView: "9"; symView2: "[" }
        CharacterKey { caption: "心"; captionShifted: "心"; symView: "0"; symView2: "]" }
    }

    KeyboardRow {
        visible: ( keyboard.inputHandler !== xt9Handler && !keyboard.layout.inEmojiView )? true: false

        CharacterKey { caption: "日"; captionShifted: "日"; symView: "*"; symView2: "`" }
        CharacterKey { caption: "尸"; captionShifted: "尸"; symView: "#"; symView2: "^" }
        CharacterKey { caption: "木"; captionShifted: "木"; symView: "+"; symView2: "|" }
        CharacterKey { caption: "火"; captionShifted: "火"; symView: "-"; symView2: "_" }
        CharacterKey { caption: "土"; captionShifted: "土"; symView: "="; symView2: "§" }
        CharacterKey { caption: "竹"; captionShifted: "竹"; symView: "（"; symView2: "{" }
        CharacterKey { caption: "十"; captionShifted: "十"; symView: "）"; symView2: "}" }
        CharacterKey { caption: "大"; captionShifted: "大"; symView: "！"; symView2: "—" }
        CharacterKey { caption: "中"; captionShifted: "中"; symView: "？"; symView2: "~" }

    }

    KeyboardRow {
        visible: ( keyboard.inputHandler !== xt9Handler && !keyboard.layout.inEmojiView )? true: false
         ShiftKey {  }
        CharacterKey { caption: "重"; captionShifted: "重"; symView: "…"; symView2: "《" }
        CharacterKey { caption: "難"; captionShifted: "難"; symView: "&"; symView2: "》" }
        CharacterKey { caption: "金"; captionShifted: "金"; symView: "/"; symView2: "『" }
        CharacterKey { caption: "女"; captionShifted: "女"; symView: "\\"; symView2: "』" }
        CharacterKey { caption: "月"; captionShifted: "月"; symView: "、"; symView2: "「" }
        CharacterKey { caption: "弓"; captionShifted: "弓"; symView: "；"; symView2: "」" }
        CharacterKey { caption: "一"; captionShifted: "一"; symView: "︰"; symView2: "~" }

        BackspaceKey {  }
    }


    SpacebarRow {  }


}
