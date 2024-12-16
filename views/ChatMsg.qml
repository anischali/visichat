import QtQuick 6.5
import QtQuick.Controls

Item {

    property bool remote: false
    property string message: ""
    property string text_color: "white"

    TextField {
        background: Rectangle {
            radius: 10
            color: remote ? "green" : "#blue"
        }

        readOnly: true
        selectByMouse: true
        color: text_color
        text: qsTr(message)
    }
}
