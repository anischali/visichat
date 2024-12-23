import QtQuick 6.5
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Controls 2.15

Window {
    id: window
    property var builtInStyles

    width: Screen.width
    height: Screen.height
    visible: true

    StackView {
        id: mainStack
        anchors.fill: parent

        initialItem: MainApp {}
    }
}
