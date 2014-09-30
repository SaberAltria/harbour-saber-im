/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.saber.engine 1.0

Page {
    id: root

    onStatusChanged: {
        if ( status === PageStatus.Active ) {
            pageStack.pushAttached(editor)
        }
    }


    RemorseItem { id: remorse }

    SilicaFlickable {
        anchors.fill: parent
        clip: true
        contentHeight: header.height + column.height

        VerticalScrollDecorator {  }

        PageHeader {
            id: header
            title: "Saber 輸入法 設定"
        }

        Settings {
            id: settings
        }

        Database {
            id: database
            Component.onCompleted: {
                database.initial("tables.sqlite");
            }


        }

        Column {
            id: column
            width: parent.width
            anchors.top: header.bottom
            spacing: 16

            Label {
                anchors.right: parent.right
                anchors.rightMargin: 16
                font.pixelSize: 26
                color: Theme.highlightColor
                text: "測試"
            }

            TextField {
                width: parent.width
                placeholderText: "內容"
            }

            Label {
                anchors.right: parent.right
                anchors.rightMargin: 16
                font.pixelSize: 26
                color: Theme.highlightColor
                text: "按鍵設定"
            }

            TextSwitch {
                text: "單字調頻"
                description: "經常輸入的單字將會調整到候選字欄較前的位置"
                checked: settings.load("keys") === "true"? true: false
                onCheckedChanged: checked? settings.save("keys", "true"): settings.save("keys", "false")
            }

            TextSwitch {
                text: "組詞調頻"
                description: "經常輸入的聯想詞語將會調整到候選字欄較前的位置"
                checked: settings.load("word") === "true"? true: false
                onCheckedChanged: checked? settings.save("word", "true"): settings.save("word", "false")
            }

            TextSwitch {
                text: "空白鍵"
                description: "自動輸入候選欄首字"
                checked: settings.load("spacebar") === "true"? true: false
                onCheckedChanged: checked? settings.save("spacebar", "true"): settings.save("spacebar", "false")
            }

            TextSwitch {
                text: "Emoji 鍵盤"
                description: "配合 WhatsApp ( Mitakuuluu ) 使用"
                checked: settings.load("emoji") === "true"? true: false
                onCheckedChanged: checked? settings.save("emoji", "true"): settings.save("emoji", "false")
            }


            Label {
                anchors.right: parent.right
                anchors.rightMargin: 16
                font.pixelSize: 26
                color: Theme.highlightColor
                text: "詞庫設定"
            }

            BackgroundItem {

                width: parent.width
                Label { anchors.centerIn: parent; text: "清理" }

                onClicked: {
                    remorse.execute(column, "正在處理中…", function() { database.update("VACUUM") }, 2000 )
                }

            }

            Label {
                anchors.left: parent.left
                anchors.leftMargin: 16
                font.pixelSize: 22
                color: Theme.highlightColor
                text: "* 定期清理詞庫有助提升輸入法速度"
            }

            BackgroundItem {

                width: parent.width
                Label { anchors.centerIn: parent; text: "重啟服務" }
                onClicked: {
                    remorse.execute(column, "正在處理中…", function() { settings.restart() }, 2000 )
                }

            }

            Label {
                anchors.left: parent.left
                anchors.leftMargin: 16
                font.pixelSize: 22
                color: Theme.highlightColor
                text: "* 所有設定均需重啟服務後才生效"
            }

            Label {
                anchors.right: parent.right
                anchors.rightMargin: 16
                font.pixelSize: 26
                color: Theme.highlightColor
                text: "關於作者"
            }


            BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: "http://saberaltria.co.uk/" }
                onClicked: Qt.openUrlExternally("http://saberaltria.co.uk")
            }



        }

    }

}



