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
import com.meego.maliitquick 1.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import harbour.saber.engine 1.0

import "../saber"
import "../.."

InputHandler {

    property var trie
    property bool trie_built: false

    //INPUT
    property string sql
    property string keys
    property variant result
    property string preedit
    property int current
    property int length: 1
    property variant phrase

    property bool fetchMany: false
    property int count: 0
    property string name: canvas.layoutModel.get(canvas.activeIndex).name

    Database {
        id: database
        Component.onCompleted: {
            database.initial("pinYin.sqlite")
        }
    }

    Settings {
        id: settings
        property string spacebar: settings.load("spacebar")
        property string keys: settings.load("keys")
        property string word: settings.load("word")
        property string emoji: settings.load("emoji")
    }

    onPreeditChanged: {

        phrase = preedit.split("'")
        length = phrase.length

        if ( preedit.length > 0 ) {

            candidateList.loadKY(preedit)

            if ( current === 0 ) {
                var sql = 'SELECT DISTINCT alphabet FROM t9 WHERE keys GLOB ( SELECT  keys FROM t9 WHERE alphabet = "' + phrase[current] + '" LIMIT 1 ) || "*" ORDER BY frequency DESC LIMIT 0, 8'

                var result = database.load(sql)

                if ( result.length > 0 ) {
                    alphabetList.clear()
                    for ( var i = 0; i < result.length; i++ ) {
                        alphabetList.append( { "alphabet": result[i] } )
                    }
                }
            }

        } else {
            current = 0
        }
    }

    onCurrentChanged: {

        if ( current > 0 ) {

            var sql = 'SELECT DISTINCT alphabet FROM t9 WHERE keys GLOB ( SELECT  keys FROM t9 WHERE alphabet = "' + phrase[current] + '" LIMIT 1 ) || "*" ORDER BY frequency DESC LIMIT 0, 8'

            var result = database.load(sql)

            if ( result.length > 0 ) {
                alphabetList.clear()
                for ( var i = 0; i < result.length; i++ ) {
                    alphabetList.append( { "alphabet": result[i] } )
                }
                 alphabetView.positionViewAtBeginning()
            }
        }
    }


    ListModel {
        id: alphabetList
    }

    ListModel {
        id: punctuationList

        ListElement {
            alphabet: "，"
        }

        ListElement {
            alphabet: " 。"
        }

        ListElement {
            alphabet: "？"
        }

        ListElement {
            alphabet: "！"
        }

        ListElement {
            alphabet: "："
        }

        ListElement {
            alphabet: "；"
        }


    }

    ListModel {
        id: candidateList

        function loadKY(keys) {

            sql = 'SELECT character FROM [android-' + length + '] WHERE ( alphabet >= "'+ keys +'" AND alphabet < "' + keys + 'Ｚ") ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 16'

            result = database.load(sql)

            if ( result.length > 0 ) {
                if ( result.length >= candidateList.count ) {
                    for ( var i = 0; i < result.length; i++ ) {
                        candidateList.set(i, { "candidate": result[i] } )
                    }
                } else {

                    empty()

                    for ( var i = 0; i < result.length; i++ ) {
                        candidateList.append( { "candidate": result[i] } )
                    }
                }

            }

        }

        function loadMKY(keys) {
            if ( candidateList.count <= 16 ) {

                sql = 'SELECT character FROM [android-' + length + '] WHERE ( alphabet >= "'+ keys +'" AND alphabet < "' + keys + 'Ｚ") ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 128'

                result = database.load(sql)

                if ( result.length > 0 ) {
                    if ( result.length >= candidateList.count ) {
                        for ( var i = 0; i < result.length; i++ ) {
                            candidateList.set(i, { "candidate": result[i] } )
                        }
                    } else {
                        empty()

                        for ( i = 0; i < result.length; i++ ) {
                            candidateList.append( { "candidate": result[i] } )
                        }
                    }
                    candidatesUpdated()
                }
            }
        }

        function pushKY(character) {
            if ( settings.keys === "true" ) {

                sql = 'UPDATE [android-' + length + '] SET frequency = frequency + 1024 WHERE character = "' + character + '"'
                database.update(sql)
            }
        }

        function pushWD(alphabet) {
            if ( settings.word === "true" ) {

                sql = 'UPDATE t9 SET frequency = frequency + 1024 WHERE alphabet = "'+ alphabet + '"'
                database.update(sql)
            }
        }
    }

    topItem: Column {
        id: column
        width: parent.width
        height: 80

        Help {
            id: help
        }

        Popup {
            id: popup
        }

        Row {
            id: row
            width: parent.width
            height: 80
            visible: !fetchMany && !keyboard.inSymView && !keyboard.inSymView2

            CandidateRow {
                id: listView
                width: footer.visible? parent.width - 52: parent.width

                onDragEnded: {

                    if ( atXEnd && candidateList.count > 8 ) {
                        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
                        buttonPressEffect.play()

                        if ( preedit !== "" && candidateList.count >= 16 ) {
                            candidateList.loadMKY(preedit)

                        }

                        fetchMany = true

                    } else {

                    }
                }

                delegate: DelegateH {
                    id: delegateH

                    onClicked: {

                        keys = ""
                    }

                    onPressAndHold: {

                        sql = 'SELECT alphabet FROM [android-' + length + '] WHERE character = "' + model.candidate + '"'

                        result = database.load(sql)

                        if ( result.length > 0 ) {
                            help.label = result[0]
                            help.visible = true
                        }
                    }
                }
            }

            Open {
                id: footer
            }
        }

        CandidateDialog {
            id: dialog

            SilicaFlickable {
                id: flickable
                height: parent.height
                anchors.left: parent.left
                anchors.right: close.left
                contentHeight: flow.height
                interactive: true
                flickableDirection: Flickable.VerticalFlick

                VerticalScrollDecorator {  }

                clip: true

                Flow {
                    id: flow
                    width: parent.width

                    Repeater {
                        id: repeater
                        model: dialog.visible? candidateList: 0

                        delegate: DelegateV {
                            id: delegateV

                            onClicked: {

                                keys = ""
                                candidateList.pushKY(model.candidate)
                            }

                            onPressAndHold: {

                                sql = 'SELECT keys FROM [android-' + length + '] WHERE character = "' + model.candidate + '"'

                                result = database.load(sql)

                                if ( result.length > 0 ) {
                                    help.label = result[0]
                                    help.visible = true
                                }
                            }
                        }
                    }
                }
            }

            Close {
                id: close
            }
        }

        Rectangle {
            height: row.width > 540? 195 - Theme.paddingMedium: 270 - Theme.paddingMedium
            anchors.left: parent.left
            anchors.top: parent.top
            width: 72
            parent: keyboard
            anchors.leftMargin: Theme.paddingMedium
            anchors.topMargin: Theme.paddingMedium
            anchors.bottomMargin: Theme.paddingMedium
            visible: ( keyboard.layout.inEmojiView || attributes.inSymView || !attributs.inSymView2 )? false: true
            color: "#00000000"


            Rectangle {
                anchors.fill: parent
                radius: geometry.keyRadius
                color: Theme.highlightBackgroundColor
                opacity: 0.16
            }

            MultiPointTouchArea {
                // prevent events leaking below
                anchors.fill: parent
                z: -1
            }

            Label {
                anchors.centerIn: parent
                text: keys
                visible: false
            }

            Label {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: length
                visible: false
            }

            Label {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                text: phrase[current]
                visible: false
            }

            ListView {
                id: alphabetView
                anchors.fill: parent
                model: preedit.length === 0? punctuationList: alphabetList
                delegate: Column {
                    width: parent.width
                    height: row.width > 540? 48.75: 67.5

                    BackgroundItem {
                        width: parent.width
                        height: parent.height - separator.height

                        Label {
                            anchors.centerIn: parent
                            color: Theme.highlightColor
                            text: model.alphabet
                            font.pixelSize: width >= parent.width? Theme.fontSizeExtraSmall: Theme.fontSizeMedium
                        }

                        onClicked: {

                            if ( alphabetView.model === alphabetList ) {
                                if ( current === 0 ) {
                                    preedit = preedit.replace(phrase[current], alphabet)
                                    MInputMethodQuick.sendPreedit(preedit)
                                } else {
                                    preedit = preedit.replace("'" + phrase[current], "'" + alphabet)
                                    MInputMethodQuick.sendPreedit(preedit)
                                }

                                candidateList.pushWD(alphabet)

                                if ( current < length ) {
                                    current = current + 1
                                }

                            } else {
                                MInputMethodQuick.sendCommit(alphabet)
                            }
                        }

                    }

                    Separator {
                        id: separator
                        width: parent.width
                        color: Theme.highlightColor
                    }
                }
            }

        }

    }

    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        if ( pressedKey.key === Qt.Key_Space ) {

            if ( preedit.length > 0 && candidateList.count > 0 && settings.spacebar === "true" ) {
                preedit = ""
                commit(candidateList.get(0).candidate)
                candidateList.pushKY(candidateList.get(0).candidate)

                handled = true

            } else if ( preedit.length === 0 && candidateList.count > 0 && settings.spacebar === "true" ) {
                commit(candidateList.get(0).candidate)

            } else if ( preedit.length > 0 ) {
                commit(preedit)

            } else {
                commit(" ")

            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Return ) {

            if ( preedit.length > 0 ) {
                commit(preedit)
            } else {
                MInputMethodQuick.sendKey(Qt.Key_Return)
            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Backspace ) {

            if ( keys.length > 0 ) {
                keys = keys.slice(0, keys.length - 1)
            }

            if ( preedit.length > 0 ) {
                preedit = preedit.slice(0, preedit.length -1)
                MInputMethodQuick.sendPreedit(preedit)
                if ( preedit.length > 1 ) {
                    candidateList.loadKY(preedit)
                }
            } else if ( candidateList.count > 0 ) {
                empty()


            } else {
                MInputMethodQuick.sendKey(Qt.Key_Backspace)
            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Clear ) {

            reset()
            empty()

            handled = true

        } else if ( pressedKey.text.match(/(abc|def|ghi|jkl|mno|pqrs|tuv|wxyz)/) !== null ) {

            keys += pressedKey.caption

            sql = 'SELECT DISTINCT alphabet FROM t9 WHERE keys = "'+ keys + '" ORDER BY frequency DESC LIMIT 1'

            result = database.load(sql)

            if ( result.length > 0 ) {

                preedit = result[0].slice(0, keys.length + length)
                MInputMethodQuick.sendPreedit(preedit)

            } else if ( length === 1 || length === 2 ) {

                sql = 'SELECT DISTINCT alphabet FROM [android-2] WHERE keys >= "'+ keys + '" AND keys < "' + keys + 'Z" ORDER BY sorting + frequency DESC LIMIT 1'
                result = database.load(sql)

                if ( result.length > 0 ) {

                    preedit = result[0].slice(0, keys.length + length)
                    MInputMethodQuick.sendPreedit(preedit)

                } else if ( length === 2 || length === 3 ) {

                    sql = 'SELECT DISTINCT alphabet FROM [android-3] WHERE keys >= "'+ keys + '" AND keys < "' + keys + 'Z" ORDER BY sorting + frequency DESC LIMIT 1'
                    result = database.load(sql)

                    if ( result.length > 0 ) {

                        preedit = result[0].slice(0, keys.length + length)
                        MInputMethodQuick.sendPreedit(preedit)

                    } else if ( length === 3 || length === 4 ) {

                        sql = 'SELECT DISTINCT alphabet FROM [android-4] WHERE keys >= "'+ keys + '" AND keys < "' + keys + 'Z" ORDER BY sorting + frequency DESC LIMIT 1'
                        result = database.load(sql)

                        if ( result.length > 0 ) {

                            preedit = result[0].slice(0, keys.length + length)
                            MInputMethodQuick.sendPreedit(preedit)

                        } else {
                            keys = keys.slice(0, keys.length - 1)
                        }
                    }
                }
            }

            handled = true

        } else {
            commit(pressedKey.text)
            handled = true
        }

        return handled
    }

    function accept(index) {
        console.log("attempting to accept", index)
    }

    function shift() {

        if ( candidateList.count > 0 ) {
            candidateList.clear()
        }

    }

    function reset() {
        keys = ""
        preedit = ""
        MInputMethodQuick.sendPreedit("")
    }

    function commit(text) {
        MInputMethodQuick.sendCommit(text)
        reset()
    }

    function empty() {
        candidateList.clear()
    }

}
