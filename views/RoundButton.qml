import QtQuick 6.5
import QtQuick.Controls.Universal
import QtQuick.Controls.Material
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

Rectangle {

    TabButton {
        id: calls
        display: AbstractButton.IconOnly
        Layout.margins: 0
        Layout.columnSpan: 1
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
