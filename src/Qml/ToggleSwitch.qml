import QtQuick

Item {
    id: toggle
    width: 50
    height: 28
    property bool checked: false
    // signal checkedChanged(bool checked)

    Rectangle {
        id: background
        anchors.fill: parent
        radius: height / 2
        color: checked ? "#39FF14" : "#ccc"
        border.color: "#999"
        Behavior on color { ColorAnimation { duration: 200 } }
    }

    Rectangle {
        id: knob
        width: 22
        height: 22
        radius: 11
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        x: checked ? parent.width - width - 3 : 3
        Behavior on x { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            toggle.checked = !toggle.checked
            toggle.checkedChanged(toggle.checked)
        }
    }
}
