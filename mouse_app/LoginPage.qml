import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


GamePage {

    id: loginPage
    signal forgotTextClicked();

    ColumnLayout {

        id:loginFormLayout
        anchors.centerIn: parent
        spacing: 10


        Text {
            id: greetingsDesc
            Layout.alignment: Qt.AlignCenter
            color: "white"
            text: qsTr("Greetings!")
            font.pixelSize: GameSettings.giganticFontSize * 0.5
        }

        Text {
            id: loginDesc
            Layout.alignment: Qt.AlignCenter
            color: "white"
            text: qsTr("Happy to see you here")
            font.pixelSize: GameSettings.giganticFontSize * 0.5
        }

        TextField {
            id:loginField
            Layout.alignment: Qt.AlignCenter
            color: "black"
            Layout.preferredWidth: loginPage.width * 0.2
            //Layout.preferredHeight: loginPage.height * 0.03
            placeholderText: qsTr("email@anymail.com")
        }

        TextField {
            id:passwordField
            Layout.alignment: Qt.AlignCenter
            color: "black"
            Layout.preferredWidth: loginPage.width * 0.2
            //Layout.preferredHeight: loginPage.height * 0.03
            echoMode: TextInput.Password
            placeholderText: qsTr("password")
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            color: passwordMouseArea.containsMouse ? "magenta" : "blue"
            text: qsTr("Forgot password")
            font.pixelSize: GameSettings.tinyFontSize * 0.5

            MouseArea {
                id: passwordMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                     console.log("forgot passsword");
                    loginPage.forgotTextClicked();
                }
            }

         }



            FrontendButton {
                id: letMeInButton
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: loginPage.width * 0.2
                Layout.preferredHeight: loginPage.height * 0.04
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


