import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import "."

Rectangle {
    color: "#242424"
    property string image: "../resources/images/default-avatar.png"

    Image {
        anchors.centerIn: parent
        source: image
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            mainStack.pop()
        }
    }
}
