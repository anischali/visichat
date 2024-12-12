import QtQuick 6.5

Item {

    property int status: 0
    property string avatar: qsTr("")
    property string username: qsTr("")
    property string message: qsTr("")

    Rectangle {
        id: rectangle
        height: parent.height
        width: parent.width
        color: "#00ffffff"

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
        }

        Text {
            id: user_name
            x: 85
            y: 10
            text: username
            font.pixelSize: 23
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            color: "white"
        }

        Text {
            id: last_msg
            x: 85
            y: 45
            text: message
            font.pixelSize: 12
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }

        Image {
            id: status_icon
            x: 56
            y: 56
            width: 24
            height: 24
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            source: "../resources/images/offline.png"
            fillMode: Image.PreserveAspectFit
        }
    }
}
