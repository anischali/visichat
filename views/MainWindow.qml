import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts
import QtQuick.Controls.Universal
import QtQuick.Controls.Material


ApplicationWindow {
    property var builtInStyles

    width: Screen.width
    height: Screen.height
    visible: true

    header: ToolBar {
        width: parent.width
        height: parent.height / 10
        RowLayout {
            anchors.fill: parent
            Label {
                text: "VisiChat (Secure P2P)"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
            }
            ToolButton {
                text: qsTr("+")
                onClicked: stack.pop()
            }
            ToolButton {
                text: qsTr("⋮")
                //onClicked: menu.open()
            }
        }
    }

    StackView {
        id: stack
        anchors.fill: parent

        RowLayout {
            anchors.fill: parent

            Rectangle {
                anchors.fill: parent
                color: 'teal'
                RowLayout {
                    Label {
                        text:  qsTr("external ip: " + ext_ip)
                    }

                    Label {
                        text:  qsTr("external port: " + ext_port)
                    }

                    Label {
                        text:  qsTr("icanhazip: " + icanhazip)
                    }
                }
            }
        }
    }

    footer: ToolBar {
        width: parent.width
        height: parent.height / 10
        RowLayout {
            anchors.fill: parent

            ToolButton {
                text: qsTr("Contacts")
                Layout.alignment: Qt.AlignHCenter
                //onClicked: menu.open()
            }
            ToolButton {
                text: qsTr("Chats")
                Layout.alignment: Qt.AlignHCenter
                //onClicked: menu.open()
            }
            ToolButton {
                text: qsTr("More")
                Layout.alignment: Qt.AlignHCenter
                //onClicked: menu.open()
            }
        }
    }
}
