// Loading.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Authentication

Rectangle {
    id: loadingPage
    color: "#1e1e2e"

    Component.onCompleted: {
        opacity = 0;
        entranceAnimation.start();
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 40

        // Animated Logo/Spinner
        Rectangle {
            id: spinnerContainer
            Layout.alignment: Qt.AlignCenter
            width: 120
            height: 120
            radius: 60
            color: "transparent"

            // Outer ring
            Rectangle {
                id: outerRing
                anchors.fill: parent
                radius: width / 2
                color: "transparent"
                border.width: 4
                border.color: "#89b4fa"
                opacity: 0.3
            }

            // Animated spinner arc
            Canvas {
                id: spinnerCanvas
                anchors.fill: parent
                anchors.margins: 10

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()

                    var centerX = width / 2
                    var centerY = height / 2
                    var radius = Math.min(centerX, centerY) - 5
                    var startAngle = -Math.PI / 2
                    var endAngle = startAngle + (rotation / 360) * Math.PI * 2

                    ctx.beginPath()
                    ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                    ctx.lineWidth = 4
                    ctx.strokeStyle = "#89b4fa"
                    ctx.stroke()
                }

                rotation: 0

                RotationAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 1500
                    loops: Animation.Infinite
                    running: true
                }

                // Redraw on each frame
                onRotationChanged: requestPaint()
            }

            // App icon in center
            Rectangle {
                id: appIconContainer
                width: 60
                height: 60
                radius: 30
                anchors.centerIn: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#89b4fa" }
                    GradientStop { position: 1.0; color: "#74c7ec" }
                }

                Text {
                    text: "⚡" // You can replace this with your actual icon
                    anchors.centerIn: parent
                    font.pixelSize: 24
                }

                SequentialAnimation on scale {
                    loops: Animation.Infinite
                    running: true
                    NumberAnimation { from: 1; to: 1.1; duration: 800; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 1.1; to: 1; duration: 800; easing.type: Easing.InOutQuad }
                }

                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    running: true
                    NumberAnimation { from: 0.8; to: 1; duration: 800; easing.type: Easing.InOutQuad }
                    NumberAnimation { from: 1; to: 0.8; duration: 800; easing.type: Easing.InOutQuad }
                }
            }
        }

        // Loading Text with Dots Animation
        ColumnLayout {
            spacing: 20
            Layout.alignment: Qt.AlignCenter

            Text {
                id: loadingText
                text: "Loading"
                color: "#cdd6f4"
                font.pixelSize: 24
                font.bold: true
                Layout.alignment: Qt.AlignCenter
            }

            Text {
                id: dots
                text: ""
                color: "#89b4fa"
                font.pixelSize: 24
                font.bold: true
                Layout.alignment: Qt.AlignCenter

                Timer {
                    interval: 500
                    repeat: true
                    running: true
                    onTriggered: {
                        if(dots.text.length >= 3) dots.text = ""
                        else dots.text += "."
                    }
                }
            }
        }

    }

    // Simulate loading completion
    // Timer {
    //     interval: 3000
    //     running: true
    //     onTriggered: pageStackView.push(loginPage)
    // }

    // Page entrance animation

    SequentialAnimation {
        id: entranceAnimation
        NumberAnimation {
            target: loadingPage
            property: "opacity"
            from: 0
            to: 1
            duration: 200
        }
    }



}
