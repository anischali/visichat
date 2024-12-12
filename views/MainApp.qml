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
        width: 360
        height: 56
        visible: true
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        contentHeight: 48

        Flow {
            x: 0
            y: 0
            anchors.right: parent.right
            RoundButton {
                id: share_btn
                text: qsTr("")
                icon.width: 32
                icon.height: 32
                icon.source: "../resources/images/share.png"
                icon.color: "#babfb6"
            }

            RoundButton {
                id: import_btn
                text: qsTr("")
                icon.width: 32
                icon.height: 32
                icon.source: "../resources/images/import.png"
                icon.color: "#babfb6"
            }

            RoundButton {
                id: search_btn
                visible: true
                text: qsTr("")
                icon.width: 32
                icon.height: 32
                icon.source: "../resources/images/search.png"
                icon.color: "#babfb6"
            }
        }
    }

    ToolBar {
        id: footer_tab
        x: 509
        y: 611
        width: 360
        height: 80
        position: ToolBar.Footer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: 64

        RowLayout {
            id: rowLayout
            anchors.fill: parent

            RoundButton {
                id: msgs_btn
                text: ""
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.color: "#BABFB6"
                icon.height: 48
                icon.width: 48
                icon.source: "../resources/images/mesgs.png"
            }

            RoundButton {
                id: calls
                text: qsTr("")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.color: "#BABFB6"
                icon.height: 48
                icon.width: 48
                icon.source: "../resources/images/calls.png"
            }

            RoundButton {
                id: contacts
                text: qsTr("")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 48
                icon.width: 48
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
        anchors.topMargin: 56
        anchors.bottomMargin: 80
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
                color: "#060e18"

                ScrollView {
                    id: scrollView
                    x: 0
                    y: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.fill: parent
                    enabled: true

                    ColumnLayout {
                        x: 0
                        width: 360
                        height: 480
                        anchors.top: parent.top
                        anchors.topMargin: 0
                        anchors.fill: parent

                        Repeater {
                            id: messages
                            model: 20

                            ChatMsg {
                                height: 80
                                Layout.fillWidth: true
                                username: qsTr("anis " + index)
                                message: qsTr("ceci etait le dernier message")
                                status: 0
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
