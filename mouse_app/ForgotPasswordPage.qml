import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


GamePage {

    id: forgotPasswordPage

    ColumnLayout{

        id:forgotPasswordFormLayout
        anchors.centerIn: parent
        spacing: 10

        Text {
            id: forgotPasswordDesc
            Layout.alignment: Qt.AlignCenter
            color: "white"
            text: qsTr("Forgot password")
            font.pixelSize: GameSettings.giganticFontSize * 0.5
        }

        TextField {
            id:forgotPasswordField
            Layout.alignment: Qt.AlignCenter
            color: "black"
            Layout.preferredWidth: forgotPasswordPage.width * 0.2
            //Layout.preferredHeight: forgotPasswordPage.height * 0.03
            placeholderText: qsTr("email@anymail.com")
        }

        TextField {
            id:passwordField
            Layout.alignment: Qt.AlignCenter
            color: "black"
            Layout.preferredWidth: forgotPasswordPage.width * 0.2
            //Layout.preferredHeight: forgotPasswordPage.height * 0.03
            echoMode: TextInput.Password
            placeholderText: qsTr("password")
        }


            FrontendButton {
                id: letMeInButton
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: forgotPasswordPage.width * 0.2
                Layout.preferredHeight: forgotPasswordPage.height * 0.04
                color: "blue"
                onClicked: console.log("let me in");


                Text {
                    anchors.centerIn: parent
                    font.pixelSize: GameSettings.tinyFontSize
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: -1
                    text: qsTr("Let me in")
                    color: "white"
                }
            }
        }
    }


