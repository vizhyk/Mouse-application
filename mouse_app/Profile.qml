// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import HeartRateGame


GamePage {

    required property DeviceHandler deviceHandler

    function startUpdater() {
        deviceHandler.startWireUpdater()
    }


    id: profilePage

    EyeClickButton {
        id: startWireUpdater
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
    }

}
