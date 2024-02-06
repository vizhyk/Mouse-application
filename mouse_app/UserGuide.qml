import QtQuick

GamePage {

    required property DeviceHandler deviceHandler

    id: userGuidePage

    EyeClickButton {
        id: someButton
        anchors.centerIn: parent
       // anchors.horizontalCenter: parent.horizontalCenter
       // anchors.top: parent.bottom
        //anchors.topMargin: GameSettings.fieldMargin
        //anchors.bottomMargin: GameSettings.fieldMargin
        //Layout.preferredWidth: eyeClickSettingsBox.height * 0.22
        //Layout.preferredHeight: eyeClickSettingsBox.height * 0.08
        width: parent.width * 0.2
        height:  parent.height * 0.05
        color: "white"
        //onClicked: profiePage.startUpdater()


        Text {
            anchors.centerIn: parent
            font.pixelSize: GameSettings.tinyFontSize
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -1
            text: qsTr("Do nothing")
            color: "black"
        }
    }

}
