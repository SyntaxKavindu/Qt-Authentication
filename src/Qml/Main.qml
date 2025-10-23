import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Authentication 1.0

Window {
    width: 1070
    height: 700
    minimumWidth: 1070
    minimumHeight:700
    maximumHeight: 1070
    maximumWidth:700
    visible: true
    title: qsTr("Authentication")

    Component.onCompleted: {
        Auth.verifyAuthenticate();
    }

    StackView {
        id: pageStackView
        anchors.fill: parent
        initialItem: loadingPage

        // Cross-fade transitions
        replaceEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    }

    Connections{
        target: Auth
        function onLoadingChanged(value){
            if(value)
            {
                pageStackView.replace(loadingPage);
            }
        }
    }

    Connections{
        target: Auth
        function  onLoginSuccess(){
            pageStackView.replace(homePage);
        }
    }

    Connections{
        target: Auth
        function  onProfileFetched(){
            pageStackView.replace(homePage);
        }
    }

    Connections{
        target: Auth
        function  onLoginFailed(error){
            console.log(error);
            pageStackView.replace(loginPage);
        }
    }

    Connections{
        target: Auth
        function  onProfileFetchFailed(error){
            console.log(error);
            pageStackView.replace(loginPage);
        }
    }

    Connections{
        target: Auth
        function  onAutoLoginFailed(){
            pageStackView.replace(loginPage);
        }
    }

    Component {
        id: loadingPage
        Loading {
        }
    }

    Component {
        id: loginPage
        Login {
        }
    }

    Component {
        id: homePage
        Home {
        }
    }
}
