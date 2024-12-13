import QtQuick 6.5
import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

Item {
    visible: true

    ToolBar {
        id: header_tab
        x: 220
        y: 363
        height: 48
        position: ToolBar.Header
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        RowLayout {
            id: rowLayoutHeader
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            layoutDirection: Qt.LeftToRight

            RoundButton {
                id: import_btn
                icon.source: "../resources/images/import.png"
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 20
                icon.width: 20
                icon.color: "#BABFB6"
            }

            RoundButton {
                id: search_btn
                icon.source: "../resources/images/search.png"
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 20
                icon.width: 20
                icon.color: "#BABFB6"
            }
        }
    }

    ToolBar {
        id: footer_tab
        x: 509
        y: 611
        width: 360
        height: 64
        position: ToolBar.Footer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        RowLayout {
            id: rowLayout
            anchors.fill: parent

            RoundButton {
                id: msgs_btn
                text: ""
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.color: "#BABFB6"
                icon.height: 24
                icon.width: 24
                icon.source: "../resources/images/mesgs.png"
            }

            RoundButton {
                id: calls
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.color: "#BABFB6"
                icon.height: 24
                icon.width: 24
                icon.source: "../resources/images/calls.png"
            }

            RoundButton {
                id: contacts
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 24
                icon.width: 24
                icon.source: "../resources/images/contacts.png"
                icon.color: "#BABFB6"
            }
        }
    }

    SwipeView {
        id: sw_view
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 48
        anchors.bottomMargin: 64
        interactive: false
        enabled: false

        Item {
            id: messages_tab
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0

            ChatMsg {
                id: msgPage
                visible: false
                anchors.fill: parent
            }

            ScrollView {
                id: scrollView
                anchors.fill: parent
                background: Rectangle {
                    anchors.fill: parent
                    color: "#242424"
                }

                ListView {
                    id: messages
                    spacing: 20
                    interactive: false
                    clip: true
                    anchors.fill: parent

                    model: [{
                            "username": "anis",
                            "message": "ceci etait le dernier message",
                            "avatar": "../resources/images/default-avatar.png",
                            "status": 0
                        }, {
                            "username": "tiph",
                            "message": "ceci etait le dernier message",
                            "avatar": "../resources/images/default-avatar.png",
                            "status": 1
                        }, {
                            "username": "gaby",
                            "message": "ceci etait le dernier message",
                            "avatar": "../resources/images/default-avatar.png",
                            "status": 2
                        }, {
                            "username": "roza",
                            "message": "ceci etait le dernier message",
                            "avatar": "../resources/images/default-avatar.png",
                            "status": 2
                        }, {
                            "username": "doudouch",
                            "message": "ceci etait le dernier message",
                            "avatar": "../resources/images/default-avatar.png",
                            "status": 0
                        }]

                    delegate: ChatMsgItem {
                        height: 48
                        Layout.fillWidth: true
                        id: msgItem
                        username: qsTr(modelData["username"])
                        message: qsTr(modelData["message"])
                        status: modelData["status"]
                        textColor: "white"
                        avatar: modelData["avatar"]
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                console.log("clicked !!!")
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: calls_tab
        }

        Item {
            id: contacts_tab
        }
    }
}
