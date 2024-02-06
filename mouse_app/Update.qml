// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import HeartRateGame


GamePage {

    id: updatePage


    /*EyeClickButton {
        id: startWirelessUpdater
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
        onClicked: profilePage.startUpdater()


        Text {
            anchors.centerIn: parent
            font.pixelSize: GameSettings.tinyFontSize
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -1
            text: qsTr("Update Firmware")
            color: "black"
        }
    }*/

    ColumnLayout{

        spacing: 20

        anchors.centerIn: parent

        Rectangle {
            Layout.alignment: Qt.AlignCenter
            color: "white"
            Layout.preferredWidth: updatePage.width * 0.9
            Layout.preferredHeight: updatePage.height * 0.08


            Text {
                anchors.centerIn: parent
                font.pixelSize: GameSettings.tinyFontSize
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: -1
                text: qsTr("Firmware Notification Box for future updates V0.0.1")
                color: "red"
            }
        }

        Rectangle {
            Layout.alignment: Qt.AlignCenter
            color: "white"
            Layout.preferredWidth: updatePage.width * 0.9
            Layout.preferredHeight: updatePage.height * 0.08

            Text {
                anchors.centerIn: parent
                font.pixelSize: GameSettings.tinyFontSize
                anchors.verticalCenterOffset: 0
                anchors.horizontalCenterOffset: -1
                text: qsTr("Short description abot updates. More Information you can find here https://...")
                color: "black"
            }
        }


         Dialog {
                 id: networkDialog
                 //title: "network Dialog"
                 standardButtons:  Dialog.Ok | Dialog.Cancel
                 implicitWidth: parent.width * 0.5
                 implicitHeight: parent.height * 0.5

         }


        EyeClickButton {
                id: registerInNetwork
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: updatePage.width * 0.22
                Layout.preferredHeight: updatePage.height * 0.08
                color: "white"
                onClicked: networkDialog.open()


                Text {
                    anchors.centerIn: parent
                    font.pixelSize: GameSettings.tinyFontSize
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: -1
                    text: qsTr("Register in network")
                    color: "black"
                }
        }

        EyeClickButton {
                id: startWirelessUpdater
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: updatePage.width * 0.22
                Layout.preferredHeight: updatePage.height * 0.08
                color: "white"
                onClicked: updatePage.startUpdater()


                Text {
                    anchors.centerIn: parent
                    font.pixelSize: GameSettings.tinyFontSize
                    anchors.verticalCenterOffset: 0
                    anchors.horizontalCenterOffset: -1
                    text: qsTr("Update Firmware")
                    color: "black"
                }
        }
    }
}
