// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Window
import HeartRateGame

Window {
    id: wroot
    visible: true
    //width: 720 * .7
    //height: 1240 * .7
    width: 1200
    height: 1000
    title: qsTr("mouse-app")
    color: GameSettings.backgroundColor

    required property ConnectionHandler connectionHandler
    required property DeviceFinder deviceFinder
    required property DeviceHandler deviceHandler
    required property MouseDefaultSettings mouseDefaultSettings
    required property MouseSettings mouseSettings

    Component.onCompleted: {
        GameSettings.wWidth = Qt.binding(function () {
            return width
        })
        GameSettings.wHeight = Qt.binding(function () {
            return height
        })
    }

    Loader {
        id: splashLoader
        anchors.fill: parent
        asynchronous: false
        visible: true

        sourceComponent: SplashScreen {
            appIsReady: appLoader.status === Loader.Ready
            onReadyChanged: {
                if (ready) {
                    appLoader.visible = true
                    splashLoader.visible = false
                    splashLoader.active = false
                }
            }
        }

        onStatusChanged: {
            if (status === Loader.Ready)
                appLoader.active = true
        }
    }

    Loader {
        id: appLoader
        anchors.fill: parent
        active: false
        asynchronous: true
        visible: false

        sourceComponent: App {
            connectionHandler: wroot.connectionHandler
            deviceFinder: wroot.deviceFinder
            deviceHandler: wroot.deviceHandler


        }

        onStatusChanged: {
            if (status === Loader.Error)
                Qt.quit()
        }
    }

}
