// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound
import QtQuick
//import HeartRateGame 1.0

Rectangle {
    id: titleBar

    property var __titles: ["UPDATE" ,"CONNECT", "SETTINGS", "HOME", "DETECT EYE", "PROFILE", "USER GUIDE", "LOGIN"]
    property int currentIndex: 0

    signal titleClicked(int index)

    height: GameSettings.fieldHeight
    color: GameSettings.viewColor

    Repeater {
        model: 8
        Text {
            id: caption
            required property int index
            width: titleBar.width / 8
            height: titleBar.height
            x: index * width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: titleBar.__titles[index]
            font.pixelSize: GameSettings.tinyFontSize
            color: titleBar.currentIndex === index ? GameSettings.textColor
                                                   : GameSettings.disabledTextColor

            MouseArea {
                anchors.fill: parent
                onClicked: titleBar.titleClicked(caption.index)
            }
        }
    }

    Item {
        anchors.bottom: parent.bottom
        width: parent.width / 8
        height: parent.height
        x: titleBar.currentIndex * width

        BottomLine {}

        Behavior on x {
            NumberAnimation {
                duration: 200
            }
        }
    }
}
