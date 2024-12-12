import QtQuick 6.5
import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

Item {

    id: main_app

    width: parent.width
    height: parent.height
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
                id: share_btn
                icon.source: "../resources/images/share.png"
                text: qsTr("")
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 20
                icon.width: 20
                icon.color: "#BABFB6"
            }

            RoundButton {
                id: import_btn
                icon.source: "../resources/images/import.png"
                text: qsTr("")
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

            Rectangle {
                id: rectangle
                anchors.fill: parent
                color: "#141414"

                ScrollView {
                    clip: true
                    anchors.fill: parent

                    ColumnLayout {
                        anchors.fill: parent

                        Repeater {
                            id: messages
                            model: 20

                            ChatMsg {
                                height: 48
                                Layout.fillWidth: true
                                username: qsTr("anis " + index)
                                message: qsTr("ceci etait le dernier message")
                                status: 0
                                textColor: "white"
                                avatar: "../resources/images/default-avatar.png"
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
