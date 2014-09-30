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

    function check() {
        if ( search.text.length > 0 && search.text.length < 2 ) {

            var sql = 'SELECT keys FROM cangJie3 WHERE character = "' + search.text + '"'
            var cangJie3 = database.load(sql)

            sql = 'SELECT keys FROM cangJie5 WHERE character = "' + search.text + '"'
            var cangJie5 = database.load(sql)

            sql = 'SELECT keys FROM stroke WHERE character = "' + search.text + '"'
            var stroke =database.load(sql)

            sql = 'SELECT keys FROM canton WHERE character = "' + search.text + '"'
            var canton = database.load(sql)

            output.text = "倉頡三版：" + cangJie3 + "<br>"
            output.text += "倉頡五版：" + cangJie5 + "<br>"
            output.text += "繁體筆劃：" + stroke + "<br>"
            output.text += "粵語拼音：" + canton
        } else {
            output.text = "輸入有誤"
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
            title: "Saber 輸入法 工具"
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
                text: "查字易"
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
                anchors.rightMargin: 16

                height: childrenRect.height

                TextField {
                    id: search
                    width: parent.width - button.width
                    placeholderText: "多的是，你不知道的字"
                    onClicked: {
                        search.text = ""
                    }

                    onTextChanged: {
                        if ( search.text.length > 1 ) {
                            search.text = seach.text.slice(0,1)
                        }
                    }

                    EnterKey.onClicked: check()
                }
                BackgroundItem {
                    id: button
                    width: 96
                    Label { anchors.centerIn: parent; text: "查詢" }

                    onClicked: {
                        check()
                    }
                }
            }

            Text {
                id: output
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                color: Theme.highlightColor
                wrapMode: Text.WrapAnywhere
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: Text.AlignLeft
            }

            Label {
                anchors.left: parent.left
                anchors.leftMargin: 16
                font.pixelSize: 22
                color: Theme.highlightColor
                text: "* 速成三版及五版分別對應倉頡版本之首尾碼"
            }

            Label {
                anchors.right: parent.right
                anchors.rightMargin: 16
                font.pixelSize: 26
                color: Theme.highlightColor
                text: "詞庫工具"
            }

            BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: "備份詞庫" }
                onClicked: {
                    remorse.execute(column, "正在處理中…", function() { settings.backup() }, 2000 )
                }
            }

            Label {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.right: parent.right
                anchors.rightMargin: 16
                font.pixelSize: 22
                color: Theme.highlightColor
                wrapMode: Text.WrapAnywhere
                text: "* 備份到 USB 模式下 Saber 文件夾 ( /home/nemo/Saber )"
            }

            BackgroundItem {
                width: parent.width
                Label { anchors.centerIn: parent; text: "還原詞庫" }
                onClicked: {


                    remorse.execute(column, "正在處理中…", function() { settings.restore() }, 2000 )
                }
            }

            Label {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.right: parent.right
                anchors.rightMargin: 16
                font.pixelSize: 22
                color: Theme.highlightColor
                wrapMode: Text.WrapAnywhere
                text: "* 由 USB 模式下 Saber 文件夾 ( /home/nemo/Saber ) 還原"
            }

        }

    }

}



