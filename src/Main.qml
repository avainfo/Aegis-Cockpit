import QtQuick
import QtQuick.Window
import Aegis 0.1 as Aegis

Window {
    id: win

    color: "#1E1E1E"
    title: qsTr("Aegis")
    visibility: Window.Maximized
    visible: true

    Text {
        anchors.right: parent.right
        anchors.top: parent.top
        color: "white"
        opacity: 0.7
        padding: 6
        text: `FPS: ${fps ? fps.fps : 0}`
    }
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
            mode: Aegis.ModeType.Eco
            value: vehicle.speed
        }
    }
}