import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import com.visibog.qchat 1.0

import "."

Item {
    visible: true

    QrCodeView {
        id: qr_view
        anchors.fill: parent
        visible: false
    }

    QChat {
        id: qchat
    }

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
                id: mshare_btn
                icon.source: "../resources/images/share.png"
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 20
                icon.width: 20
                icon.color: "#BABFB6"

                onClicked: {

                    qr_view.image = qchat.shareContact(qr_view.width / 2,
                                                       qr_view.width / 2)
                    mainStack.push(qr_view)
                }
            }

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
        background: Rectangle {
            color: "#242424"
        }

        Item {
            id: messages_tab
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            anchors.bottomMargin: 10

            ChatMsgsPage {
                id: msgPage
                anchors.fill: parent
                visible: false
            }

            ScrollView {
                id: scrollView
                anchors.fill: parent

                ColumnLayout {
                    anchors.fill: parent
                    Repeater {
                        id: messages
                        model: [{
                                "username": "anis",
                                "message": "ceci etait le dernier message",
                                "avatar": "../resources/images/default-avatar.png",
                                "status": 3
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
                                "status": 3
                            }]

                        delegate: ChatMsgItem {
                            id: msgItem
                            height: 48
                            Layout.fillWidth: true
                            username: qsTr(modelData["username"])
                            message: qsTr(modelData["message"])
                            status: modelData["status"]
                            textColor: "white"
                            avatar: modelData["avatar"]

                            onClick: function (u, a) {
                                msgPage.username = u
                                msgPage.avatar = a
                                mainStack.push(msgPage)
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
