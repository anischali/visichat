import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import "."

Window {
    id: window
    property var builtInStyles

    width: Screen.width
    height: Screen.height
    visible: true

    StackView {
        id: mainStack
        anchors.fill: parent

        initialItem: MainApp {
            anchors.fill: parent
        }
    }
}
