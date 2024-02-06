// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Rectangle {
    id: eyeButton
    color: "white"
    onEnabledChanged: checkColor()
    radius: GameSettings.buttonRadius

    property color baseColor: "white"
    property color pressedColor: GameSettings.buttonPressedColor
    property color disabledColor: GameSettings.disabledButtonColor

    signal clicked

    function checkColor() {
        if (!eyeButton.enabled) {
            eyeButton.color = disabledColor
        } else {
            if (mouseArea.containsPress)
                eyeButton.color = pressedColor
            else
                eyeButton.color = baseColor
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: eyeButton.checkColor()
        onReleased: eyeButton.checkColor()
        onClicked: {
            eyeButton.checkColor()
            eyeButton.clicked()
        }
    }
}
