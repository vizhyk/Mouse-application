import QtQuick
import QtQuick.Controls

GamePage {

    id: viewPage

    StackView {
        id:stackView
        anchors.fill: parent
        initialItem: regPage
    }

    RegistrationPage {
        id:regPage
         onRegistrationButtonClicked:{
             stackView.push(logPage)
         }
         onRegistrationTextClicked: {
             stackView.push(logPage)
         }
    }
    LoginPage {
        id:logPage
        visible:false
        onForgotTextClicked: {
            stackView.push(passPage)
        }
    }
    ForgotPasswordPage {
        id:passPage
        visible: false
    }

}
