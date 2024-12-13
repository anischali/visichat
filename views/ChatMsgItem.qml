import QtQuick 6.5
import QtQuick.Controls

Item {

    property int status: 0
    property string avatar: qsTr("")
    property string username: qsTr("")
    property string message: qsTr("")
    property string textColor: "white"

    signal click(string username, string avatar)

    function set_status(status) {
        switch (status) {
        case 1:
            status_icon.source = "../resources/images/online.png"
            break
        case 2:
            status_icon.source = "../resources/images/busy.png"
            break
        case 3:
            status_icon.source = "../resources/images/offline.png"
            break
        }
    }

    onStatusChanged: {
        set_status(status)
    }

    onMessageChanged: {
        last_msg.text = message
    }

    Rectangle {
        id: msgRect
        height: parent.height
        width: parent.width
        color: "#242424"

        Image {
            id: avatar_img
            x: 0
            y: 0
            width: parent.height
            height: parent.height

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: avatar
            fillMode: Image.PreserveAspectFit
            antialiasing: true
        }

        Text {
            id: user_name
            x: parent.height + 5
            y: 0
            text: username
            font.pixelSize: 23
            horizontalAlignment: Text.AlignLeft
            font.bold: true
            color: textColor
        }

        Text {
            id: last_msg
            x: parent.height + 5
            y: parent.height - (parent.height / 3)
            text: message
            font.pixelSize: 12
            horizontalAlignment: Text.AlignLeft
            color: textColor
        }

        Image {
            id: status_icon
            x: parent.height - 16
            y: parent.height - 16
            width: 16
            height: 16
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            source: "../resources/images/online.png"
            fillMode: Image.PreserveAspectFit
            antialiasing: true
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                click(user_name.text, avatar_img.source)
            }
        }
    }
}
