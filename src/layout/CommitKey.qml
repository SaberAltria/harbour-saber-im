import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {

    id: root
    property string caption
    property url src

    Label {
        visible: false
        anchors.centerIn: parent
        text: caption
        font.pixelSize: 32
    }
    onClicked: {
        MInputMethodQuick.sendCommit(caption)
    }

    Image {
        id: icon
        smooth: false
        width: 36
        height: 36
        anchors.centerIn: parent
        source: src
    }

}
