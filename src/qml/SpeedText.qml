import QtQuick
import Aegis 0.1 as Aegis

Item {
	id: root

	property string accent: "#FFFFFF"
	property int fontSize: 28
	property int mode: Aegis.ModeType.Eco
	property string unit: "km/h"
	property real value: 0

	Behavior on value {
		NumberAnimation {
			alwaysRunToEnd: false
			duration: (root.mode === Aegis.ModeType.Sport) ? 250 : (root.mode === Aegis.ModeType.Comfort) ? 400 : 800
			easing.type: Easing.OutCubic
		}
	}

	Text {
		id: sub

		anchors.centerIn: parent
		color: root.accent
		font.bold: true
		font.pixelSize: root.fontSize
		horizontalAlignment: Text.AlignHCenter
		renderType: Text.NativeRendering
		text: Math.round(root.value).toString() + " " + root.unit
	}
}
