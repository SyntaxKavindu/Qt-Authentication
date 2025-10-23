import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qml

Rectangle {
    id: root
    width: 190
    height: 150
    radius: 16
    color: hovered ? "#f5fff5" : "white"
    border.color: "#e6e6e6"
    border.width: 1
    property string deviceName: ""
    property string activeURL: ""
    property string inActiveURL: ""
    property bool status: false
    property bool hovered: false

    scale: hovered ? 1.05 : 1.0
    Behavior on scale {
        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
    }
    Behavior on color {
        ColorAnimation { duration: 150; easing.type: Easing.OutQuad  }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.status = !root.status
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 2

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: root.status ? "ON" : "OFF"
                color: root.status ? "#39FF14" : "gray"
                font.bold: true
            }

            Item { Layout.fillWidth: true } // spacer

            ToggleSwitch {
                checked: root.status
                onCheckedChanged: root.status = checked
            }
        }

        Image {
            source: root.status ? activeURL : inActiveURL
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            Layout.alignment: Qt.AlignLeft
        }

        Text {
            text: deviceName
            color: root.status ? "#39FF14" : "gray"
            font.pixelSize: 16
            font.bold: true
            Layout.alignment: Qt.AlignLeft
        }
    }

    // Card entrance animation
    Component.onCompleted: {
        cardEntranceAnimation.start()
    }

    SequentialAnimation {
        id: cardEntranceAnimation
        NumberAnimation {
            target: root
            property: "scale"
            from: 0.8
            to: 1
            duration: 600
            easing.type: Easing.OutBack
        }
    }
}
