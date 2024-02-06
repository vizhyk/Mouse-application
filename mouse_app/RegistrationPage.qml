import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

GamePage {  

    function sendPostCreateUser()
    {
        console.log("Send post Create User");
        pageViewBackEnd.createAccountRequest()
    }

    id: registrationPage
    signal registrationButtonClicked();
    signal registrationTextClicked();

    ColumnLayout{

        id:registrationFormLayout
        anchors.centerIn: parent
        spacing: 10

        Text {
            id: userDesc
            Layout.alignment: Qt.AlignCenter
            color: "white"
            text: qsTr("New user")
            font.pixelSize: GameSettings.giganticFontSize * 0.8
        }

        TextField {
            id:emailField
            Layout.alignment: Qt.AlignCenter
            color: "black"
            Layout.preferredWidth: registrationPage.width * 0.2
            //Layout.preferredHeight: registrationPage.height * 0.03
            placeholderText: qsTr("email@anymail.com")
        }

        TextField {
            id:passwordField
            Layout.alignment: Qt.AlignCenter
            color: "black"
            Layout.preferredWidth: registrationPage.width * 0.2
            //Layout.preferredHeight: registrationPage.height * 0.03
            echoMode: TextInput.Password
            placeholderText: qsTr("password")
        }

        TextField {
            id:repeatPasswordField
            Layout.alignment: Qt.AlignCenter
            color: "black"
            Layout.preferredWidth: registrationPage.width * 0.2
            //Layout.preferredHeight: registrationPage.height * 0.02
            echoMode: TextInput.Password
            placeholderText: qsTr("repeat password")
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            color: textMouseArea.containsMouse ? "magenta" : "blue"
            text: qsTr("I have already account")
            font.pixelSize: GameSettings.tinyFontSize * 0.5

            MouseArea {
                id: textMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    registrationPage.registrationTextClicked();
                }
            }
         }



            FrontendButton {
                id: letMeInButton
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: registrationPage.width * 0.2
                Layout.preferredHeight: registrationPage.height * 0.04
                color: "blue"
                onClicked: {
                    //registrationPage.registrationButtonClicked();
                    registrationPage.sendPostCreateUser()

                }



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




