// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import HeartRateGame


GamePage {

    id: statsPage

    required property DeviceHandler deviceHandler
    property int level: statsPage.deviceHandler.charge // 0-4 levels

    function batteryImage()
    {
        if (level <= 100 && level >= 76)
            return "images/battery-full-solid.png" // fa-battery-full
        else if (level >= 1 && level <= 5)
            return "images/battery-empty-solid.png" // fa-battery-empty
        else if (level <= 75 && level >= 50)
            return "images/battery-three-quarters-solid.png" // fa-battery-half
        else if (level <= 50 && level >= 25)
            return "images/battery-half-solid.png" // fa-battery-three-quarters
        else if (level <= 25 && level >= 6)
            return "images/battery-quarter-solid.png" // fa-battery-full
        else
            return "images/battery-empty-solid.png" // fa-battery-empty
    }

    /*function startEyeDetector() {
        deviceHandler.startDetector()
    }*/

    Rectangle {
        id: batteryContainer
        width: Math.min(statsPage.width, statsPage.height - GameSettings.fieldHeight * 4)
               - GameSettings.fieldMargin
        height: width
        radius: width * 2
        color: GameSettings.viewColor

        anchors.centerIn: parent

        ColumnLayout{
            anchors.centerIn: parent
            spacing: 1


            Text {
                Layout.alignment: Qt.AlignCenter
                font.pixelSize: GameSettings.hugeFontSize * 0.8
                color: GameSettings.textColor
                text: qsTr("Battery level")
              }

      Image {
          signal chargeValueChangeg(int chargeValue)
          id: batteryCharge
          Layout.alignment: Qt.AlignCenter
          //anchors.centerIn: parent
          Layout.preferredWidth: batteryContainer.width * 0.5
          Layout.preferredHeight: batteryContainer.height * 0.5
          source: batteryImage()

        onChargeValueChangeg: {
            batteryCharge.source = ""
            batteryCharge.source = batteryImage()
        }


            //color: GameSettings.viewColor




      }

      Text {

        id: batValue

        Layout.alignment: Qt.AlignCenter
        font.pixelSize: GameSettings.giganticFontSize
        color: GameSettings.textColor
        text: " " + statsPage.deviceHandler.charge + "%"
      }
     }

/*      GameButton {
          id: startEyeDetector
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.bottom
          anchors.topMargin: GameSettings.fieldMargin
          anchors.bottomMargin: GameSettings.fieldMargin
          width: batteryContainer.width * 0.5
          height: GameSettings.fieldHeight
          onClicked: statsPage.startEyeDetector()

          Text {
              anchors.centerIn: parent
              font.pixelSize: GameSettings.tinyFontSize
              anchors.verticalCenterOffset: 0
              anchors.horizontalCenterOffset: -1
              text: qsTr("Enable eye detector")
              color: startEyeDetector.enabled ? GameSettings.textColor : GameSettings.disabledTextColor
          }
      }*/


      /*  Item {
            height: GameSettings.fieldHeight
            width: 1
        }



        StatsLabel {
            title: qsTr("MIN")
            value: statsPage.deviceHandler.minHR.toFixed(0)
        }

        StatsLabel {
            title: qsTr("MAX")
            value: statsPage.deviceHandler.maxHR.toFixed(0)
        }

        StatsLabel {
            title: qsTr("AVG")
            value: statsPage.deviceHandler.average.toFixed(1)
        }

        StatsLabel {
            title: qsTr("CALORIES")
            value: statsPage.deviceHandler.calories.toFixed(3)
        }*/
    }
}
