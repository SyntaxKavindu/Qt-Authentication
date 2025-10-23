// Login.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Authentication 1.0

Rectangle {
    id: loginPage
    color: "#1e1e2e"

    property string email: ""
    property string password: ""

    // Centered Login Card
    Rectangle {
        id: loginCard
        width: Math.min(parent.width * 0.4, 450)
        height: Math.min(parent.height * 0.85, 650)
        anchors.centerIn: parent
        color: "#11111b"
        radius: 25
        clip: true

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 20
            width: parent.width * 0.85

            // Header with animated logo
            ColumnLayout {
                spacing: 15
                Layout.alignment: Qt.AlignCenter

                Rectangle {
                    id: logoCircle
                    width: 82
                    height: 82
                    radius: 45
                    Layout.alignment: Qt.AlignCenter
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#89b4fa" }
                        GradientStop { position: 0.5; color: "#74c7ec" }
                        GradientStop { position: 1.0; color: "#89b4fa" }
                    }

                    Text {
                        text: "🔐"
                        anchors.centerIn: parent
                        font.pixelSize: 36
                    }               
                }

                ColumnLayout {
                    spacing: 8
                    Layout.alignment: Qt.AlignCenter

                    Text {
                        text: "WELCOME BACK"
                        color: "#cdd6f4"
                        font.pixelSize: 28
                        font.bold: true
                        Layout.alignment: Qt.AlignCenter
                    }

                    Text {
                        text: "Sign in to continue your journey"
                        color: "#a6adc8"
                        font.pixelSize: 14
                        Layout.alignment: Qt.AlignCenter
                    }
                }
            }

            // Form
            ColumnLayout {
                spacing: 20
                Layout.fillWidth: true

                // Email Field
                ColumnLayout {
                    spacing: 8
                    Layout.fillWidth: true

                    Text {
                        text: "Email Address"
                        color: "#cdd6f4"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    Rectangle {
                        id: emailField
                        Layout.fillWidth: true
                        Layout.preferredHeight: 55
                        radius: 12
                        color: "#313244"
                        border.width: 2
                        border.color: emailInput.activeFocus ? "#89b4fa" : "#45475a"

                        Behavior on border.color {
                            ColorAnimation { duration: 300 }
                        }

                        Behavior on scale {
                            NumberAnimation { duration: 200 }
                        }

                        TextField {
                            id: emailInput
                            anchors.fill: parent
                            anchors.margins: 8
                            placeholderText: "Enter your email"
                            placeholderTextColor: "#6c7086"
                            color: "#cdd6f4"
                            font.pixelSize: 14
                            background: Rectangle {
                                color: "transparent"
                                border.width: 0
                            }
                            selectByMouse: true

                            onActiveFocusChanged: {
                                if (activeFocus) {
                                    emailField.scale = 1.02
                                } else {
                                    emailField.scale = 1.0
                                }
                            }

                            onTextChanged: {
                                email = text
                            }
                        }
                    }
                }

                // Password Field
                ColumnLayout {
                    spacing: 8
                    Layout.fillWidth: true

                    Text {
                        text: "Password"
                        color: "#cdd6f4"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    Rectangle {
                        id: passwordField
                        Layout.fillWidth: true
                        Layout.preferredHeight: 55
                        radius: 12
                        color: "#313244"
                        border.width: 2
                        border.color: passwordInput.activeFocus ? "#89b4fa" : "#45475a"

                        Behavior on border.color {
                            ColorAnimation { duration: 300 }
                        }

                        Behavior on scale {
                            NumberAnimation { duration: 200 }
                        }

                        TextField {
                            id: passwordInput
                            anchors.fill: parent
                            anchors.margins: 8
                            placeholderText: "Enter your password"
                            placeholderTextColor: "#6c7086"
                            echoMode: TextField.Password
                            color: "#cdd6f4"
                            font.pixelSize: 14
                            background: Rectangle {
                                color: "transparent"
                                border.width: 0
                            }
                            selectByMouse: true

                            onActiveFocusChanged: {
                                if (activeFocus) {
                                    passwordField.scale = 1.02
                                } else {
                                    passwordField.scale = 1.0
                                }
                            }

                            onTextChanged: {
                                password = text
                            }
                        }
                    }
                }

                // Remember Me & Forgot Password
                RowLayout {
                    Layout.fillWidth: true

                    CheckBox {
                        id: rememberMe
                        text: "Remember me"
                        checked: false
                        Material.accent: "#89b4fa"

                        contentItem: Text {
                            text: rememberMe.text
                            color: "#cdd6f4"
                            font.pixelSize: 12
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: rememberMe.indicator.width + rememberMe.spacing
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked:{
                                rememberMe.toggle();
                                Auth.setRemember(rememberMe.checked);
                            }
                        }
                    }

                    Item { Layout.fillWidth: true }

                    Button {
                        id: forgotPasswordBtn
                        text: "Forgot Password?"
                        flat: true
                        Material.foreground: "#89b4fa"
                        font.pixelSize: 12
                        font.bold: false

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: forgotPasswordBtn.clicked()
                        }

                        onClicked: {

                        }
                    }
                }

                // Login Button
                Button {
                    id: loginButton
                    text: "Sign In"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 55
                    Material.background: "#89b4fa"
                    Material.foreground: "#1e1e2e"
                    font.pixelSize: 16
                    font.bold: true
                    hoverEnabled: true

                    background: Rectangle {
                        id: loginButtonBg
                        radius: 12
                        color: loginButton.down ? "#69b0e0" :
                                                  loginButton.hovered ? "#74c7ec" : "#89b4fa"

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }

                        Behavior on scale {
                            NumberAnimation { duration: 200 }
                        }
                    }

                    // Hover and press animations
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Auth.authenticate(email,password);
                        }
                        hoverEnabled: true

                        onEntered: {
                            loginButtonBg.scale = 1.02
                        }
                        onExited: {
                            loginButtonBg.scale = 1.0
                        }
                        onPressed: {
                            loginButtonBg.scale = 0.98
                        }
                        onReleased: {
                            loginButtonBg.scale = loginButton.hovered ? 1.02 : 1.0
                        }
                    }
                }

                // Sign Up Link
                RowLayout {
                    Layout.alignment: Qt.AlignCenter
                    spacing: 2

                    Text {
                        text: "Don't have an account?"
                        color: "#a6adc8"
                        font.pixelSize: 12
                    }

                    Button {
                        id: signUpBtn
                        text: "Sign Up"
                        flat: true
                        Material.foreground: "#89b4fa"
                        font.pixelSize: 12
                        font.bold: true

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: signUpBtn.clicked()
                            hoverEnabled: true

                            onEntered: {
                                signUpBtn.scale = 1.1
                            }
                            onExited: {
                                signUpBtn.scale = 1.0
                            }
                        }

                        Behavior on scale {
                            NumberAnimation { duration: 200 }
                        }

                        onClicked: {

                        }
                    }
                }
            }
        }

        // Card entrance animation
        Component.onCompleted: {
            cardEntranceAnimation.start()
        }

        SequentialAnimation {
            id: cardEntranceAnimation
            NumberAnimation {
                target: loginCard
                property: "scale"
                from: 0.8
                to: 1
                duration: 600
                easing.type: Easing.OutBack
            }
        }
    }
}
