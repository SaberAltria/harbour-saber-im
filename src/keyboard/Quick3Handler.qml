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
import com.jolla.keyboard 1.0
import harbour.saber.engine 1.0
import ".."
import "../.."


InputHandler {

    property var trie
    property bool trie_built: false
    property bool fetchMany: false

    property string preedit
    property string sql
    property variant result

    Database {
        id: database
        Component.onCompleted: {
            database.initial("tables.sqlite");
        }

        Component.onDestruction: {
            database.close()
        }
    }

    Settings {
        id: settings
        property string spacebar
        Component.onCompleted: {
            spacebar = settings.load("spacebar")
        }
    }


    ListModel {
        id: candidateList

        signal candidatesUpdated

        function loadKY(keys) {

            if ( keys.length === 1 || ( keys.length > 2 && keys.length < 6 ) ) {

                empty()

                if ( keys.match(/\?/) !== null ) {
                    sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 16'
                } else {
                    sql = 'SELECT character FROM cangJie3 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY sorting + frequency DESC LIMIT 0, 16'
                }

            } else if ( keys.length === 2 ) {

                empty()

                keys = keys.slice(0,1) + "*" + keys.slice(1,2)
                sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 16'

            }

            result = database.load(sql)

            if ( result.length > 0 ) {
                for ( var i = 0; i < result.length; i++ ) {
                    candidateList.append( { "candidate": result[i] } )
                }

                candidatesUpdated()
            }

        }

        function loadMKY(keys) {

            if ( candidateList.count <= 16 ) {

                if ( keys.length === 1 || ( keys.length > 2 && keys.length < 6 ) ) {

                    if ( keys.match(/\?/) !== null ) {
                        sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 256'
                    } else {
                        sql = 'SELECT character FROM cangJie3 WHERE ( keys >= "'+ keys +'" AND keys < "' + keys + 'Ｚ")' + ' ORDER BY sorting + frequency DESC LIMIT 0, 256'
                    }

                } else if ( keys.length === 2 ) {

                    keys = keys.slice(0,1) + "*" + keys.slice(1,2)
                    sql = 'SELECT character FROM cangJie3 WHERE keys GLOB "' + keys + '" ORDER BY sorting + frequency DESC LIMIT 0, 256'

                }

                result = database.load(sql)

                if ( result.length > 0 ) {
                    for ( var i = candidateList.count; i < result.length; i++ ) {
                        candidateList.append( { "candidate": result[i] } )
                    }
                }

                candidatesUpdated()
            }
        }

        function loadWD(character) {

            empty()

            character = '"' + character + '"'
            sql = 'SELECT phrase FROM word WHERE character=' + character + ' ORDER BY sorting + frequency DESC LIMIT 0, 64'
            result = database.load(sql)

            for ( var i = 0; i < result.length; i++ ) {
                candidateList.append( { "candidate": result[i] } )
            }

            candidatesUpdated()
        }

        function pushKY(character) {

            character = '"' + character + '"'
            sql = 'UPDATE cangJie3 SET frequency=frequency+320 WHERE character=' + character
            database.update(sql)

        }

        function pushWD(phrase) {

            phrase = '"' + phrase + '"'
            sql = 'UPDATE word SET frequency=frequency+320 WHERE phrase='+ phrase
            database.update(sql)

        }
    }

    topItem: Column {
        id: column
        width: parent.width
        height: !fetchMany? 80: dialog.height

        Rectangle {
            id: popup
            z: 8192
            property bool containsMouse
            visible: false
            opacity: visble? 1: 0
            Behavior on opacity { FadeAnimation {  } }
            width: clearLabel.width + geometry.clearPasteMargin
            height: clearLabel.height + geometry.clearPasteMargin
            x: 0
            anchors.bottom: parent.top
            radius: geometry.popperRadius
            color: Qt.darker(Theme.highlightBackgroundColor, 1.2)

            onVisibleChanged: containsMouse = false

            Label {
                id: clearLabel
                anchors.centerIn: parent
                color: parent.containsMouse ? Theme.primaryColor : Theme.highlightColor
                text: qsTrId("text_input-la-clear_clipboard")
            }
        }

        Row {
            id: row
            width: parent.width  
            height: 80
            visible: !fetchMany

            SilicaListView {
                id: listView
                orientation: ListView.Horizontal
                height: parent.height
                width: footer.visible? parent.width - 52: parent.width
                Behavior on width{ SmoothedAnimation{ easing.type: Easing.InQuad } }

                clip: true
                z: 256

                cacheBuffer: listView.contentWidth
                flickDeceleration: 128
                boundsBehavior: ( !keyboard.expandedPaste && Clipboard.hasText ) || ( footer.visible ) ? Flickable.DragOverBounds : Flickable.StopAtBounds
                model: candidateList

                header: Component {
                    id: header
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
                            if (popup.visible && popup.containsMouse)
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
                }

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

                delegate: BackgroundItem {
                    width: textH.width + Theme.paddingLarge * 2
                    height: parent.height

                    onClicked: {
                        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
                        buttonPressEffect.play()

                        if ( preedit !== "" ) {
                            commit(model.candidate)
                            candidateList.pushKY(model.candidate)
                            candidateList.loadWD(model.candidate)
                        } else {
                            commit(model.candidate)
                            candidateList.pushWD(model.candidate)
                            empty()
                        }
                    }

                    Text {
                        id: textH
                        anchors.centerIn: parent
                        color: (parent.down || index === 0) ? Theme.highlightColor : Theme.primaryColor
                        font { pixelSize: Theme.fontSizeMedium; family: Theme.fontFamily }
                        text: candidate
                    }
                }

                Connections {
                    target: candidateList
                    onCandidatesUpdated: listView.positionViewAtBeginning()
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

            BackgroundItem {
                id: footer
                width: 52
                height: parent.height
                visible: candidateList.count >= 8? true: false
                opacity: visible? 1: 0
                Behavior on opacity { FadeAnimation {  } }
                z: 768

                Image {
                    source: "image://theme/icon-lock-more?" + Theme.highlightColor
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
                        buttonPressEffect.play()

                        if ( preedit !== "" && candidateList.count >= 8 ) {
                            candidateList.loadMKY(preedit)
                        }

                        fetchMany = true

                    }
                }
            }
        }

        Rectangle {
            id: dialog
            z: 1024
            visible: fetchMany
            opacity: visible? 1: 0
            color: "#00000000"
            width: parent.width
            height: flow.height >= 320? ( width == 960? 160: 320 ) : flow.height
            Behavior on opacity { FadeAnimation { easing.type: Easing.InQuad } }

            SilicaFlickable {
                height: parent.height
                anchors.left: parent.left
                anchors.right: closeButton.left
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
                        model: candidateList


                        delegate: BackgroundItem {
                            width: textV.width + Theme.paddingMedium * 2
                            height: 80
                            opacity: visible? 1: 0
                            Behavior on opacity { FadeAnimation {  } }

                            onClicked: {

                                fetchMany = false


                                if ( preedit !== "" ) {
                                    commit(model.candidate)
                                    candidateList.pushKY(model.candidate)
                                    candidateList.loadWD(model.candidate)



                                } else {
                                    commit(model.candidate)
                                    candidateList.pushWD(model.candidate)
                                    empty()

                                }
                            }

                            Text {

                                id: textV
                                anchors.centerIn: parent
                                color: ( parent.down || index === 0 ) ? Theme.highlightColor : Theme.primaryColor
                                font { pixelSize: Theme.fontSizeMedium; family: Theme.fontFamily }
                                text: candidate
                            }
                        }

                    }

                }
            }

            BackgroundItem {
                id: closeButton
                width: 52
                height: parent.height
                anchors.right: parent.right

                Image {
                    width: 32
                    height: 32
                    opacity: 0.6
                    anchors.centerIn: parent
                    source: "image://theme/icon-close-vkb"
                }

                onClicked: {
                    SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
                    buttonPressEffect.play()
                   fetchMany = false

                }

            }


        }

    }

    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        if ( pressedKey.key === Qt.Key_Space ) {

            if ( preedit.length > 0 && candidateList.count > 0 && settings.spacebar == "true" ) {
                preedit = ""
                commit(candidateList.get(0).candidate)
                candidateList.pushKY(candidateList.get(0).candidate)
                candidateList.loadWD(candidateList.get(0).candidate)

                handled = true

            } else if ( preedit.length == 0 && candidateList.count > 0 && settings.spacebar == "true" ) {
                commit(candidateList.get(0).candidate)
                candidateList.pushWD(candidateList.get(0).candidate)
                candidateList.loadWD(candidateList.get(0).candidate)

                handled = true

            } else {
                commit(" ")
                handled = true

            }


        } else if ( pressedKey.key === Qt.Key_Return ) {

            if ( preedit.length > 0 ) {
                commit(preedit)
            }  else {
                MInputMethodQuick.sendKey(Qt.Key_Return)
            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Backspace ) {

             if ( preedit.length > 0 ) {

                preedit = preedit.slice(0, preedit.length-1)
                MInputMethodQuick.sendPreedit(preedit)
                candidateList.loadKY(preedit)

            } else if ( candidateList.count > 0 ) {

                 empty()

             } else {
                MInputMethodQuick.sendKey(Qt.Key_Backspace)
            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Shift ) {

                    reset()
                    empty()
                    handled = true

            } else if ( pressedKey.text.match(/[日月金木水火土竹戈十大中一弓人心手口尸廿山女田卜難]/) !== null || ( pressedKey.text == "重" && preedit.length == 0 ) ) {

            if ( preedit.length >= 0 && preedit.length < 5 ) {

                preedit = preedit + pressedKey.text
                MInputMethodQuick.sendPreedit(preedit)

                candidateList.loadKY(preedit)

                handled = true
            }  else {

                reset()
                MInputMethodQuick.sendPreedit(preedit)

                handled = true
            }

        } else if ( pressedKey.text == "重") {

            if ( preedit.length > 0 && preedit.length < 4 ) {
                preedit = preedit + "?"
                MInputMethodQuick.sendPreedit(preedit)
                candidateList.loadKY(preedit)

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

    function reset() {
        preedit = ""
    }

    function commit(text) {
        MInputMethodQuick.sendCommit(text)
        reset()
    }

    function empty() {
        candidateList.clear()
    }

}
