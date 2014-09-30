import QtQuick 2.0
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0
import com.jolla.xt9cp 1.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0

InputHandler {
    id: handler

    Xt9CpModel {
        id: xt9CpModel

        property bool fetchMany
        property bool strokeInput: inputMethod === "china_stroke"

        fetchCount: fetchMany ? 120 : 20
        mohuEnabled: mohuConfig.value
        inputMode: layoutRow.layout ? layoutRow.layout.inputMode : ""
        inputMethod: layoutRow.layout ? layoutRow.layout.type : ""

        onInputMethodChanged: handler.clearPreedit()
        onInputModeChanged: handler.clearPreedit()
    }

    ConfigurationValue {
        id: mohuConfig

        key: "/sailfish/text_input/mohu_enabled"
        defaultValue: false
    }

    //  TODO:
    // optimize candidate phrase updating: input + setContext() to only do once, avoid on backspace autorepeat

    property bool composingEnabled: !keyboard.inSymView

    onActiveChanged: {
        if (active) {
            xt9CpModel.setContext(MInputMethodQuick.surroundingText.substring(0, MInputMethodQuick.cursorPosition))
        } else {
            handler.clearPreedit()
        }
    }

    topItem: Component {
        Column {
            id: topItem
            width: parent  ? parent.width : 0

            TopItem {
                visible: xt9CpModel.strokeInput && !keyboard.inSymView
                width: parent.width
                backgroundOpacity: 0.20

                Label {
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    text: xt9CpModel.inputString
                }

                MouseArea {
                    // this produces child mouse events for TopItem close gesture
                    anchors.fill: parent
                }
            }

            TopItem {
                id: listTopItem
                width: parent.width

                SilicaListView {
                    id: listView

                    property bool hasMore: composingEnabled && xt9CpModel.maxCount > xt9CpModel.count

                    model: composingEnabled ? xt9CpModel : 0
                    orientation: ListView.Horizontal
                    width: parent.width
                    height: parent.height
                    boundsBehavior: ((!keyboard.expandedPaste && Clipboard.hasText) || hasMore)
                                    ? Flickable.DragOverBounds : Flickable.StopAtBounds
                    header: pasteComponent

                    footer: Item {
                        width: listView.hasMore ? 30 : 0
                        height: listView.height
                        visible: listView.hasMore

                        Image {
                            source: "image://theme/icon-lock-more"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Image {
                            source: "image://theme/icon-lock-more?" + Theme.highlightColor
                            anchors.verticalCenter: parent.verticalCenter
                            opacity: listView.dragging && listView.atXEnd ? 1.0 : 0.0
                            Behavior on opacity { FadeAnimation {} }
                        }
                    }

                    delegate: BackgroundItem {
                        id: backGround
                        onClicked: selectPhrase(model.text, model.index)
                        width: candidateText.width + Theme.paddingLarge * 2
                        height: listTopItem.height

                        Text {
                            id: candidateText
                            anchors.centerIn: parent
                            color: (backGround.down || index === 0) ? Theme.highlightColor : Theme.primaryColor
                            font { pixelSize: Theme.fontSizeSmall; family: Theme.fontFamily }
                            text: model.text
                        }
                    }
                    onCountChanged: positionViewAtBeginning()
                    onDraggingChanged: {
                        if (!dragging) {
                            if (!keyboard.expandedPaste && contentX < -(headerItem.width + Theme.paddingLarge)) {
                                keyboard.expandedPaste = true
                                positionViewAtBeginning()
                            } else if (atXEnd && listView.hasMore) {
                                xt9CpModel.fetchMany = true
                            }
                        }
                    }

                    Connections {
                        target: xt9CpModel
                        onDataChanged: listView.positionViewAtBeginning()
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

                Rectangle {
                    id: phraseDialog

                    parent: keyboard
                    z: 1
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: inputItems.height

                    visible: xt9CpModel.fetchMany
                    color: Theme.highlightDimmerColor
                    opacity: 0.9
                    clip: true

                    MultiPointTouchArea {
                        // prevent events leaking below
                        anchors.fill: parent
                        z: -1
                    }

                    SilicaFlickable {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: closeButton.left

                        contentHeight: gridView.height

                        Flow {
                            id: gridView

                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.leftMargin: Theme.paddingMedium

                            property real cellWidth: width / (keyboard.portraitMode ? 5 : 8)

                            Repeater {
                                model: phraseDialog.visible ? xt9CpModel : 0
                                delegate: BackgroundItem {
                                    id: gridItemBackground

                                    height: Theme.itemSizeSmall
                                    width: Math.ceil((gridText.contentWidth + 2*Theme.paddingMedium) / gridView.cellWidth)
                                           * gridView.cellWidth

                                    onClicked: selectPhraseAndShrink(model.text, model.index)

                                    Text {
                                        id: gridText
                                        anchors.verticalCenter: parent.verticalCenter
                                        x: Theme.paddingMedium
                                        color: gridItemBackground.down ? Theme.highlightColor : Theme.primaryColor
                                        font { pixelSize: Theme.fontSizeSmall; family: Theme.fontFamily }
                                        text: model.text
                                    }
                                }
                            }
                        }
                    }

                    IconButton {
                        id: closeButton

                        anchors {
                            right: parent.right
                            top: parent.top
                            topMargin: Theme.paddingMedium
                        }
                        opacity: 0.6
                        icon.source: "image://theme/icon-close-vkb"
                        onClicked: xt9CpModel.fetchMany = false
                    }
                }
            }
        }
    }

    onComposingEnabledChanged: {
        if (xt9CpModel.inputString.length > 0) {
            MInputMethodQuick.sendCommit(xt9CpModel.inputString)
            xt9CpModel.resetState()
        }
    }

    Component {
        id: pasteComponent
        PasteButton {
            visible: Clipboard.hasText
            onClicked: {
                if (xt9CpModel.inputString.length > 0) {
                    MInputMethodQuick.sendCommit(xt9CpModel.inputString)
                    xt9CpModel.resetState()
                }
                MInputMethodQuick.sendCommit(Clipboard.text)
                keyboard.expandedPaste = false
            }
        }
    }

    Connections {
        target: MInputMethodQuick
        onEditorStateUpdate: {
            if (active) {
                xt9CpModel.setContext(MInputMethodQuick.surroundingText.substring(0, MInputMethodQuick.cursorPosition))
            }
        }
        onCursorPositionChanged: {
            if (active) {
                xt9CpModel.fetchMany = false
            }
        }
    }

    Binding {
        target: keyboard
        property: "chineseOverrideForEnter"
        value: xt9CpModel.inputString.length > 0
    }

    function selectPhrase(phrase, index) {
        console.log("phrase clicked: " + phrase)
        MInputMethodQuick.sendCommit(phrase)
        xt9CpModel.acceptPhrase(index)
        if (xt9CpModel.inputString.length > 0 && !xt9CpModel.strokeInput) {
            MInputMethodQuick.sendPreedit(xt9CpModel.inputString)
        }
    }

    function selectPhraseAndShrink(phrase, index) {
        selectPhrase(phrase, index)
        xt9CpModel.fetchMany = false
    }

    function handleKeyClick() {
        keyboard.expandedPaste = false
        if (pressedKey.text === " ") {
            if (!composingEnabled) {
                return false
            }

            var candidate = xt9CpModel.firstCandidate()
            if (candidate.length > 0) {
                MInputMethodQuick.sendCommit(candidate)
                xt9CpModel.acceptPhrase(0)
                if (!xt9CpModel.strokeInput && xt9CpModel.inputString.length > 0) {
                    // send remaining input string
                    MInputMethodQuick.sendPreedit(xt9CpModel.inputString)
                }

                return true
            } else if (xt9CpModel.inputString.length > 0) {
                if (!xt9CpModel.strokeInput) {
                    MInputMethodQuick.sendCommit(xt9CpModel.inputString)
                }
                xt9CpModel.resetState()
                return true
            }

        } else if (pressedKey.key === Qt.Key_Return) {
            if (xt9CpModel.inputString.length > 0) {
                if (!xt9CpModel.strokeInput) {
                    MInputMethodQuick.sendCommit(xt9CpModel.inputString)
                }
                xt9CpModel.resetState()
                return true
            }

        } else if (pressedKey.key === Qt.Key_Backspace) {
            if (xt9CpModel.inputString.length > 0) {
                xt9CpModel.processBackspace()
                if (!xt9CpModel.strokeInput) {
                    MInputMethodQuick.sendPreedit(xt9CpModel.inputString)
                }

                if (keyboard.shiftState !== ShiftState.LockedShift) {
                    keyboard.shiftState = ShiftState.NoShift
                }

                return true
            }

        } else if (pressedKey.text.length !== 0 && composingEnabled) {
            var processSymbol = xt9CpModel.strokeInput ? xt9CpModel.isStrokeSymbol(pressedKey.text)
                                                       : xt9CpModel.isLetter(pressedKey.text)
            if (xt9CpModel.strokeInput
                  && xt9CpModel.inputString.length > 0
                  && xt9CpModel.count === 0) {
                // previous stroke didn't produce candidates, start over
                xt9CpModel.resetState()
            }

            if (processSymbol) {
                if (xt9CpModel.processSymbol(pressedKey.text)) {
                    if (!xt9CpModel.strokeInput) {
                        MInputMethodQuick.sendPreedit(xt9CpModel.inputString)
                    }
                } else {
                    // something went wrong
                    MInputMethodQuick.sendCommit(xt9CpModel.inputString + pressedKey.text)
                    xt9CpModel.resetState()
                }
            } else {
                if (xt9CpModel.strokeInput) {
                    MInputMethodQuick.sendCommit(pressedKey.text)
                } else {
                    MInputMethodQuick.sendCommit(xt9CpModel.inputString + pressedKey.text)
                }

                xt9CpModel.resetState()
            }

            if (keyboard.shiftState !== ShiftState.LockedShift) {
                keyboard.shiftState = ShiftState.NoShift
            }

            return true
        }

        return false
    }

    function reset() {
        xt9CpModel.resetState()
        xt9CpModel.fetchMany = false
    }

    function phraseCandidates(inputText) {
        return xt9CpModel.phraseCandidates(inputText)
    }

    function clearPreedit() {
        if (xt9CpModel.inputString.length > 0) {
            if (!xt9CpModel.strokeInput) {
                MInputMethodQuick.sendCommit(xt9CpModel.inputString)
            }
            xt9CpModel.resetState()
        }
    }
}
