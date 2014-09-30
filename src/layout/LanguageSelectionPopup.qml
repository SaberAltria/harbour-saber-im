// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

Item {
    id: selectionPopup

    property int activeCell: -1
    property bool inInitialPosition
    property int pointId

    width: parent.width
    height: MInputMethodQuick.appOrientation == 270 || MInputMethodQuick.appOrientation == 90 ?
            MInputMethodQuick.screenWidth : MInputMethodQuick.screenHeight
    y: parent.height - height
    visible: false

    Rectangle {
        id: popup
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - geometry.languageSelectionMargin * 2
        radius: geometry.popperRadius
        color: Qt.darker(Theme.highlightBackgroundColor, 1.3)
        y: bottomLine - height
        clip: openAnimation.running

        property real bottomLine

        Column {
            id: contentColumn
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
        }
        NumberAnimation on height {
            id: openAnimation
            duration: 32
            easing.type: Easing.OutQuad
            to: contentColumn.height + Theme.paddingLarge
        }
    }

    Component {
        id: listRow
        Row {
            x: parent ? (parent.width - width) * .5 : 0
            height: Theme.itemSizeSmall
        }
    }

    SequentialAnimation {
        id: fadeAnimation
        NumberAnimation {
            duration: 32
            to: 0
            target: selectionPopup
            property: "opacity"
        }
        ScriptAction {
            script: {
                visible = false
                contentColumn.children = []
            }
        }
    }

    function show(touchPoint) {
        inInitialPosition = true
        pointId = touchPoint.pointId
        popup.height = 0
        contentColumn.height = 0
        popup.bottomLine = parent.mapFromItem(touchPoint.pressedKey, 0, 0).y +
                          (height - parent.height) -
                          Theme.paddingLarge
        canvas.captureFullScreen()

        activeCell = canvas.activeIndex

        var rows = new Array

        var cellComponent = Qt.createComponent("LanguageSelectionCell.qml");
        var row = null
        for (var i = 0; i < canvas.layoutModel.count; i++) {
            if (!canvas.layoutModel.get(i).enabled) {
                continue
            }

            if (canvas.layoutModel.enabledCount === 2 && i !== canvas.activeIndex) {
                // In case there's two enabled languages, highlight the inactive one
                // to allow quick switching to that layout.
                activeCell = i
            }

            if (row === null || row.width > popup.width -
                                geometry.languageSelectionPopupRowMargin) {
                row = listRow.createObject(null)
                contentColumn.height += row.height
                rows.push(row)
            }

            var cell = cellComponent.createObject(row,
                                                  {"index": i,
                                                   "text": canvas.layoutModel.get(i).name})
            row.width += cell.width
        }

        for (var j = rows.length-1; j >= 0; j--) {
            rows[j].parent = contentColumn
        }

        opacity = 1
        visible = true
        openAnimation.start()
    }
    function hide() {
        if (visible) {
            fadeAnimation.start()
            canvas.updateIMArea()
        }
    }
    function handleMove(touchPoint) {
        if (touchPoint.pointId !== pointId)
            return

        if (inInitialPosition) {
            var deltaX = touchPoint.x-touchPoint.startX
            var deltaY = touchPoint.y-touchPoint.startY
            if (deltaX*deltaX + deltaY*deltaY <
                geometry.languageSelectionInitialDeltaSquared) {
                return
            }
        }

        inInitialPosition = false

        var oldActiveCell = activeCell

        var yInContent = parent.mapToItem(contentColumn, touchPoint.x, touchPoint.y).y
        if (yInContent < 0 || yInContent > contentColumn.height) {
            activeCell = -1
        }

        var item = contentColumn
        do {
            if (item.hasOwnProperty("index")) {
                activeCell = item.index
                break
            }
            var pos = parent.mapToItem(item, touchPoint.x, touchPoint.y)
            pos.y -= geometry.languageSelectionTouchDelta
            item = item.childAt(pos.x, pos.y)
        } while (item);

        if (oldActiveCell !== activeCell && activeCell >= 0) {
            SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
            buttonPressEffect.play()
        }
    }
}
