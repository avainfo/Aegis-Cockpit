import QtQuick

Rectangle {
    id: root

    property color accent: "#FFFFFF"
    property int fontSize: 28
    property real value: 0

    height: sub.height
    width: sub.width

    Behavior on value {
        NumberAnimation {
            duration: 800
            easing.type: Easing.InOutQuad
        }
    }

    Text {
        id: sub

        anchors.centerIn: parent
        color: root.accent
        font.bold: true
        font.pixelSize: root.fontSize
        horizontalAlignment: Text.AlignHCenter
        text: Math.round(root.value).toString()
    }
    MouseArea {
        anchors.fill: parent

        onClicked: root.value += 37
    }
}
