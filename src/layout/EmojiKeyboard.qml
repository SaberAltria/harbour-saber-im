import QtQuick 2.0
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0
import harbour.saber.engine 1.0

SilicaGridView {

    Database {
        id: database

        Component.onCompleted: {

            database.initial("tables.sqlite")
            var sql

            sql = "SELECT character FROM emoji"
            var usual = database.load(sql)

            if ( usual[0] !== "" ) {

                sql = "SELECT icon FROM emoji"
                var icon = database.load(sql)

                usual = usual[0].split(",")
                icon = icon[0].split(",")

                for ( var i = 0; i < usual.length; i++ ) {
                    frequent.append( { "emoji": usual[i], "icon": icon[i] } )
                }
            }
        }
    }

    Connections {
        target: keyboard.layout
        onInEmojiViewChanged: {
            if ( keyboard.layout.inEmojiView === false && frequent.count > 0 ) {
                var usual = new Array
                var icon = new Array
                var sql

                for ( var i = 0; i < Math.min(frequent.count, 32); i++ ) {
                    usual[i] = frequent.get(i).emoji
                    icon[i] = frequent.get(i).icon
                }

                sql = 'UPDATE emoji SET character ="' + usual.toString() + '" WHERE keys = 0'
                database.update(sql)

                sql = 'UPDATE emoji SET icon ="' + icon.toString() + '" WHERE keys = 0'
                database.update(sql)
            }
        }
    }

    ListModel {
        id: frequent
    }

    ListModel {
        id: face
        ListElement { emoji: "😄" }
        ListElement { emoji: "😃" }
        ListElement { emoji: "😀" }
        ListElement { emoji: "😊" }
        ListElement { emoji: "☺" }
        ListElement { emoji: "😉" }
        ListElement { emoji: "😍" }
        ListElement { emoji: "😘" }
        ListElement { emoji: "😚" }
        ListElement { emoji: "😗" }
        ListElement { emoji: "😙" }
        ListElement { emoji: "😜" }
        ListElement { emoji: "😝" }
        ListElement { emoji: "😛" }
        ListElement { emoji: "😳" }
        ListElement { emoji: "😁" }
        ListElement { emoji: "😔" }
        ListElement { emoji: "😌" }
        ListElement { emoji: "😒" }
        ListElement { emoji: "😞" }
        ListElement { emoji: "😣" }
        ListElement { emoji: "😢" }
        ListElement { emoji: "😂" }
        ListElement { emoji: "😭" }
        ListElement { emoji: "😪" }
        ListElement { emoji: "😥" }
        ListElement { emoji: "😰" }
        ListElement { emoji: "😅" }
        ListElement { emoji: "😓" }
        ListElement { emoji: "😩" }
        ListElement { emoji: "😫" }
        ListElement { emoji: "😨" }
        ListElement { emoji: "😱" }
        ListElement { emoji: "😠" }
        ListElement { emoji: "😡" }
        ListElement { emoji: "😤" }
        ListElement { emoji: "😖" }
        ListElement { emoji: "😆" }
        ListElement { emoji: "😋" }
        ListElement { emoji: "😷" }
        ListElement { emoji: "😎" }
        ListElement { emoji: "😴" }
        ListElement { emoji: "😵" }
        ListElement { emoji: "😲" }
        ListElement { emoji: "😟" }
        ListElement { emoji: "😦" }
        ListElement { emoji: "😧" }
        ListElement { emoji: "😈" }
        ListElement { emoji: "👿" }
        ListElement { emoji: "😮" }
        ListElement { emoji: "😬" }
        ListElement { emoji: "😐" }
        ListElement { emoji: "😕" }
        ListElement { emoji: "😯" }
        ListElement { emoji: "😶" }
        ListElement { emoji: "😇" }
        ListElement { emoji: "😏" }
        ListElement { emoji: "😑" }
        ListElement { emoji: "👲" }
        ListElement { emoji: "👳" }
        ListElement { emoji: "👮" }
        ListElement { emoji: "👷" }
        ListElement { emoji: "💂" }
        ListElement { emoji: "👶" }
        ListElement { emoji: "👦" }
        ListElement { emoji: "👧" }
        ListElement { emoji: "👨" }
        ListElement { emoji: "👩" }
        ListElement { emoji: "👴" }
        ListElement { emoji: "👵" }
        ListElement { emoji: "👱" }
        ListElement { emoji: "👼" }
        ListElement { emoji: "👸" }
        ListElement { emoji: "😺" }
        ListElement { emoji: "😸" }
        ListElement { emoji: "😻" }
        ListElement { emoji: "😽" }
        ListElement { emoji: "😼" }
        ListElement { emoji: "🙀" }
        ListElement { emoji: "😿" }
        ListElement { emoji: "😹" }
        ListElement { emoji: "😾" }
        ListElement { emoji: "👹" }
        ListElement { emoji: "👺" }
        ListElement { emoji: "🙈" }
        ListElement { emoji: "🙉" }
        ListElement { emoji: "🙊" }
        ListElement { emoji: "💀" }
        ListElement { emoji: "👽" }
        ListElement { emoji: "💩" }
        ListElement { emoji: "🔥" }
        ListElement { emoji: "✨" }
        ListElement { emoji: "🌟" }
        ListElement { emoji: "💫" }
        ListElement { emoji: "💥" }
        ListElement { emoji: "💢" }
        ListElement { emoji: "💦" }
        ListElement { emoji: "💧" }
        ListElement { emoji: "💤" }
        ListElement { emoji: "💨" }
        ListElement { emoji: "👂" }
        ListElement { emoji: "👀" }
        ListElement { emoji: "👃" }
        ListElement { emoji: "👅" }
        ListElement { emoji: "👄" }
        ListElement { emoji: "👍" }
        ListElement { emoji: "👎" }
        ListElement { emoji: "👌" }
        ListElement { emoji: "👊" }
        ListElement { emoji: "✊" }
        ListElement { emoji: "✌" }
        ListElement { emoji: "👋" }
        ListElement { emoji: "✋" }
        ListElement { emoji: "👐" }
        ListElement { emoji: "👆" }
        ListElement { emoji: "👇" }
        ListElement { emoji: "👉" }
        ListElement { emoji: "👈" }
        ListElement { emoji: "🙌" }
        ListElement { emoji: "🙏" }
        ListElement { emoji: "☝" }
        ListElement { emoji: "👏" }
        ListElement { emoji: "💪" }
        ListElement { emoji: "🚶" }
        ListElement { emoji: "🏃" }
        ListElement { emoji: "💃" }
        ListElement { emoji: "👫" }
        ListElement { emoji: "👪" }
        ListElement { emoji: "👬" }
        ListElement { emoji: "👭" }
        ListElement { emoji: "💏" }
        ListElement { emoji: "💑" }
        ListElement { emoji: "👯" }
        ListElement { emoji: "🙆" }
        ListElement { emoji: "🙅" }
        ListElement { emoji: "💁" }
        ListElement { emoji: "🙋" }
        ListElement { emoji: "💆" }
        ListElement { emoji: "💇" }
        ListElement { emoji: "💅" }
        ListElement { emoji: "👰" }
        ListElement { emoji: "🙎" }
        ListElement { emoji: "🙍" }
        ListElement { emoji: "🙇" }
        ListElement { emoji: "🎩" }
        ListElement { emoji: "👑" }
        ListElement { emoji: "👒" }
        ListElement { emoji: "👟" }
        ListElement { emoji: "👞" }
        ListElement { emoji: "👡" }
        ListElement { emoji: "👠" }
        ListElement { emoji: "👢" }
        ListElement { emoji: "👕" }
        ListElement { emoji: "👔" }
        ListElement { emoji: "👚" }
        ListElement { emoji: "👗" }
        ListElement { emoji: "🎽" }
        ListElement { emoji: "👖" }
        ListElement { emoji: "👘" }
        ListElement { emoji: "👙" }
        ListElement { emoji: "💼" }
        ListElement { emoji: "👜" }
        ListElement { emoji: "👝" }
        ListElement { emoji: "👛" }
        ListElement { emoji: "👓" }
        ListElement { emoji: "🎀" }
        ListElement { emoji: "🌂" }
        ListElement { emoji: "💄" }
        ListElement { emoji: "💛" }
        ListElement { emoji: "💙" }
        ListElement { emoji: "💜" }
        ListElement { emoji: "💚" }
        ListElement { emoji: "❤" }
        ListElement { emoji: "💔" }
        ListElement { emoji: "💗" }
        ListElement { emoji: "💓" }
        ListElement { emoji: "💕" }
        ListElement { emoji: "💖" }
        ListElement { emoji: "💞" }
        ListElement { emoji: "💘" }
        ListElement { emoji: "💌" }
        ListElement { emoji: "💋" }
        ListElement { emoji: "💍" }
        ListElement { emoji: "💎" }
        ListElement { emoji: "👤" }
        ListElement { emoji: "👥" }
        ListElement { emoji: "💬" }
        ListElement { emoji: "👣" }
        ListElement { emoji: "💭" }
    }

    ListModel {
        id: nature
        ListElement { emoji: "🐶" }
        ListElement { emoji: "🐺" }
        ListElement { emoji: "🐱" }
        ListElement { emoji: "🐭" }
        ListElement { emoji: "🐹" }
        ListElement { emoji: "🐰" }
        ListElement { emoji: "🐸" }
        ListElement { emoji: "🐯" }
        ListElement { emoji: "🐨" }
        ListElement { emoji: "🐻" }
        ListElement { emoji: "🐷" }
        ListElement { emoji: "🐽" }
        ListElement { emoji: "🐮" }
        ListElement { emoji: "🐗" }
        ListElement { emoji: "🐵" }
        ListElement { emoji: "🐒" }
        ListElement { emoji: "🐴" }
        ListElement { emoji: "🐑" }
        ListElement { emoji: "🐘" }
        ListElement { emoji: "🐼" }
        ListElement { emoji: "🐧" }
        ListElement { emoji: "🐦" }
        ListElement { emoji: "🐤" }
        ListElement { emoji: "🐥" }
        ListElement { emoji: "🐣" }
        ListElement { emoji: "🐔" }
        ListElement { emoji: "🐍" }
        ListElement { emoji: "🐢" }
        ListElement { emoji: "🐛" }
        ListElement { emoji: "🐝" }
        ListElement { emoji: "🐜" }
        ListElement { emoji: "🐞" }
        ListElement { emoji: "🐌" }
        ListElement { emoji: "🐙" }
        ListElement { emoji: "🐚" }
        ListElement { emoji: "🐠" }
        ListElement { emoji: "🐟" }
        ListElement { emoji: "🐬" }
        ListElement { emoji: "🐳" }
        ListElement { emoji: "🐋" }
        ListElement { emoji: "🐄" }
        ListElement { emoji: "🐏" }
        ListElement { emoji: "🐀" }
        ListElement { emoji: "🐃" }
        ListElement { emoji: "🐅" }
        ListElement { emoji: "🐇" }
        ListElement { emoji: "🐉" }
        ListElement { emoji: "🐎" }
        ListElement { emoji: "🐐" }
        ListElement { emoji: "🐓" }
        ListElement { emoji: "🐕" }
        ListElement { emoji: "🐖" }
        ListElement { emoji: "🐁" }
        ListElement { emoji: "🐂" }
        ListElement { emoji: "🐲" }
        ListElement { emoji: "🐡" }
        ListElement { emoji: "🐊" }
        ListElement { emoji: "🐫" }
        ListElement { emoji: "🐪" }
        ListElement { emoji: "🐆" }
        ListElement { emoji: "🐈" }
        ListElement { emoji: "🐩" }
        ListElement { emoji: "🐾" }
        ListElement { emoji: "💐" }
        ListElement { emoji: "🌸" }
        ListElement { emoji: "🌷" }
        ListElement { emoji: "🍀" }
        ListElement { emoji: "🌹" }
        ListElement { emoji: "🌻" }
        ListElement { emoji: "🌺" }
        ListElement { emoji: "🍁" }
        ListElement { emoji: "🍃" }
        ListElement { emoji: "🍂" }
        ListElement { emoji: "🌿" }
        ListElement { emoji: "🌾" }
        ListElement { emoji: "🍄" }
        ListElement { emoji: "🌵" }
        ListElement { emoji: "🌴" }
        ListElement { emoji: "🌲" }
        ListElement { emoji: "🌳" }
        ListElement { emoji: "🌰" }
        ListElement { emoji: "🌱" }
        ListElement { emoji: "🌼" }
        ListElement { emoji: "🌐" }
        ListElement { emoji: "🌞" }
        ListElement { emoji: "🌝" }
        ListElement { emoji: "🌚" }
        ListElement { emoji: "🌑" }
        ListElement { emoji: "🌒" }
        ListElement { emoji: "🌓" }
        ListElement { emoji: "🌔" }
        ListElement { emoji: "🌕" }
        ListElement { emoji: "🌖" }
        ListElement { emoji: "🌗" }
        ListElement { emoji: "🌘" }
        ListElement { emoji: "🌜" }
        ListElement { emoji: "🌛" }
        ListElement { emoji: "🌙" }
        ListElement { emoji: "🌍" }
        ListElement { emoji: "🌎" }
        ListElement { emoji: "🌏" }
        ListElement { emoji: "🌋" }
        ListElement { emoji: "🌌" }
        ListElement { emoji: "🌠" }
        ListElement { emoji: "⭐" }
        ListElement { emoji: "☀" }
        ListElement { emoji: "⛅" }
        ListElement { emoji: "☁" }
        ListElement { emoji: "⚡" }
        ListElement { emoji: "☔" }
        ListElement { emoji: "❄" }
        ListElement { emoji: "⛄" }
        ListElement { emoji: "🌀" }
        ListElement { emoji: "🌁" }
        ListElement { emoji: "🌈" }
        ListElement { emoji: "🌊" }
    }

    ListModel {
        id: object
        ListElement { emoji: "🎍" }
        ListElement { emoji: "💝" }
        ListElement { emoji: "🎎" }
        ListElement { emoji: "🎒" }
        ListElement { emoji: "🎓" }
        ListElement { emoji: "🎏" }
        ListElement { emoji: "🎆" }
        ListElement { emoji: "🎇" }
        ListElement { emoji: "🎐" }
        ListElement { emoji: "🎑" }
        ListElement { emoji: "🎃" }
        ListElement { emoji: "👻" }
        ListElement { emoji: "🎅" }
        ListElement { emoji: "🎄" }
        ListElement { emoji: "🎁" }
        ListElement { emoji: "🎋" }
        ListElement { emoji: "🎉" }
        ListElement { emoji: "🎊" }
        ListElement { emoji: "🎈" }
        ListElement { emoji: "🎌" }
        ListElement { emoji: "🔮" }
        ListElement { emoji: "🎥" }
        ListElement { emoji: "📷" }
        ListElement { emoji: "📹" }
        ListElement { emoji: "📼" }
        ListElement { emoji: "💿" }
        ListElement { emoji: "📀" }
        ListElement { emoji: "💽" }
        ListElement { emoji: "💾" }
        ListElement { emoji: "💻" }
        ListElement { emoji: "📱" }
        ListElement { emoji: "☎" }
        ListElement { emoji: "📞" }
        ListElement { emoji: "📟" }
        ListElement { emoji: "📠" }
        ListElement { emoji: "📡" }
        ListElement { emoji: "📺" }
        ListElement { emoji: "📻" }
        ListElement { emoji: "🔊" }
        ListElement { emoji: "🔉" }
        ListElement { emoji: "🔈" }
        ListElement { emoji: "🔇" }
        ListElement { emoji: "🔔" }
        ListElement { emoji: "🔕" }
        ListElement { emoji: "📢" }
        ListElement { emoji: "📣" }
        ListElement { emoji: "⏳" }
        ListElement { emoji: "⌛" }
        ListElement { emoji: "⏰" }
        ListElement { emoji: "⌚" }
        ListElement { emoji: "🔓" }
        ListElement { emoji: "🔒" }
        ListElement { emoji: "🔏" }
        ListElement { emoji: "🔐" }
        ListElement { emoji: "🔑" }
        ListElement { emoji: "🔎" }
        ListElement { emoji: "💡" }
        ListElement { emoji: "🔦" }
        ListElement { emoji: "🔆" }
        ListElement { emoji: "🔅" }
        ListElement { emoji: "🔌" }
        ListElement { emoji: "🔋" }
        ListElement { emoji: "🔍" }
        ListElement { emoji: "🛁" }
        ListElement { emoji: "🛀" }
        ListElement { emoji: "🚿" }
        ListElement { emoji: "🚽" }
        ListElement { emoji: "🔧" }
        ListElement { emoji: "🔩" }
        ListElement { emoji: "🔨" }
        ListElement { emoji: "🚪" }
        ListElement { emoji: "🚬" }
        ListElement { emoji: "💣" }
        ListElement { emoji: "🔫" }
        ListElement { emoji: "🔪" }
        ListElement { emoji: "💊" }
        ListElement { emoji: "💉" }
        ListElement { emoji: "💰" }
        ListElement { emoji: "💴" }
        ListElement { emoji: "💵" }
        ListElement { emoji: "💷" }
        ListElement { emoji: "💶" }
        ListElement { emoji: "💳" }
        ListElement { emoji: "💸" }
        ListElement { emoji: "📲" }
        ListElement { emoji: "📧" }
        ListElement { emoji: "📥" }
        ListElement { emoji: "📤" }
        ListElement { emoji: "✉" }
        ListElement { emoji: "📩" }
        ListElement { emoji: "📨" }
        ListElement { emoji: "📯" }
        ListElement { emoji: "📫" }
        ListElement { emoji: "📪" }
        ListElement { emoji: "📬" }
        ListElement { emoji: "📭" }
        ListElement { emoji: "📮" }
        ListElement { emoji: "📦" }
        ListElement { emoji: "📝" }
        ListElement { emoji: "📄" }
        ListElement { emoji: "📃" }
        ListElement { emoji: "📑" }
        ListElement { emoji: "📊" }
        ListElement { emoji: "📈" }
        ListElement { emoji: "📉" }
        ListElement { emoji: "📜" }
        ListElement { emoji: "📋" }
        ListElement { emoji: "📅" }
        ListElement { emoji: "📆" }
        ListElement { emoji: "📇" }
        ListElement { emoji: "📁" }
        ListElement { emoji: "📂" }
        ListElement { emoji: "✂" }
        ListElement { emoji: "📌" }
        ListElement { emoji: "📎" }
        ListElement { emoji: "✒" }
        ListElement { emoji: "✏" }
        ListElement { emoji: "📏" }
        ListElement { emoji: "📐" }
        ListElement { emoji: "📕" }
        ListElement { emoji: "📗" }
        ListElement { emoji: "📘" }
        ListElement { emoji: "📙" }
        ListElement { emoji: "📓" }
        ListElement { emoji: "📔" }
        ListElement { emoji: "📒" }
        ListElement { emoji: "📚" }
        ListElement { emoji: "📖" }
        ListElement { emoji: "🔖" }
        ListElement { emoji: "📛" }
        ListElement { emoji: "🔬" }
        ListElement { emoji: "🔭" }
        ListElement { emoji: "📰" }
        ListElement { emoji: "🎨" }
        ListElement { emoji: "🎬" }
        ListElement { emoji: "🎤" }
        ListElement { emoji: "🎧" }
        ListElement { emoji: "🎼" }
        ListElement { emoji: "🎵" }
        ListElement { emoji: "🎶" }
        ListElement { emoji: "🎹" }
        ListElement { emoji: "🎻" }
        ListElement { emoji: "🎺" }
        ListElement { emoji: "🎷" }
        ListElement { emoji: "🎸" }
        ListElement { emoji: "👾" }
        ListElement { emoji: "🎮" }
        ListElement { emoji: "🃏" }
        ListElement { emoji: "🎴" }
        ListElement { emoji: "🀄" }
        ListElement { emoji: "🎲" }
        ListElement { emoji: "🎯" }
        ListElement { emoji: "🏈" }
        ListElement { emoji: "🏀" }
        ListElement { emoji: "⚽" }
        ListElement { emoji: "⚾" }
        ListElement { emoji: "🎾" }
        ListElement { emoji: "🎱" }
        ListElement { emoji: "🏉" }
        ListElement { emoji: "🎳" }
        ListElement { emoji: "⛳" }
        ListElement { emoji: "🚵" }
        ListElement { emoji: "🚴" }
        ListElement { emoji: "🏁" }
        ListElement { emoji: "🏇" }
        ListElement { emoji: "🏆" }
        ListElement { emoji: "🎿" }
        ListElement { emoji: "🏂" }
        ListElement { emoji: "🏊" }
        ListElement { emoji: "🏄" }
        ListElement { emoji: "🎣" }
        ListElement { emoji: "☕" }
        ListElement { emoji: "🍵" }
        ListElement { emoji: "🍶" }
        ListElement { emoji: "🍼" }
        ListElement { emoji: "🍺" }
        ListElement { emoji: "🍻" }
        ListElement { emoji: "🍸" }
        ListElement { emoji: "🍹" }
        ListElement { emoji: "🍷" }
        ListElement { emoji: "🍴" }
        ListElement { emoji: "🍕" }
        ListElement { emoji: "🍔" }
        ListElement { emoji: "🍟" }
        ListElement { emoji: "🍗" }
        ListElement { emoji: "🍖" }
        ListElement { emoji: "🍝" }
        ListElement { emoji: "🍛" }
        ListElement { emoji: "🍤" }
        ListElement { emoji: "🍱" }
        ListElement { emoji: "🍣" }
        ListElement { emoji: "🍥" }
        ListElement { emoji: "🍙" }
        ListElement { emoji: "🍘" }
        ListElement { emoji: "🍚" }
        ListElement { emoji: "🍜" }
        ListElement { emoji: "🍲" }
        ListElement { emoji: "🍢" }
        ListElement { emoji: "🍡" }
        ListElement { emoji: "🍳" }
        ListElement { emoji: "🍞" }
        ListElement { emoji: "🍩" }
        ListElement { emoji: "🍮" }
        ListElement { emoji: "🍦" }
        ListElement { emoji: "🍨" }
        ListElement { emoji: "🍧" }
        ListElement { emoji: "🎂" }
        ListElement { emoji: "🍰" }
        ListElement { emoji: "🍪" }
        ListElement { emoji: "🍫" }
        ListElement { emoji: "🍬" }
        ListElement { emoji: "🍭" }
        ListElement { emoji: "🍯" }
        ListElement { emoji: "🍎" }
        ListElement { emoji: "🍏" }
        ListElement { emoji: "🍊" }
        ListElement { emoji: "🍋" }
        ListElement { emoji: "🍒" }
        ListElement { emoji: "🍇" }
        ListElement { emoji: "🍉" }
        ListElement { emoji: "🍓" }
        ListElement { emoji: "🍑" }
        ListElement { emoji: "🍈" }
        ListElement { emoji: "🍌" }
        ListElement { emoji: "🍐" }
        ListElement { emoji: "🍍" }
        ListElement { emoji: "🍠" }
        ListElement { emoji: "🍆" }
        ListElement { emoji: "🍅" }
        ListElement { emoji: "🌽" }
    }

    ListModel {
        id: place
        ListElement { emoji: "🏠" }
        ListElement { emoji: "🏡" }
        ListElement { emoji: "🏫" }
        ListElement { emoji: "🏢" }
        ListElement { emoji: "🏣" }
        ListElement { emoji: "🏥" }
        ListElement { emoji: "🏦" }
        ListElement { emoji: "🏪" }
        ListElement { emoji: "🏩" }
        ListElement { emoji: "🏨" }
        ListElement { emoji: "💒" }
        ListElement { emoji: "⛪" }
        ListElement { emoji: "🏬" }
        ListElement { emoji: "🏤" }
        ListElement { emoji: "🌇" }
        ListElement { emoji: "🌆" }
        ListElement { emoji: "🏯" }
        ListElement { emoji: "🏰" }
        ListElement { emoji: "⛺" }
        ListElement { emoji: "🏭" }
        ListElement { emoji: "🗼" }
        ListElement { emoji: "🗾" }
        ListElement { emoji: "🗻" }
        ListElement { emoji: "🌄" }
        ListElement { emoji: "🌅" }
        ListElement { emoji: "🌃" }
        ListElement { emoji: "🗽" }
        ListElement { emoji: "🌉" }
        ListElement { emoji: "🎠" }
        ListElement { emoji: "🎡" }
        ListElement { emoji: "⛲" }
        ListElement { emoji: "🎢" }
        ListElement { emoji: "🚢" }
        ListElement { emoji: "⛵" }
        ListElement { emoji: "🚤" }
        ListElement { emoji: "🚣" }
        ListElement { emoji: "⚓" }
        ListElement { emoji: "🚀" }
        ListElement { emoji: "✈" }
        ListElement { emoji: "💺" }
        ListElement { emoji: "🚁" }
        ListElement { emoji: "🚂" }
        ListElement { emoji: "🚊" }
        ListElement { emoji: "🚉" }
        ListElement { emoji: "🚞" }
        ListElement { emoji: "🚆" }
        ListElement { emoji: "🚄" }
        ListElement { emoji: "🚅" }
        ListElement { emoji: "🚈" }
        ListElement { emoji: "🚇" }
        ListElement { emoji: "🚝" }
        ListElement { emoji: "🚋" }
        ListElement { emoji: "🚃" }
        ListElement { emoji: "🚎" }
        ListElement { emoji: "🚌" }
        ListElement { emoji: "🚍" }
        ListElement { emoji: "🚙" }
        ListElement { emoji: "🚘" }
        ListElement { emoji: "🚗" }
        ListElement { emoji: "🚕" }
        ListElement { emoji: "🚖" }
        ListElement { emoji: "🚛" }
        ListElement { emoji: "🚚" }
        ListElement { emoji: "🚨" }
        ListElement { emoji: "🚓" }
        ListElement { emoji: "🚔" }
        ListElement { emoji: "🚒" }
        ListElement { emoji: "🚑" }
        ListElement { emoji: "🚐" }
        ListElement { emoji: "🚲" }
        ListElement { emoji: "🚡" }
        ListElement { emoji: "🚟" }
        ListElement { emoji: "🚠" }
        ListElement { emoji: "🚜" }
        ListElement { emoji: "💈" }
        ListElement { emoji: "🚏" }
        ListElement { emoji: "🎫" }
        ListElement { emoji: "🚦" }
        ListElement { emoji: "🚥" }
        ListElement { emoji: "⚠" }
        ListElement { emoji: "🚧" }
        ListElement { emoji: "🔰" }
        ListElement { emoji: "⛽" }
        ListElement { emoji: "🏮" }
        ListElement { emoji: "🎰" }
        ListElement { emoji: "♨" }
        ListElement { emoji: "🗿" }
        ListElement { emoji: "🎪" }
        ListElement { emoji: "🎭" }
        ListElement { emoji: "📍" }
        ListElement { emoji: "🚩" }
    }

    ListModel {
        id: sign
        ListElement { emoji: "1⃣" }
        ListElement { emoji: "2⃣" }
        ListElement { emoji: "3⃣" }
        ListElement { emoji: "4⃣" }
        ListElement { emoji: "5⃣" }
        ListElement { emoji: "6⃣" }
        ListElement { emoji: "7⃣" }
        ListElement { emoji: "8⃣" }
        ListElement { emoji: "9⃣" }
        ListElement { emoji: "0⃣" }
        ListElement { emoji: "🔟" }
        ListElement { emoji: "🔢" }
        ListElement { emoji: "#⃣" }
        ListElement { emoji: "🔣" }
        ListElement { emoji: "⬆" }
        ListElement { emoji: "⬇" }
        ListElement { emoji: "⬅" }
        ListElement { emoji: "➡" }
        ListElement { emoji: "🔠" }
        ListElement { emoji: "🔡" }
        ListElement { emoji: "🔤" }
        ListElement { emoji: "↗" }
        ListElement { emoji: "↖" }
        ListElement { emoji: "↘" }
        ListElement { emoji: "↙" }
        ListElement { emoji: "↔" }
        ListElement { emoji: "↕" }
        ListElement { emoji: "🔄" }
        ListElement { emoji: "◀" }
        ListElement { emoji: "▶" }
        ListElement { emoji: "🔼" }
        ListElement { emoji: "🔽" }
        ListElement { emoji: "↩" }
        ListElement { emoji: "↪" }
        ListElement { emoji: "ℹ" }
        ListElement { emoji: "⏪" }
        ListElement { emoji: "⏩" }
        ListElement { emoji: "⏫" }
        ListElement { emoji: "⏬" }
        ListElement { emoji: "⤵" }
        ListElement { emoji: "⤴" }
        ListElement { emoji: "🆗" }
        ListElement { emoji: "🔀" }
        ListElement { emoji: "🔁" }
        ListElement { emoji: "🔂" }
        ListElement { emoji: "🆕" }
        ListElement { emoji: "🆙" }
        ListElement { emoji: "🆒" }
        ListElement { emoji: "🆓" }
        ListElement { emoji: "🆖" }
        ListElement { emoji: "📶" }
        ListElement { emoji: "🎦" }
        ListElement { emoji: "🈁" }
        ListElement { emoji: "🈯" }
        ListElement { emoji: "🈳" }
        ListElement { emoji: "🈵" }
        ListElement { emoji: "🈴" }
        ListElement { emoji: "🈲" }
        ListElement { emoji: "🉐" }
        ListElement { emoji: "🈹" }
        ListElement { emoji: "🈺" }
        ListElement { emoji: "🈶" }
        ListElement { emoji: "🈚" }
        ListElement { emoji: "🚻" }
        ListElement { emoji: "🚹" }
        ListElement { emoji: "🚺" }
        ListElement { emoji: "🚼" }
        ListElement { emoji: "🚾" }
        ListElement { emoji: "🚰" }
        ListElement { emoji: "🚮" }
        ListElement { emoji: "🅿" }
        ListElement { emoji: "♿" }
        ListElement { emoji: "🚭" }
        ListElement { emoji: "🈷" }
        ListElement { emoji: "🈸" }
        ListElement { emoji: "🈂" }
        ListElement { emoji: "Ⓜ" }
        ListElement { emoji: "🛂" }
        ListElement { emoji: "🛄" }
        ListElement { emoji: "🛅" }
        ListElement { emoji: "🛃" }
        ListElement { emoji: "🉑" }
        ListElement { emoji: "㊙" }
        ListElement { emoji: "㊗" }
        ListElement { emoji: "🆑" }
        ListElement { emoji: "🆘" }
        ListElement { emoji: "🆔" }
        ListElement { emoji: "🚫" }
        ListElement { emoji: "🔞" }
        ListElement { emoji: "📵" }
        ListElement { emoji: "🚯" }
        ListElement { emoji: "🚱" }
        ListElement { emoji: "🚳" }
        ListElement { emoji: "🚷" }
        ListElement { emoji: "🚸" }
        ListElement { emoji: "⛔" }
        ListElement { emoji: "✳" }
        ListElement { emoji: "❇" }
        ListElement { emoji: "❎" }
        ListElement { emoji: "✅" }
        ListElement { emoji: "✴" }
        ListElement { emoji: "💟" }
        ListElement { emoji: "🆚" }
        ListElement { emoji: "📳" }
        ListElement { emoji: "📴" }
        ListElement { emoji: "🅰" }
        ListElement { emoji: "🅱" }
        ListElement { emoji: "🆎" }
        ListElement { emoji: "🅾" }
        ListElement { emoji: "💠" }
        ListElement { emoji: "➿" }
        ListElement { emoji: "♻" }
        ListElement { emoji: "♈" }
        ListElement { emoji: "♉" }
        ListElement { emoji: "♊" }
        ListElement { emoji: "♋" }
        ListElement { emoji: "♌" }
        ListElement { emoji: "♍" }
        ListElement { emoji: "♎" }
        ListElement { emoji: "♏" }
        ListElement { emoji: "♐" }
        ListElement { emoji: "♑" }
        ListElement { emoji: "♒" }
        ListElement { emoji: "♓" }
        ListElement { emoji: "⛎" }
        ListElement { emoji: "🔯" }
        ListElement { emoji: "🏧" }
        ListElement { emoji: "💹" }
        ListElement { emoji: "💲" }
        ListElement { emoji: "💱" }
        ListElement { emoji: "©" }
        ListElement { emoji: "®" }
        ListElement { emoji: "™" }
        ListElement { emoji: "❌" }
        ListElement { emoji: "‼" }
        ListElement { emoji: "⁉" }
        ListElement { emoji: "❗" }
        ListElement { emoji: "❓" }
        ListElement { emoji: "❕" }
        ListElement { emoji: "❔" }
        ListElement { emoji: "⭕" }
        ListElement { emoji: "🔝" }
        ListElement { emoji: "🔚" }
        ListElement { emoji: "🔙" }
        ListElement { emoji: "🔛" }
        ListElement { emoji: "🔜" }
        ListElement { emoji: "🔃" }
        ListElement { emoji: "🕛" }
        ListElement { emoji: "🕧" }
        ListElement { emoji: "🕐" }
        ListElement { emoji: "🕜" }
        ListElement { emoji: "🕑" }
        ListElement { emoji: "🕝" }
        ListElement { emoji: "🕒" }
        ListElement { emoji: "🕞" }
        ListElement { emoji: "🕓" }
        ListElement { emoji: "🕟" }
        ListElement { emoji: "🕔" }
        ListElement { emoji: "🕠" }
        ListElement { emoji: "🕕" }
        ListElement { emoji: "🕖" }
        ListElement { emoji: "🕗" }
        ListElement { emoji: "🕘" }
        ListElement { emoji: "🕙" }
        ListElement { emoji: "🕚" }
        ListElement { emoji: "🕡" }
        ListElement { emoji: "🕢" }
        ListElement { emoji: "🕣" }
        ListElement { emoji: "🕤" }
        ListElement { emoji: "🕥" }
        ListElement { emoji: "🕦" }
        ListElement { emoji: "✖" }
        ListElement { emoji: "➕" }
        ListElement { emoji: "➖" }
        ListElement { emoji: "➗" }
        ListElement { emoji: "♠" }
        ListElement { emoji: "♥" }
        ListElement { emoji: "♣" }
        ListElement { emoji: "♦" }
        ListElement { emoji: "💮" }
        ListElement { emoji: "💯" }
        ListElement { emoji: "✔" }
        ListElement { emoji: "☑" }
        ListElement { emoji: "🔘" }
        ListElement { emoji: "🔗" }
        ListElement { emoji: "➰" }
        ListElement { emoji: "〰" }
        ListElement { emoji: "〽" }
        ListElement { emoji: "🔱" }
        ListElement { emoji: "◼" }
        ListElement { emoji: "◻" }
        ListElement { emoji: "◾" }
        ListElement { emoji: "◽" }
        ListElement { emoji: "▪" }
        ListElement { emoji: "▫" }
        ListElement { emoji: "🔺" }
        ListElement { emoji: "🔲" }
        ListElement { emoji: "🔳" }
        ListElement { emoji: "⚫" }
        ListElement { emoji: "⚪" }
        ListElement { emoji: "🔴" }
        ListElement { emoji: "🔵" }
        ListElement { emoji: "🔻" }
        ListElement { emoji: "⬜" }
        ListElement { emoji: "⬛" }
        ListElement { emoji: "🔶" }
        ListElement { emoji: "🔷" }
        ListElement { emoji: "🔸" }
        ListElement { emoji: "🔹" }
    }

    id: root
    width: parent.width
    height: width > 540? 195: 270
    clip: true
    flickableDirection: Flickable.HorizontalFlick
    flow: GridView.FlowTopToBottom

    snapMode: GridView.SnapToRow

    HorizontalScrollDecorator {  }


    model: frequent

    cellWidth: root.width / 10
    cellHeight: root.height / 4

    header: Item {
        height: parent.height
        width: keyboard.layout.keyWidth * 2.2 * 2

        Grid {
            anchors.fill: parent
            columns: 2
            flow: Grid.TopToBottom
            anchors.topMargin: Theme.paddingSmall
            anchors.bottomMargin: Theme.paddingSmall
            anchors.leftMargin: Theme.paddingSmall
            anchors.rightMargin: Theme.paddingSmall

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "sign-150.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = frequent
                }

            }

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "face-2.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = face
                }
            }

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "object-43.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = object
                }

            }

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "nature-65.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = nature
                }

            }


            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "place-1.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = place
                }

            }

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "sign-13.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = sign
                }
            }
        }
    }

    footer: Item {
        height: parent.height
        width: shiftKeyWidth * 2

        Grid {
            anchors.fill: parent
            columns: 2
            flow: Grid.TopToBottom
            anchors.topMargin: Theme.paddingSmall
            anchors.bottomMargin: Theme.paddingSmall
            anchors.leftMargin: Theme.paddingSmall
            anchors.rightMargin: Theme.paddingSmall

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "sign-150.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = frequent
                }

            }

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "face-2.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = face
                }
            }

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "object-43.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = object
                }

            }

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "nature-65.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = nature
                }

            }


            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "place-1.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = place
                }

            }

            BackgroundItem {
                width: parent.width / 2
                height: parent.height / 3

                Image {
                    smooth: false
                    width: 36
                    height: 36
                    anchors.centerIn: parent
                    source: "sign-13.png"
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.primaryColor
                    opacity: 0.16
                    radius: geometry.keyRadius
                    anchors.margins: Theme.paddingSmall

                }

                onClicked: {
                    root.model = sign
                }
            }
        }
    }
    delegate: CommitKey {
        id: delegate
        width: root.width / 10
        height: root.height / 4
        caption: emoji

        src: root.model === face? "face-" + ( index + 1 ) + ".png": ( root.model === object? "object-" + ( index + 1 ) + ".png": ( root.model === place?  "place-" + ( index + 1 ) + ".png": ( root.model === nature?  "nature-" + ( index + 1 ) + ".png":  (root.model === sign? "sign-" + ( index + 1 ) + ".png": model.icon ) ) ) )
        onClicked: {

            if ( root.model !== frequent ) {
                var exist = false
                for ( var i = 0; i < frequent.count; i++ ) {
                    if ( frequent.get(i).emoji === model.emoji ) {
                        exist = true
                        break
                    }
                }
                if ( exist === false ) {
                    frequent.append( { "emoji": model.emoji, "icon": src.toString() } )
                }
            } else {
                frequent.move(index, 0, 1)
            }
        }
    }

    MultiPointTouchArea {
        // prevent events leaking below
        anchors.fill: parent
        z: -1
    }

}

