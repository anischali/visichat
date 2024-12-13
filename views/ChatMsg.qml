import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

Item {
    property string username: ""
    property string avatar: qsTr("")

    width: 350
    height: 400

    Rectangle {
        id: msgs_view
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 48
        anchors.bottomMargin: 0
        enabled: false
        color: "#242424"

        ScrollView {
            clip: true
            anchors.fill: parent
            anchors.topMargin: 10
            anchors.bottomMargin: 10

            ColumnLayout {
                anchors.fill: parent
                Repeater {
                    id: msgsList
                    model: 10

                    TextField {
                        background: Rectangle {
                            radius: 10
                            color: index % 2 == 0 ? "green" : "#blue"
                        }

                        readOnly: true
                        color: "white"
                        text: qsTr("ceci est un message de test")
                    }
                }
            }
        }
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
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            layoutDirection: Qt.LeftToRight

            RowLayout {
                id: rowLayout4
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                RoundButton {
                    id: back_btn
                    width: 16
                    height: 16
                    text: qsTr("")
                    Layout.fillHeight: true
                    icon.width: 20
                    icon.source: "../resources/images/back.png"
                    icon.height: 20
                    icon.color: "#babfb6"
                    flat: true
                    antialiasing: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    onClicked: {
                        mainStack.pop()
                    }
                }

                Image {
                    id: image
                    width: 32
                    height: 32
                    horizontalAlignment: Image.AlignLeft
                    source: avatar
                    cache: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.leftMargin: 0
                    Layout.fillWidth: false
                    Layout.fillHeight: true
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: user_name
                    width: 24
                    height: 24
                    text: username
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.bold: true
                    Layout.leftMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "white"
                }
            }

            RowLayout {
                id: rowLayout3
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                Layout.fillWidth: true
                Layout.fillHeight: true
                antialiasing: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                RoundButton {
                    id: info_btn
                    width: 24
                    height: 24
                    icon.source: "../resources/images/info.png"
                    text: qsTr("")
                    padding: 0
                    rightPadding: 0
                    leftPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    antialiasing: true
                    flat: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.height: 20
                    icon.width: 20
                    icon.color: "#BABFB6"
                }

                RoundButton {
                    id: share_btn
                    width: 24
                    height: 24
                    icon.source: "../resources/images/share.png"
                    text: qsTr("")
                    padding: 0
                    rightPadding: 0
                    leftPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    antialiasing: true
                    flat: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.height: 20
                    icon.width: 20
                    icon.color: "#BABFB6"
                }

                RoundButton {
                    id: call_btn
                    width: 24
                    height: 24
                    icon.source: "../resources/images/call.png"
                    text: qsTr("")
                    padding: 0
                    rightPadding: 0
                    leftPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    antialiasing: true
                    flat: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.height: 20
                    icon.width: 20
                    icon.color: "#BABFB6"
                }
            }
        }
    }

    ToolBar {
        id: footer_tab
        x: 509
        y: 611
        width: 360
        height: 48
        position: ToolBar.Footer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        RowLayout {
            id: rowLayout
            anchors.fill: parent

            RowLayout {
                id: rowLayout2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                TextField {
                    color: "#ffffff"
                    wrapMode: Text.Wrap
                    Layout.bottomMargin: 6
                    Layout.topMargin: 4
                    layer.wrapMode: ShaderEffectSource.RepeatVertically
                    antialiasing: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    background: Rectangle {
                        color: "#141414"
                        radius: 20
                    }
                }
            }

            RowLayout {
                id: rowLayout1
                width: 0
                height: 0
                spacing: 0

                RoundButton {
                    id: audio_btn
                    width: 16
                    height: 16
                    text: qsTr("")
                    highlighted: false
                    padding: 0
                    leftPadding: 0
                    topPadding: 0
                    antialiasing: true
                    flat: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.height: 20
                    icon.width: 20
                    icon.source: "../resources/images/record.png"
                    icon.color: "#BABFB6"
                }

                RoundButton {
                    id: join_btn
                    width: 16
                    height: 16
                    text: qsTr("")
                    highlighted: false
                    padding: 0
                    leftPadding: 0
                    topPadding: 0
                    antialiasing: true
                    flat: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.color: "#BABFB6"
                    icon.height: 20
                    icon.width: 20
                    icon.source: "../resources/images/attach.png"
                }

                RoundButton {
                    id: send_btn
                    width: 16
                    height: 16
                    text: ""
                    highlighted: false
                    padding: 0
                    leftPadding: 0
                    topPadding: 0
                    antialiasing: true
                    flat: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    icon.color: "#BABFB6"
                    icon.height: 20
                    icon.width: 20
                    icon.source: "../resources/images/send.png"
                }
            }
        }
    }
}
