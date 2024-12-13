import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

Page {
    property ChatMsgItem info: null
    width: 200

    height: 400

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
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            layoutDirection: Qt.LeftToRight

            Label {
                id: username
                text: ""
                font.bold: true
                Layout.leftMargin: 10
                Layout.fillWidth: true
                Layout.fillHeight: false
                color: "white"
            }

            RoundButton {
                id: share_btn
                icon.source: "../resources/images/share.png"
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 20
                icon.width: 20
                icon.color: "#BABFB6"
            }

            RoundButton {
                id: info_btn
                icon.source: "../resources/images/info.png"
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 20
                icon.width: 20
                icon.color: "#BABFB6"
            }

            RoundButton {
                id: call_btn
                icon.source: "../resources/images/call.png"
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

            TextField {
                id: msgInput
                anchors.topMargin: 5
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "white"
                anchors.fill: parent
                selectedTextColor: "green"

                background: Rectangle {
                    color: "#141414"
                    radius: 20
                }
            }

            RoundButton {
                id: send_btn
                text: ""
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.color: "#BABFB6"
                icon.height: 24
                icon.width: 24
                icon.source: "../resources/images/send.png"
            }

            RoundButton {
                id: join_btn
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.color: "#BABFB6"
                icon.height: 24
                icon.width: 24
                icon.source: "../resources/images/attach.png"
            }

            RoundButton {
                id: audio_btn
                text: qsTr("")
                antialiasing: true
                flat: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                icon.height: 24
                icon.width: 24
                icon.source: "../resources/images/record.png"
                icon.color: "#BABFB6"
            }
        }
    }

    Rectangle {
        id: msgs_view
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 48
        anchors.bottomMargin: 64
        enabled: false
        color: "#00ffffff"

        ScrollView {
            clip: true
            anchors.fill: parent

            ColumnLayout {
                anchors.fill: parent
                Repeater {
                    id: msgsList
                    model: 10

                    TextField {
                        background: Rectangle {
                            radius: 10
                            color: parent.index % 2 == 0 ? "green" : "#blue"
                        }

                        readOnly: true
                        color: "white"
                        text: qsTr("ceci est un message de test")
                    }
                }
            }
        }
    }
}
