import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "#f1f1f1"

    ColumnLayout {
        anchors.fill: parent
        spacing: 0  // Remove spacing between nav and grid

        // Top Nav bar
        Rectangle {
            Layout.preferredHeight: 70
            Layout.fillWidth: true
            color: "#ffffff"
            Layout.alignment: Qt.AlignTop

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 30
                anchors.rightMargin: 30

                Text {
                    text: "Dashboard"
                    font.pixelSize: 22
                    font.bold: true
                    color: "#1d1d1d"
                    Layout.alignment: Qt.AlignHCenter
                }

                Item {
                    Layout.fillWidth: true
                }

                Rectangle {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    radius: 20
                    color: "#4a90e2"

                    Text {
                        text: "👤"
                        font.pixelSize: 20
                        anchors.centerIn: parent
                    }
                }
            }
        }

        // ScrollView to handle many devices
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 20  // Space below nav bar
            Layout.leftMargin: 20
            Layout.bottomMargin: 20
            clip: true  // Prevent content overflow

            // Disable horizontal scrollbar
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff         
        }
    }
}
