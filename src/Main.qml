import QtQuick
import QtQuick.Window
import Aegis

Window {
    color: "#1E1E1E"
    title: qsTr("Aegis")
    visibility: Window.Maximized
    visible: true

    Rectangle {
        color: "white"
        height: img.height
        width: parent.width
        y: img.y
    }
    Image {
        id: img

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/qt/qml/Aegis/assets/outline.png"
        width: parent.width

        SpeedText {
            accent: "#1E1E1E"
            anchors.centerIn: parent
            fontSize: 42
            value: 0
        }
    }
}