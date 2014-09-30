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
import "../saber"


KeyboardLayout {
    type: "quickMS"
    id: layout

    property int keyWidthNarrow: ( parent.width - shiftKeyWidth ) / 7
    property int keyWidthMedium: parent.width / 10
    property int keyWidth: parent.width / 10
    property bool enMode: false

    LayoutModel {
        id: layoutModel
    }

    KeyboardRow {
        visible: ( !attributes.inSymView && !enMode )? true: false

        CharacterKey { caption: "手"; captionShifted: "手"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "田"; captionShifted: "田"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "水"; captionShifted: "水"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "口"; captionShifted: "口"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "廿"; captionShifted: "廿"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "卜"; captionShifted: "卜"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "山"; captionShifted: "山"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "戈"; captionShifted: "戈"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "人"; captionShifted: "人"; fixedWidth: true; width: keyWidthMedium }
        CharacterKey { caption: "心"; captionShifted: "心"; fixedWidth: true; width: keyWidthMedium }
    }

    KeyboardRow {
        visible: ( !attributes.inSymView && !enMode )? true: false

        CharacterKey { caption: "日"; captionShifted: "日" }
        CharacterKey { caption: "尸"; captionShifted: "尸"; fixedWidth: true; width: keyWidth }
        CharacterKey { caption: "木"; captionShifted: "木"; fixedWidth: true; width: keyWidth }
        CharacterKey { caption: "火"; captionShifted: "火"; fixedWidth: true; width: keyWidth }
        CharacterKey { caption: "土"; captionShifted: "土"; fixedWidth: true; width: keyWidth }
        CharacterKey { caption: "竹"; captionShifted: "竹"; fixedWidth: true; width: keyWidth }
        CharacterKey { caption: "十"; captionShifted: "十"; fixedWidth: true; width: keyWidth }
        CharacterKey { caption: "大"; captionShifted: "大"; fixedWidth: true; width: keyWidth }
        CharacterKey { caption: "中"; captionShifted: "中" }

    }

    KeyboardRow {
        visible: ( !attributes.inSymView && !enMode )? true: false

        CharacterKey { caption: "重"; captionShifted: "重"; fixedWidth: true; width: keyWidthNarrow }
        CharacterKey { caption: "難"; captionShifted: "難"; fixedWidth: true; width: keyWidthNarrow }
        CharacterKey { caption: "金"; captionShifted: "金"; fixedWidth: true; width: keyWidthNarrow }
        CharacterKey { caption: "女"; captionShifted: "女"; fixedWidth: true; width: keyWidthNarrow }
        CharacterKey { caption: "月"; captionShifted: "月"; fixedWidth: true; width: keyWidthNarrow }
        CharacterKey { caption: "弓"; captionShifted: "弓"; fixedWidth: true; width: keyWidthNarrow }
        CharacterKey { caption: "一"; captionShifted: "一"; fixedWidth: true; width: keyWidthNarrow }

        BackspaceKey { }
    }


    KeyboardRow {
        visible: ( attributes.inSymView || enMode )? true: false

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
        visible: ( attributes.inSymView || enMode )? true: false

        CharacterKey { caption: "a"; captionShifted: "A"; symView: "*"; symView2: "`" }
        CharacterKey { caption: "s"; captionShifted: "S"; symView: "#"; symView2: "^" }
        CharacterKey { caption: "d"; captionShifted: "D"; symView: "+"; symView2: "|" }
        CharacterKey { caption: "f"; captionShifted: "F"; symView: "-"; symView2: "_" }
        CharacterKey { caption: "g"; captionShifted: "G"; symView: "="; symView2: "§" }
        CharacterKey { caption: "h"; captionShifted: "H"; symView: "（"; symView2: "{" }
        CharacterKey { caption: "j"; captionShifted: "J"; symView: "）"; symView2: "}" }
        CharacterKey { caption: "k"; captionShifted: "K"; symView: "！"; symView2: "—" }
        CharacterKey { caption: "l"; captionShifted: "L"; symView: "？"; symView2: "…" }
    }

    KeyboardRow {
        visible: ( attributes.inSymView || enMode )? true: false

        ShiftKey { }

        CharacterKey { caption: "z"; captionShifted: "Z"; symView: "@"; symView2: "《" }
        CharacterKey { caption: "x"; captionShifted: "X"; symView: "&"; symView2: "》" }
        CharacterKey { caption: "c"; captionShifted: "C"; symView: "/"; symView2: "『" }
        CharacterKey { caption: "v"; captionShifted: "V"; symView: "\\"; symView2: "』" }
        CharacterKey { caption: "b"; captionShifted: "B"; symView: "、"; symView2: "「" }
        CharacterKey { caption: "n"; captionShifted: "N"; symView: "；"; symView2: "」" }
        CharacterKey { caption: "m"; captionShifted: "M"; symView: "︰"; symView2: "~" }

        BackspaceKey { }
    }

    KeyboardRow {

        SymbolKey {
            caption: keyboard.inSymView ? "返": "符"
            width: punctuationKeyWidth
            onClicked: {

                if  ( enMode == true ) {

                    enMode = false
                } else {
                    enMode = true
                }
            }
        }

        FunctionKey {
            caption: enMode == true? "中": "英"
            width: punctuationKeyWidth

            Rectangle {
                color: parent.pressed ? Theme.highlightBackgroundColor : Theme.primaryColor
                opacity: parent.pressed ? 0.6 : 0.16
                radius: geometry.keyRadius

                anchors.fill: parent
                anchors.topMargin: Theme.paddingMedium
                anchors.bottomMargin: Theme.paddingMedium
                anchors.leftMargin: Theme.paddingSmall
                anchors.rightMargin: Theme.paddingSmall
            }

            onClicked: {


                if ( attributes.inSymView === true ) {
                    keyboard.inSymView = false
                }

                if ( attributes.inSymView2 === true ) {
                    keyboard.inSymView2 = false
                }

                if  ( enMode == true ) {

                    enMode = false
                } else {
                    enMode = true
                }
            }

        }

        CharacterKey {
            caption: enMode == true?",": "，"
            captionShifted: enMode == true?",": "，"
            symView: ","
            width: punctuationKeyWidth
        }

        SpacebarKey {
            fixedWidth: true
            separator: false
        }

        CharacterKey {
            caption: enMode == true?".": "。"
            captionShifted: enMode == true?".": "。"
            symView: "."
            width: punctuationKeyWidth
        }


        EnterKey { width: shiftKeyWidth }


    }
}
