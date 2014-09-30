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

Row {

    height: parent.height

    ListModel {
        id: layoutModel

        Component.onCompleted: {
            for ( var i = 0; i < canvas.layoutModel.count; i++ ) {
                if ( canvas.layoutModel.get(i).enabled == true && ( canvas.layoutModel.get(i).name == "繁體(倉頡)" || canvas.layoutModel.get(i).name == "繁體(速成)" || canvas.layoutModel.get(i).name == "English(HK)" || canvas.layoutModel.get(i).name == "繁體(筆劃)" ) ) {
                    layoutModel.append( { "code": i, "name": canvas.layoutModel.get(i).name  } )
                }
            }
        }

    }

    Repeater {

        model: layoutModel
        height: parent.height

        MouseArea {

            width: 96
            height: parent.height
            visible: !listView.visible

            Rectangle {
                anchors.fill: parent
                color: layoutModel.get(index).code == canvas.activeIndex? Theme.highlightBackgroundColor: "#00000000"
                opacity: parent.pressed ? 0.8: 0.2
            }

            Text {
                text: name == "繁體(倉頡)"? "倉": ( name == "繁體(速成)"? "速": ( name == "繁體(筆劃)"? "筆": ( name == "English(HK)"? "EN": "" ) ) )
                font.pixelSize: Theme.fontSizeLarge
                color: parent.pressed? Theme.highlightColor: ( layoutModel.get(index).code == canvas.activeIndex? Theme.highlightColor: "#FFFFFF" )
                anchors.centerIn: parent
            }

            onClicked: {
                enabled = false
                if ( canvas.activeIndex !== code ) {
                    canvas.layoutRow.switchLayout(layoutModel.get(index).code)
                }

                enabled = true
            }
        }

    }

}
