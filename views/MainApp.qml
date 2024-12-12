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
        height: 80
        visible: true
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        contentHeight: 48

        Row {
            width: 66
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            TabButton {
                id: share_btn
                x: -73
                text: qsTr("")
                icon.width: 48
                icon.source: "../resources/images/share.png"
                icon.height: 48
                icon.color: "#babfb6"
                display: AbstractButton.IconOnly
                Layout.preferredWidth: 80
                Layout.fillWidth: false
                Layout.fillHeight: true
            }

            TabButton {
                id: import_btn
                x: -1
                text: qsTr("")
                icon.width: 48
                icon.source: "../resources/images/import.png"
                icon.height: 48
                icon.color: "#babfb6"
                display: AbstractButton.IconOnly
                Layout.preferredWidth: 80
                Layout.fillWidth: false
                Layout.fillHeight: true
            }

            TabButton {
                id: search_btn
                x: 71
                visible: true
                text: qsTr("")
                icon.width: 48
                icon.source: "../resources/images/search.png"
                icon.height: 48
                icon.color: "#babfb6"
                display: AbstractButton.IconOnly
                Layout.preferredWidth: 80
                Layout.fillWidth: false
                Layout.fillHeight: true
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
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            TabButton {
                id: contacts
                text: qsTr("")
                icon.height: 64
                icon.width: 64
                icon.source: "../resources/images/contacts.png"
                display: AbstractButton.IconOnly
                icon.color: "#BABFB6"
                Layout.margins: 0
                Layout.columnSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            TabButton {
                id: calls
                text: qsTr("")
                icon.color: "#BABFB6"
                icon.height: 64
                icon.width: 64
                display: AbstractButton.IconOnly
                icon.source: "../resources/images/calls.png"
                Layout.margins: 0
                Layout.columnSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            TabButton {
                id: msgs_btn
                text: ""
                icon.color: "#BABFB6"
                icon.height: 64
                icon.width: 64
                icon.source: "../resources/images/mesgs.png"
                display: AbstractButton.IconOnly
                Layout.margins: 0
                Layout.columnSpan: 1
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }

    SwipeView {
        id: sw_view
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 80
        anchors.bottomMargin: 80
        interactive: false
        enabled: false

        Item {
            id: messages_tab
            ScrollView {
                anchors.fill: parent
                enabled: true
                ColumnLayout {
                    Repeater {
                        id: messages
                        model: 20

                        ChatMsg {
                            height: 80
                            Layout.fillWidth: true
                            name: qsTr("anis " + index)
                            message: qsTr("ceci etait le dernier message")
                            status: 0
                            avatar: "../resources/images/default-avatar.png"
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
