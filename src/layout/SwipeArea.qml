/*
 * Copyright (C) 2014 Jolla ltd. and/or its subsidiary(-ies). All rights reserved.
 *
 * Contact: Antti Seppala <antti.seppala@jollamobile.com>
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Jolla ltd nor the names of its contributors may be
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
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0

CharacterKey {

    width: punctuationKeyWidthNarrow
    separator: true

    Text {
        id: label
        text: "1234"
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        propagateComposedEvents: true
        preventStealing: true
        hoverEnabled: true

        property int angle: 0
        property int distance: 0
        property bool autoRepeat: false
        property point start: Qt.point(0, 0);
        property int threshold: 16 * (height * 2 > width ? 2 : 1 )
        property bool activate: false

        onPressed: {
            start = Qt.point(mouse.x, mouse.y)
            angle = 0
            distance = 0
            var pos = mapToItem(layout, mouse.x, mouse.y)
            mouse.accepted = true
        }

        onReleased: {
            var pos = mapToItem(layout, mouse.x, mouse.y)
            mouse.accepted = true
            if ( activate == true ) {
                canvas.layoutRow.switchLayout(20)
            }
            activate = false
        }

        onPositionChanged: {

            angle = Math.atan2(mouse.y - start.y, mouse.x - start.x) * 360 / Math.PI / 2 + 180
            var d = Math.sqrt(Math.pow(mouse.x - start.x, 2) + Math.pow(mouse.y - start.y, 2))
            distance = Math.round(d / threshold)
            var pos = mapToItem(layout, mouse.x, mouse.y)

            if ( distance > 2 && angle >= 0 && angle <= 359 ){
                activate = true;
            }

        }
    }
}



/*

    MouseArea {
        anchors.fill: parent
        enabled: useMouseEvents.value
        propagateComposedEvents: true
        preventStealing: true
        hoverEnabled: true

        property int angle: 0
        property int distance: 0
        property bool autoRepeat: false
        property point start: Qt.point(0, 0);
        property int threshold: 16 * (height * 2 > width ? 2 : 1 )
        property bool activate: false

        onPressed: {
            start = Qt.point(mouse.x, mouse.y)
            angle = 0
            distance = 0
            var pos = mapToItem(keyboard, mouse.x, mouse.y)
            mouse.accepted = true
        }

        onReleased: {
            var pos = mapToItem(keyboard, mouse.x, mouse.y)
            mouse.accepted = true
            if ( activate == true ) {
                canvas.layoutRow.switchLayout(20)
            }
            activate = false
        }

        onPositionChanged: {

            angle = Math.atan2(mouse.y - start.y, mouse.x - start.x) * 360 / Math.PI / 2 + 180
            var d = Math.sqrt(Math.pow(mouse.x - start.x, 2) + Math.pow(mouse.y - start.y, 2))
            distance = Math.round(d / threshold)
            var pos = mapToItem(keyboard, mouse.x, mouse.y)

            if ( distance > 2 && angle >= 0 && angle <= 359 ){
                activate = true
            }

        }
    }


  */













