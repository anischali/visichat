import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

Page {
    id: page
    ToolBar {
        id: toolBar
        x: 3
        y: 429
        width: 360
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        RowLayout {
            id: rowLayout
            anchors.fill: parent


            TextField {
                id: textField
                height: 48
                Layout.fillWidth: true
                Layout.fillHeight: true
                placeholderText: qsTr("Text Field")
            }

            RoundButton {
                id: roundButton
                text: "+"
            }

            RoundButton {
                id: roundButton1
                text: "+"
            }

        }
    }
}
