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
    id: root

    property var trie
    property bool trie_built: false

    property bool fetchMany: false

    property string sql
    property variant result
    property string preedit
    property string name: canvas.layoutModel.get(canvas.activeIndex).name


    onPreeditChanged: {
        if (  preedit.length > 0 && preedit.length < 6 ) {
            candidateList.loadKY(preedit)
        }
    }

    Connections {
        target: MInputMethodQuick
        onFocusTargetChanged: {

            inEmojiView = false
        }


    }


    Database {
        id: database
        Component.onCompleted: {
            database.initial("tables.sqlite")
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

            switch (name) {

            case "倉頡(三版)":

                if ( keys.match(/\?/) !== null ) {
                    sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 16'

                } else {
                    sql = 'SELECT character FROM cangJie3 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ") ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 16'
                }

                break

            case "倉頡(五版)":

                if ( keys.match(/\?/) !== null ) {
                    sql = 'SELECT character FROM cangJie5 WHERE keys GLOB "' + keys + '" ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 16'

                } else {
                    sql = 'SELECT character FROM cangJie5 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ") ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 16'
                }

                break

            case "速成(三版)":
                if ( keys.length > 0 && keys.length !== 2 && keys.length < 6 ) {

                    if ( keys.match(/\?/) !== null ) {
                        sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 16'
                    } else {
                        sql = 'SELECT character FROM cangJie3 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY sorting + frequency DESC LIMIT 0, 16'
                    }

                } else if ( keys.length === 2 ) {

                    keys = keys.slice(0,1) + "*" + keys.slice(1,2)
                    sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 16'

                }

                break

            case "速成(五版)":
                if ( keys.length > 0 && keys.length !== 2 && keys.length < 6 ) {

                    if ( keys.match(/\?/) !== null ) {
                        sql = 'SELECT character FROM cangJie5 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 16'
                    } else {
                        sql = 'SELECT character FROM cangJie5 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY sorting + frequency DESC LIMIT 0, 16'
                    }

                } else if ( keys.length === 2 ) {

                    keys = keys.slice(0,1) + "*" + keys.slice(1,2)
                    sql = 'SELECT character FROM cangJie5 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 16'

                }

                break

            }

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

        function loadMKY(keys) {
            if ( candidateList.count <= 16 ) {

                switch (name) {

                case "倉頡(三版)":
                    if ( keys.match(/\?/) !== null ) {
                        sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 256'

                    } else {
                        sql = 'SELECT character FROM cangJie3 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 256'
                    }

                    break

                case "倉頡(五版)":

                    if ( keys.match(/\?/) !== null ) {
                        sql = 'SELECT character FROM cangJie5 WHERE keys GLOB "' + keys + '" ORDER BY LENGTH(keys) ASC, sorting + frequency DESC LIMIT 0, 256'

                    } else {
                        sql = 'SELECT character FROM cangJie5 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY LENGTH(keys), sorting + frequency DESC LIMIT 0, 256'
                    }
                    break

                case "速成(三版)":
                    if ( keys.length > 0 && keys.length !== 2 && keys.length < 6 ) {

                        if ( keys.match(/\?/) !== null ) {
                            sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 256'
                        } else {
                            sql = 'SELECT character FROM cangJie3 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY sorting + frequency DESC LIMIT 0, 256'
                        }

                    } else if ( keys.length === 2 ) {

                        keys = keys.slice(0,1) + "*" + keys.slice(1,2)
                        sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 256'

                    }
                    break
                case "速成(五版)":
                    if ( keys.length > 0 && keys.length !== 2 && keys.length < 6 ) {

                        if ( keys.match(/\?/) !== null ) {
                            sql = 'SELECT character FROM cangJie5 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 256'
                        } else {
                            sql = 'SELECT character FROM cangJie5 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY sorting + frequency DESC LIMIT 0, 256'
                        }

                    } else if ( keys.length === 2 ) {

                        keys = keys.slice(0,1) + "*" + keys.slice(1,2)
                        sql = 'SELECT character FROM cangJie5 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 256'

                    }
                    break

                }

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
        }

        function loadWD(character) {

            character = '"' + character + '"';
            sql = 'SELECT phrase FROM word WHERE character=' + character + ' ORDER BY sorting + frequency DESC LIMIT 0, 32';
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

                switch (name) {

                case "倉頡(三版)", "速成(三版)":

                    character = '"' + character + '"'
                    sql = 'UPDATE cangJie3 SET frequency=frequency+320 WHERE character=' + character
                    database.update(sql)

                    break

                case "倉頡(五版)", "速成(五版)":

                    character = '"' + character + '"'
                    sql = 'UPDATE cangJie5 SET frequency=frequency+320 WHERE character=' + character
                    database.update(sql)

                    break

                }
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
            visible: !fetchMany

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

                    }
                }

                delegate: DelegateH {

                    onPressAndHold: {
                        switch (name) {

                        case "倉頡(三版)":
                            sql = 'SELECT keys FROM cangJie3 WHERE character = "' + candidate + '"'
                            break
                        case "倉頡(五版)":
                            sql = 'SELECT keys FROM cangJie5 WHERE character = "' + candidate + '"'
                            break
                        case "速成(三版)":
                            sql = 'SELECT keys FROM cangJie3 WHERE character = "' + candidate + '"'
                            break
                        case "速成(五版)":
                            sql = 'SELECT keys FROM cangJie5 WHERE character = "' + candidate + '"'
                            break
                        }

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
                clip: true

                VerticalScrollDecorator {  }

                Flow {
                    id: flow
                    width: parent.width

                    Repeater {
                        id: repeater
                        model: dialog.visible? candidateList: 0

                        delegate: DelegateV {
                            id: delegateV

                            onPressAndHold: {

                                switch (name) {

                                case "倉頡(三版)":
                                    sql = 'SELECT keys FROM cangJie3 WHERE character = "' + model.candidate + '"'
                                    break
                                case "倉頡(五版)":
                                    sql = 'SELECT keys FROM cangJie5 WHERE character = "' + model.candidate + '"'
                                    break
                                case "速成(三版)":
                                    sql = 'SELECT keys FROM cangJie3 WHERE character = "' + model.candidate + '"'
                                    break
                                case "速成(五版)":
                                    sql = 'SELECT keys FROM cangJie5 WHERE character = "' + model.candidate + '"'
                                    break
                                }

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

        if ( pressedKey.key === Qt.Key_CapsLock ) {

            reset()
            empty()

            handled = true

        } else if ( pressedKey.key === Qt.Key_Space ) {
            if ( preedit.length > 0 && candidateList.count > 0 && settings.spacebar === "true" ) {
                preedit = ""
                commit(candidateList.get(0).candidate)
                candidateList.pushKY(candidateList.get(0).candidate)
                candidateList.loadWD(candidateList.get(0).candidate)


            } else if ( preedit.length == 0 && candidateList.count > 0 && settings.spacebar === "true" ) {
                commit(candidateList.get(0).candidate)
                candidateList.pushWD(candidateList.get(0).candidate)
                candidateList.loadWD(candidateList.get(0).candidate)


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


        } else if ( pressedKey.text.match(/[日月金木水火土竹戈十大中一弓人心手口尸廿山女田卜難]/) !== null || ( pressedKey.text == "重" && preedit.length == 0 ) ) {

            if ( preedit.length >= 0 && preedit.length < 5 ) {

                preedit = preedit + pressedKey.text
                MInputMethodQuick.sendPreedit(preedit)

            }  else {

                reset()
                MInputMethodQuick.sendPreedit(preedit)

            }

            handled = true

        } else if ( pressedKey.text === "重" ) {

            if ( preedit.length > 0 && preedit.length < 4 ) {
                preedit = preedit + "?"
                MInputMethodQuick.sendPreedit(preedit)

                handled = true

            } else {

                reset()
                MInputMethodQuick.sendPreedit(preedit)

                handled = true
            }

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

        reset()
        empty()

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

