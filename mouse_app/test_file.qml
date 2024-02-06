import QtQuick
//import HeartRateGame 1.0


GamePage {

    id: statsPage

    property int level: 2 // 0-4 levels
    required property DeviceHandler deviceHandler


    function getUnicode()
    {
        if (level == 0)
            return "\uf244" // fa-battery-empty
        else if (level == 1)
            return "\uf243" // fa-battery-quarter
        else if (level == 2)
            return "images/battery-three-quarters-solid.png" // fa-battery-half
        else if (level == 3)
            return "\uf241" // fa-battery-three-quarters
        else if (level == 4)
            return "\uf240" // fa-battery-full
        else
            return "\uf244" // fa-battery-empty
    }




   /* Column {
        anchors.centerIn: parent
        width: parent.top
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0 */


    Rectangle {
        id: viewContainer
        anchors.top: parent.top
        // only BlueZ platform has address type selection
        anchors.bottom: connectPage.connectionHandler.requiresAddressType ? addressTypeButton.top
                                                                          : searchButton.top
        anchors.topMargin: GameSettings.fieldMargin + connectPage.messageHeight
        anchors.bottomMargin: GameSettings.fieldMargin
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - GameSettings.fieldMargin * 2
        color: GameSettings.viewColor
        radius: GameSettings.buttonRadius

      Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: GameSettings.hugeFontSize
            color: GameSettings.textColor
            text: qsTr("Battery level")
        }


      Image {
          id: halfbatt
          //anchors.horizontalCenter: parent.horizontalCenter
         // width: 100
         // height: 100
          //anchors.horizontalCenter: minMaxContainer.horizontalCenter
          //anchors.verticalCenter: minMaxContainer.bottom
          //anchors.centerIn: parent
          width: 100
          height: 100
          source: getUnicode()
      }
          Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: GameSettings.giganticFontSize * 2
            color: GameSettings.textColor
            text:  qsTr("100%")
        }

    }
}
