// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Layouts
import HeartRateGame

Item {
    id: app

    required property ConnectionHandler connectionHandler
    required property DeviceFinder deviceFinder
    required property DeviceHandler deviceHandler

    anchors.fill: parent
    opacity: 0.0

    Behavior on opacity {
        NumberAnimation {
            duration: 500
        }
    }

    property int __currentIndex: 2              //starting page

    TitleBar {
        id: titleBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        currentIndex: app.__currentIndex

        onTitleClicked: (index) => {
                app.__currentIndex = index
        }
    }

    StackLayout {
        id: pageStack
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        currentIndex: app.__currentIndex

        Update {

        }

        Connect {
            connectionHandler: app.connectionHandler
            deviceFinder: app.deviceFinder
            deviceHandler: app.deviceHandler

            onShowMeasurePage: app.__currentIndex = 1
        }
        Measure {
            id: measurePage
            deviceHandler: app.deviceHandler
            objectName: "modeBox"

            onShowStatsPage: app.__currentIndex = 2
        }
        Stats {
            deviceHandler: app.deviceHandler

        }
        EyeClick {
            deviceHandler: app.deviceHandler

            onShowEyeClickPage: app.currentIndex = 4
        }
        Profile {
            deviceHandler: app.deviceHandler
        }
        UserGuide {
            deviceHandler: app.deviceHandler
        }
        PageView {

        }

        onCurrentIndexChanged: {
            if (currentIndex === 0)
                measurePage.close()
        }
    }

    BluetoothAlarmDialog {
        id: btAlarmDialog
        anchors.fill: parent
        visible: !app.connectionHandler.alive
    }

    Keys.onReleased: (event) => {
        switch (event.key) {
        case Qt.Key_Escape:
        case Qt.Key_Back:
        {
            if (app.__currentIndex > 0) {
                app.__currentIndex = app.__currentIndex - 1
                event.accepted = true
            } else {
                Qt.quit()
            }
            break
        }
        default:
            break
        }
    }

    Component.onCompleted: {
        forceActiveFocus()
        app.opacity = 1.0
    }
}
