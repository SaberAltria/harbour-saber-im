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
    property bool fetchMany: false

    property string preedit
    property string sql
    property variant result
    property string name: canvas.layoutModel.get(canvas.activeIndex).name
    Database {
        id: database
        Component.onCompleted: {
            database.initial("tables.sqlite")
        }

    }

    onPreeditChanged: {
        if (  preedit.length > 0 && preedit.length < 6 ) {
            candidateList.loadKY(preedit)
        }
    }

    Settings {
        id: settings
        property string spacebar: settings.load("spacebar")
        property string keys: settings.load("keys")
        property string word: settings.load("word")
        property string emoji: settings.load("emoji")
    }

    ListModel {
        id: candidateList

        signal candidatesUpdated

        function loadKY(keys) {

            if ( keys.match(/\?/) !== null ) {
                sql = 'SELECT character FROM stroke WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 16'
            } else {
                sql = 'SELECT character FROM stroke WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY  sorting + frequency DESC LIMIT 0, 16'
            }

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

        function loadMKY(keys) {

            if ( candidateList.count <= 16 ) {

                keys = keys + "*"

                sql = 'SELECT character FROM stroke WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 256'


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

        function loadWD(character) {

            character = '"' + character + '"'
            sql = 'SELECT phrase FROM word WHERE character=' + character + ' ORDER BY sorting + frequency DESC LIMIT 0, 128'
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
                candidatesUpdated()
            }

        }

        function pushKY(character) {
            if ( settings.keys === "true" ) {
                character = '"' + character + '"'
                sql = 'UPDATE stroke SET frequency=frequency+320 WHERE character=' + character
                database.update(sql)
            }

        }

        function pushWD(phrase) {
            if ( settings.word === "true" ) {
                phrase = '"' + phrase + '"'
                sql = 'UPDATE word SET frequency=frequency+320 WHERE phrase='+ phrase
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

            CandidateRow {
                id: listView
                width: footer.visible? parent.width - 52: parent.width
                visible: !fetchMany && !keyboard.inSymView && !keyboard.inSymView2

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

                    onPressAndHold: {

                        sql = 'SELECT keys FROM stroke WHERE character = "' + model.candidate + '"'

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

                            onPressAndHold: {

                                sql = 'SELECT keys FROM stroke WHERE character = "' + model.candidate + '"'


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
    }

    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        if ( pressedKey.key === Qt.Key_Space ) {

            if ( preedit.length > 0 && candidateList.count > 0 && settings.spacebar === "true" ) {

                preedit = ""
                commit(candidateList.get(0).candidate)
                candidateList.pushKY(candidateList.get(0).candidate)
                candidateList.loadWD(candidateList.get(0).candidate)

                handled = true

            } else if ( preedit.length == 0 && candidateList.count > 0 && settings.spacebar === "true" ) {
                commit(candidateList.get(0).candidate)
                candidateList.pushWD(candidateList.get(0).candidate)
                empty()

                handled = true

            } else if ( preedit.length > 0 ) {
                commit(preedit)

                handled = true
            } else {
                commit(" ")
                handled = true
            }

        } else if ( pressedKey.key === Qt.Key_Return ) {

            if ( preedit.length > 0 ) {
                commit(preedit)
            } else {
                MInputMethodQuick.sendKey(Qt.Key_Return)
            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Backspace ) {

            if ( preedit.length > 0 ) {

                preedit = preedit.slice(0, preedit.length-1)
                MInputMethodQuick.sendPreedit(preedit)


            } else if ( candidateList.count > 0 ) {
                reset()
                empty()


            } else {
                MInputMethodQuick.sendKey(Qt.Key_Backspace)

            }

            handled = true

        } else if ( pressedKey.keyType === KeyType.FunctionKey && pressedKey.keyType === KeyType.SymbolKey ) {

            reset()
            empty()

            handled = true


        } else if ( pressedKey.text.match(/[一丨丿丶乛]/) !== null ) {

            if ( preedit.length >= 0 ) {

                preedit = preedit + pressedKey.text
                MInputMethodQuick.sendPreedit(preedit)

                handled = true
            }  else {

                reset()


                handled = true
            }

        } else if ( pressedKey.text === "通" ) {

            if ( preedit.length > 0  ) {
                preedit = preedit + "?"
                MInputMethodQuick.sendPreedit(preedit)

            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Clear ) {

            reset()
            empty()

            handled = true

        } else if ( pressedKey.text === "1/2" || pressedKey.text === "2/2" ) {
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
