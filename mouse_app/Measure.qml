// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import HeartRateGame

GamePage {
    id: measurePage

    required property DeviceHandler deviceHandler
    property int modeStatus: 0
    property int  synchronizationStatus: 0

    function makeVisible(modeStatus)
    {
     console.log("modeStatus make visible", modeStatus);
        if (modeStatus == 0)
            return true
        else
            return false
    }

    function sensibilityValue()
    {
        if(modeStatus == 0)
            return mouseSettings.clear_sensibility
        else
            return mouseSettings.sensetive_sensibility
    }


    function dynamicSensibilityChange(value)
    {
        console.log("modeStatus during sensitivity changing", modeStatus);
        if(modeStatus == 0)
            return mouseSettings.changeClearSensibilityStatus(value)
        else
            return mouseSettings.changeSensetiveSensibilityStatus(value)
    }

    function sycnhronizedSensibility(sync_clear_sensibility, sync_sensible_sensibility)
    {
        synchronizationStatus = sync_mode
        if(synchronizationStatus == 1 || synchronizationStatus == 0)
        {
            console.log("modeStatus during sensitivity synch", modeStatus);
            if(modeStatus == 0)
                return sync_clear_sensibility
            else
                return sync_sensible_sensibility
        }
    }

    function rightButtonValue()
    {
        if(modeStatus == 0)
            return mouseSettings.clear_mode_right_click_move
        else
            return mouseSettings.sensetive_mode_right_click_move
    }

    function dynamicRightButtonChange(value)
    {
        if(modeStatus == 0)
            return mouseSettings.changeClearRightClickStatus(value)
        else
            return mouseSettings.changeSensetiveRightClickStatus(value)
    }

    function sycnhronizedRightButton(clear_right_click_move, sensible_right_click_move)
    {
        synchronizationStatus = sync_mode
        if(synchronizationStatus == 1 || synchronizationStatus == 0)
        {
            if(modeStatus == 0)
                return clear_right_click_move
            else
                return sensible_right_click_move
        }
    }

    function leftButtonValue()
    {
        if(modeStatus == 0)
            return mouseSettings.clear_mode_left_click_move
        else
            return mouseSettings.sensetive_mode_left_click_move
    }

    function dynamicLeftButtonChange(value)
    {
        if(modeStatus == 0)
            return mouseSettings.changeClearLeftClickStatus(value)
        else
            return mouseSettings.changeSensetiveLeftClickStatus(value)
    }

    function sycnhronizedLeftButton(clear_left_click_move, sensible_left_click_move)
    {
        synchronizationStatus = sync_mode
        if(synchronizationStatus == 1 || synchronizationStatus == 0)
        {
            if(modeStatus == 0)
                return clear_left_click_move
            else
                return sensible_left_click_move
        }
    }

    function scrollingValue()
    {
        if(modeStatus == 0)
            return mouseSettings.clear_mode_scrolling_move
        else
            return mouseSettings.sensetive_mode_scrolling_move
    }

    function dynamicScrollingChange(value)
    {
        if(modeStatus == 0)
            return mouseSettings.changeClearScrollingStatus(value)
        else
            return mouseSettings.changeSensetiveScrollingStatus(value)
    }

    function sycnhronizedScrolling(clear_scrolling_move, sensible_scrolling_move)
    {
        synchronizationStatus = sync_mode
        if(synchronizationStatus == 1 || synchronizationStatus == 0)
        {
            if(modeStatus == 0)
                return clear_scrolling_move
            else
                return sensible_scrolling_move
        }
    }

    function close() {
        deviceHandler.stopMeasurement()
        deviceHandler.disconnectService()
    }

    function start() {
        deviceHandler.startMeasurement();

    }

    function uploadDefaultSettings() {
        deviceHandler.uploadDefaultSettings();
        modeBox.currentIndex = mouseDefaultSettings.mode
        invertionSwitch.checked = mouseDefaultSettings.invertation
        autoClickSwitch.checked = mouseDefaultSettings.auto_click
        sensSlider.value = mouseDefaultSettings.clear_sensibility
        rButtonBox.currentIndex = mouseDefaultSettings.clear_mode_right_click_move
        lButtonBox.currentIndex = mouseDefaultSettings.clear_mode_left_click_move
        scrollingBox.currentIndex = mouseDefaultSettings.clear_mode_scrolling_move
        rightSlider.value = mouseDefaultSettings.clear_right_limit
        leftSlider.value = mouseDefaultSettings.clear_left_limit
        upSlider.value = mouseDefaultSettings.clear_up_limit
        downSlider.value = mouseDefaultSettings.clear_down_limit
    }

    function stop() {
        if (deviceHandler.measuring)
            deviceHandler.stopMeasurement()

        measurePage.showStatsPage()
    }

    errorMessage: deviceHandler.error
    infoMessage: deviceHandler.info

    signal showStatsPage

    Rectangle {
            id: settingsContainer
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:  parent.top
            anchors.left: parent.left
            anchors.right:  parent.right
            anchors.bottomMargin: 2
            anchors.topMargin:2
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            width: measurePage.width
            height: measurePage.height * 0.89
            color: GameSettings.viewColor
            radius: GameSettings.buttonRadius


            Rectangle {
                id:videoBox
                anchors.top:  parent.top
                anchors.left: settingsBox.left
                anchors.right:  parent.right
                anchors.bottom:  settingsBox.bottom
                //anchors.bottomMargin: 5
                anchors.topMargin: 5
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                width: parent.width * 0.3
                height: parent.height * 0.2
                //color: GameSettings.viewColor
                color: "black"


            MediaPlayer {
                id: mediaPlayer

                /*function updateMetadata() {
                    metadataInfo.clear();
                    metadataInfo.read(mediaPlayer.metaData);
                    metadataInfo.read(mediaPlayer.audioTracks[mediaPlayer.activeAudioTrack]);
                    metadataInfo.read(mediaPlayer.videoTracks[mediaPlayer.activeVideoTrack]);
                }*/


                videoOutput: videoOutput
                /*audioOutput: AudioOutput {
                    id: audio
                    muted: playbackControl.muted
                    volume: playbackControl.volume
                }*/
                 //source: "file:///C:/Users/VVI/Desktop/video3.mp4"
                source: "file:///" + applicationDirPath + "/HeartRateGame/images/video3.mp4"


                //onErrorOccurred: { mediaErrorText.text = mediaPlayer.errorString; mediaError.open() }
                //onMetaDataChanged: { updateMetadata() }
                /*onTracksChanged: {
                    audioTracksInfo.read(mediaPlayer.audioTracks);
                    audioTracksInfo.selectedTrack = mediaPlayer.activeAudioTrack;
                    videoTracksInfo.read(mediaPlayer.videoTracks);
                    videoTracksInfo.selectedTrack = mediaPlayer.activeVideoTrack;
                    subtitleTracksInfo.read(mediaPlayer.subtitleTracks);
                    subtitleTracksInfo.selectedTrack = mediaPlayer.activeSubtitleTrack;
                    updateMetadata()
                }
                onActiveTracksChanged: { updateMetadata() }*/
            }

           /* PlayerMenuBar {
                id: menuBar

                anchors.left: parent.left
                anchors.right: parent.right

                visible: !videoOutput.fullScreen

                mediaPlayer: mediaPlayer
                videoOutput: videoOutput
                metadataInfo: metadataInfo
                audioTracksInfo: audioTracksInfo
                videoTracksInfo: videoTracksInfo
                subtitleTracksInfo: subtitleTracksInfo

                onClosePlayer: root.close()
            }*/

            VideoOutput {
                id: videoOutput
                anchors.fill: parent

                /*anchors.top: settingsContainer.top
                anchors.bottom: playbackControl.top
                anchors.left: settingsBox.left
                anchors.right: settingsContainer.right*/

                /*TapHandler {
                    onDoubleTapped: {
                        parent.fullScreen ?  showNormal() : showFullScreen()
                        parent.fullScreen = !parent.fullScreen
                    }
                    onTapped: {
                        metadataInfo.visible = false
                        audioTracksInfo.visible = false
                        videoTracksInfo.visible = false
                        subtitleTracksInfo.visible = false
                    }
                }*/
            }

            Component.onCompleted: {
                mediaPlayer.play()
            }
        }

            PlaybackControl {
                id: playbackControl
                anchors.bottom: settingsContainer.bottom
                anchors.left: videoBox.left
                //anchors.left: settingsBox.left
                //anchors.right: videoBox.right
                anchors.right: videoBox.right
                anchors.bottomMargin: 10
                //anchors.topMargin: 5
                //anchors.leftMargin: 10
                //anchors.rightMargin: 10

                mediaPlayer: mediaPlayer
            }


            Rectangle {
                id:settingsBox
                anchors.top:  parent.top
                anchors.left: parent.left
                //anchors.bottom: settingsContainer.bottom
                anchors.bottom:  playbackControl.top
                anchors.bottomMargin: 10
                anchors.topMargin: 5
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                width: parent.width * 0.17
                height: parent.height * 0.5
                color: GameSettings.viewColor
                //color: "white"

                visible:true


            ScrollView {
                anchors.fill: parent
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                contentHeight: 1000

                ColumnLayout {
                    id: settingsLayout
                    anchors.fill: parent
                    anchors.topMargin: 5
                    anchors.bottomMargin: 10
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 5

                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Choose mode")
                        color: "white"
                    }

                    Rectangle {
                        id: modeRectangle
                         Layout.alignment: Qt.AlignLeft
                         color:"white"
                         Layout.preferredWidth: settingsBox.height * 0.25
                         Layout.preferredHeight: settingsBox.height * 0.08
                         radius: GameSettings.buttonRadius

                         ComboBox {
                             id: modeBox
                             //width: parent.width * 0.8
                             //height: parent.height * 0.6
                             width: modeRectangle.width
                             height: modeRectangle.height
                             currentIndex: mouseDefaultSettings.mode
                             model: ["Clear Mode", "Sensitive Mode"]
                             displayText: currentText
                             anchors.centerIn: parent

                             onCurrentIndexChanged: {
                             mouseSettings.changeModeStatus()
                             modeStatus = modeBox.currentIndex

                             console.log("modeStatus change value", modeStatus);
                             }
                             Connections {
                                 target: deviceHandler

                                onSynchronizeCurrentSettings: {
                                modeStatus = sync_mode
                                modeBox.currentIndex = modeStatus
                                console.log("modeStatus after synchronize", modeStatus);
                             }
                           }
                        }
                    }

                    Rectangle {
                        id:invertionBox
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: settingsBox.height * 0.25
                        Layout.preferredHeight: settingsBox.height * 0.06
                        radius: GameSettings.buttonRadius
                        anchors.topMargin: 5
                        anchors.bottomMargin: 5
                        anchors.leftMargin: 5
                        anchors.rightMargin: 5
                        Switch {
                            id: invertionSwitch
                            anchors.centerIn: parent
                            checked: mouseDefaultSettings.invertation
                            font.pixelSize: GameSettings.tinyFontSize
                            text: qsTr("Invertion")

                            onCheckedChanged: {
                               checked: mouseSettings.changeInvertationStatus()
                            }

                            Connections {
                                target: deviceHandler

                             onSynchronizeCurrentSettings: {
                               invertionSwitch.checked = sync_invertation
                            }
                          }

                        }
                    }

                    Rectangle {
                        id:autoClickBox
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: settingsBox.height * 0.25
                        Layout.preferredHeight: settingsBox.height * 0.06
                        radius: GameSettings.buttonRadius
                        anchors.topMargin: 5
                        anchors.bottomMargin: 5
                        anchors.leftMargin: 5
                        anchors.rightMargin: 5

                        Switch {
                            id: autoClickSwitch
                            anchors.centerIn: parent
                            checked: mouseDefaultSettings.auto_click
                            font.pixelSize: GameSettings.tinyFontSize
                            text: qsTr("Auto click")

                            onCheckedChanged: {
                                checked: mouseSettings.changeAutoClickStatus()
                            }

                            Connections {
                                target: deviceHandler

                               onSynchronizeCurrentSettings: {
                               autoClickSwitch.checked = sync_auto_click
                            }
                          }
                        }

                    }
                    Rectangle {
                        id:modeSensibilityBox
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: settingsBox.height * 0.25
                        Layout.preferredHeight: settingsBox.height * 0.1
                        radius: GameSettings.buttonRadius

                        ColumnLayout {
                            id: gridSensibility
                            anchors.fill: parent
                            anchors.topMargin: 1
                            anchors.bottomMargin: 1
                            anchors.leftMargin: 1
                            anchors.rightMargin: 1
                            spacing:1

                            //rows: 1
                            //columns: 3
                            //columnSpacing: 1
                            //rowSpacing: 1

                            Text {
                                id: sensDesc
                                Layout.alignment: Qt.AlignCenter
                                //Layout.row: 0
                                //Layout.column: 0
                                text: qsTr("Sensibility")
                                //font.pixelSize: GameSettings.tinyFontSize * 0.7
                            }

                            Slider {
                               id:sensSlider
                               Layout.alignment: Qt.AlignCenter
                               width: modeSensibilityBox.width * 0.5
                               anchors.leftMargin: 10
                               anchors.rightMargin: 10
                               //Layout.row: 0
                               //Layout.column: 1

                                from: 2
                                value: sensibilityValue()
                                to: 8
                                stepSize: 1

                                onValueChanged: {
                                    console.log("dynamic Sensibility changed", modeStatus);
                                    value:  dynamicSensibilityChange(value)
                                }

                                Connections {
                                    target: deviceHandler

                                    onSynchronizeCurrentSettings: {
                                    mouseSettings.changeClearSensibilityStatus(sync_clear_sensibility)
                                    mouseSettings.changeSensetiveSensibilityStatus(sync_sensible_sensibility)
                                    //modeStatus = sync_mode
                                    sensSlider.value = sycnhronizedSensibility(sync_clear_sensibility, sync_sensible_sensibility)
                                }
                              }
                            }

                            Text {
                                id: sensValue
                                Layout.alignment: Qt.AlignCenter
                                //Layout.row: 0
                                //Layout.column: 2
                                text: sensSlider.value
                                //font.pixelSize: GameSettings.tinyFontSize * 0.7
                            }


                     }
                 }

                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Choose method")
                        color: "white"
                    }

                    Rectangle {
                        id:methodRectangle
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: settingsBox.height * 0.25
                        Layout.preferredHeight: settingsBox.height * 0.08
                        radius: GameSettings.buttonRadius

                        ComboBox {
                            id: methodBox
                            width: methodRectangle.width
                            height: methodRectangle.height
                            currentIndex: 0
                            model: ["Head", "Hand bush", "Forearm", "Shoulder"]
                            displayText: currentText
                            anchors.centerIn: parent
                        }
                    }

                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Choose control")
                        color: "white"
                    }

                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Right button")
                        color: "white"
                    }

                    Rectangle {
                        id: rButtonRectangle
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: settingsBox.height * 0.25
                        Layout.preferredHeight: settingsBox.height * 0.08
                        radius: GameSettings.buttonRadius



                        ComboBox {
                            id: rButtonBox
                            width: rButtonRectangle.width
                            height: rButtonRectangle.height
                            currentIndex: rightButtonValue()
                            model: ["Turn right", "Turn left", "Up", "Down"]
                            displayText: currentText
                            anchors.centerIn: parent

                            onCurrentIndexChanged: {
                               currentIndex: dynamicRightButtonChange(currentIndex)
                            }
                            Connections {
                                target: deviceHandler

                             onSynchronizeCurrentSettings: {
                                 //modeStatus = sync_mode
                               rButtonBox.currentIndex = sycnhronizedRightButton(sync_clear_right_click_move, sync_sensetive_right_click_move)
                            }
                          }
                        }
                    }

                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Left button")
                        color: "white"
                    }

                    Rectangle {
                        id: lButtonRectangle
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: settingsBox.height * 0.25
                        Layout.preferredHeight: settingsBox.height * 0.08
                        radius: GameSettings.buttonRadius



                        ComboBox {
                            id: lButtonBox
                            width: lButtonRectangle.width
                            height: lButtonRectangle.height
                            currentIndex:  leftButtonValue()
                            model: ["Turn right", "Turn left", "Up", "Down"]
                            displayText: currentText
                            anchors.centerIn: parent

                            onCurrentIndexChanged: {
                               currentIndex: dynamicLeftButtonChange(currentIndex)
                            }

                            Connections {
                                target: deviceHandler

                             onSynchronizeCurrentSettings: {
                                 //modeStatus = sync_mode
                               lButtonBox.currentIndex = sycnhronizedLeftButton(sync_clear_left_click_move, sync_sensetive_left_click_move)
                            }
                          }
                        }
                    }

                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Scrolling")
                        color: "white"
                    }

                    Rectangle {
                        id: scrolingRectangle
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: settingsBox.height * 0.25
                        Layout.preferredHeight: settingsBox.height * 0.08
                        radius: GameSettings.buttonRadius



                        ComboBox {
                            id: scrollingBox
                            width: scrolingRectangle.width
                            height: scrolingRectangle.height
                            currentIndex: scrollingValue()
                            model: ["Turn right", "Turn left", "Up", "Down"]
                            displayText: currentText
                            anchors.centerIn: parent

                            onCurrentIndexChanged: {
                               currentIndex: dynamicScrollingChange(currentIndex)
                            }

                            Connections {
                                target: deviceHandler

                             onSynchronizeCurrentSettings: {
                                 //modeStatus = sync_mode
                               scrollingBox.currentIndex = sycnhronizedScrolling(sync_clear_scrolling_move, sync_sensetive_scrolling_move)
                            }
                        }
                    }
                }


                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Limits")
                        color: "white"
                        visible: makeVisible(modeStatus)
                    }
                    Rectangle {
                        id: limitsRectangle
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: settingsBox.height * 0.25
                        Layout.preferredHeight: settingsBox.height * 0.30
                        radius: GameSettings.buttonRadius
                        visible: makeVisible(modeStatus)

                        GridLayout {
                            id: gridLimits
                            anchors.fill: parent
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2

                            rows: 4
                            columns: 3
                            columnSpacing: 1
                            rowSpacing: 1

                            Text {
                                Layout.alignment: Qt.AlignLeft
                                color: "black"
                                //Layout.preferredWidth: circle.width * 0.1
                                //Layout.preferredHeight: circle.height * 0.1
                                Layout.row: 0
                                Layout.column: 0
                                text: qsTr("Right")
                            }
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                color: "black"
                                //Layout.preferredWidth: circle.width * 0.1
                                //Layout.preferredHeight: circle.height * 0.1
                                Layout.row: 1
                                Layout.column: 0
                                text: qsTr("Left")
                            }
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                color: "black"
                                //Layout.preferredWidth: circle.width * 0.1
                                //Layout.preferredHeight: circle.height * 0.1
                                Layout.row: 2
                                Layout.column: 0
                                text: qsTr("Up")
                            }
                            Text {
                                Layout.alignment: Qt.AlignLeft
                                color: "black"
                                //Layout.preferredWidth: circle.width * 0.1
                                //Layout.preferredHeight: circle.height * 0.1
                                Layout.row: 3
                                Layout.column: 0
                                text: qsTr("Down")
                            }
                            Slider {
                               id:rightSlider
                               width:limitsRectangle.width * 0.5
                               Layout.alignment: Qt.AlignCenter
                               Layout.row: 0
                               Layout.column: 1

                                from: 1000
                                value: mouseDefaultSettings.clear_right_limit
                                to: 8000
                                stepSize: 500

                                onValueChanged: {
                                    value: mouseSettings.changeClearRightLimitStatus(value)
                                }

                                Connections {
                                    target: deviceHandler

                                 onSynchronizeCurrentSettings: {
                                 mouseSettings.changeClearRightLimitStatus(sync_clear_right_limit)
                                 rightSlider.value = sync_clear_right_limit
                                }
                            }
                          }

                            Slider {
                               id:leftSlider
                               width:limitsRectangle.width * 0.5
                               Layout.alignment: Qt.AlignCenter
                               Layout.row: 1
                               Layout.column: 1

                               from: -1000
                               value: mouseDefaultSettings.clear_left_limit
                               to: -8000
                               stepSize: 500

                                onValueChanged: {
                                    value: mouseSettings.changeClearLeftLimitStatus(value)
                                }

                                Connections {
                                    target: deviceHandler

                                   onSynchronizeCurrentSettings: {
                                   mouseSettings.changeClearLeftLimitStatus(sync_clear_left_limit)
                                   leftSlider.value = sync_clear_left_limit
                                }
                            }
                            }

                            Slider {
                               id:upSlider
                               width:limitsRectangle.width * 0.5
                               Layout.alignment: Qt.AlignCenter
                               Layout.row: 2
                               Layout.column: 1

                               from: -1000
                               value: mouseDefaultSettings.clear_up_limit
                               to: -8000
                               stepSize: 500

                                onValueChanged: {
                                    value: mouseSettings.changeClearUpLimitStatus(value)
                                }


                                Connections {
                                    target: deviceHandler

                                     onSynchronizeCurrentSettings: {
                                         mouseSettings.changeClearUpLimitStatus(sync_clear_up_limit)
                                         upSlider.value = sync_clear_up_limit
                                    }
                                }

                            }

                            Slider {
                                id:downSlider
                                width:limitsRectangle.width * 0.5
                               Layout.alignment: Qt.AlignCenter
                               Layout.row: 3
                               Layout.column: 1

                                from: 1000
                                value: mouseDefaultSettings.clear_down_limit
                                to: 8000
                                stepSize: 500

                                onValueChanged: {
                                    value: mouseSettings.changeClearDownLimitStatus(value)
                                }

                                Connections {
                                    target: deviceHandler

                                        onSynchronizeCurrentSettings: {
                                         mouseSettings.changeClearDownLimitStatus(sync_clear_down_limit)
                                         downSlider.value = sync_clear_down_limit
                                    }
                                }
                            }

                            Text {
                                id: rLimitValue
                                Layout.alignment: Qt.AlignCenter
                                Layout.row: 0
                                Layout.column: 2
                                text: rightSlider.value
                                //wrapMode: rightSlider.WrapAtWordBoundaryOrAnywhere

                            }
                            Text {
                                id: lLimitValue
                                Layout.alignment: Qt.AlignCenter
                                Layout.row: 1
                                Layout.column: 2
                                text: leftSlider.value
                                //wrapMode: leftSlider.WrapAtWordBoundaryOrAnywhere

                            }
                            Text {
                                id: upLimitValue
                                Layout.alignment: Qt.AlignCenter
                                Layout.row: 2
                                Layout.column: 2
                                text: upSlider.value
                                //wrapMode: upSlider.WrapAtWordBoundaryOrAnywhere

                            }
                            Text {
                                id: downLimitValue
                                Layout.alignment: Qt.AlignCenter
                                Layout.row: 3
                                Layout.column: 2
                                text: downSlider.value
                                //wrapMode: upDesc.WrapAtWordBoundaryOrAnywhere

                            }

                    }
                }
            }
        }
    }
}
    GameButton {
        id: startButton
        //anchors.top: flick_area.bottom
        anchors.bottom: measurePage.bottom
        anchors.left: measurePage.left
        anchors.right: measurePage.horizontalCenter
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: settingsContainer.height * 0.09
        width: settingsContainer.width * 0.2
        enabled: !measurePage.deviceHandler.measuring

        onClicked: measurePage.start()

        Text {
            anchors.centerIn: parent
            font.pixelSize: GameSettings.tinyFontSize
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -1
            text: qsTr("Upload")
            color: startButton.enabled ? GameSettings.textColor : GameSettings.disabledTextColor
        }
    }
    GameButton {
        id: defaultSettingsButton
        anchors.bottom: measurePage.bottom
        anchors.left: measurePage.horizontalCenter
        anchors.right: measurePage.right
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        height: settingsContainer.height * 0.09
        width: settingsContainer.width * 0.2
        enabled: !measurePage.deviceHandler.measuring

        radius: GameSettings.buttonRadius

        onClicked: measurePage.uploadDefaultSettings()

        Text {
            anchors.centerIn: parent
            font.pixelSize: GameSettings.tinyFontSize
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -1
            text: "Default\nsettings"
            color: startButton.enabled ? GameSettings.textColor : GameSettings.disabledTextColor

        }
    }
}
