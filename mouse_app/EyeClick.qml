// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import HeartRateGame

GamePage {
    id: eyeClickPage

    required property DeviceHandler deviceHandler
    property int counter: 0

    errorMessage: deviceHandler.error
    infoMessage: deviceHandler.info

    signal showEyeClickPage

    function startEyeDetector() {
        deviceHandler.startDetector()
    }


    function isVisible(indexLValue,indexRValue) {
        if(indexLValue >= 2 || indexRValue >= 2)
            return true
        else
            return false
    }

    function switchEyeButtons(indexValue)
    {
        if(indexValue === 0)
            return 1
        if(indexValue === 1)
            return 0
        else
            return 1
    }

    Rectangle {
            id: eyeClickContainer
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.top:  parent.top
            anchors.left: parent.left
            anchors.right:  parent.right
            anchors.bottomMargin: 2
            anchors.topMargin:2
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            width: eyeClickPage.width
            height: eyeClickPage.height * 0.99
            color: GameSettings.viewColor
            radius: GameSettings.buttonRadius


            Rectangle {
                id:videoBox
                anchors.top:  parent.top
                anchors.left: eyeClickSettingsBox.left
                anchors.right:  parent.right
                anchors.bottom:  eyeClickSettingsBox.bottom
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

                /*anchors.top: eyeClickContainer.top
                anchors.bottom: playbackControl.top
                anchors.left: eyeClickSettingsBox.left
                anchors.right: eyeClickContainer.right*/

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
                anchors.bottom: eyeClickContainer.bottom
                anchors.left: videoBox.left
                //anchors.left: eyeClickSettingsBox.left
                //anchors.right: videoBox.right
                anchors.right: videoBox.right
                anchors.bottomMargin: 10
                //anchors.topMargin: 5
                //anchors.leftMargin: 10
                //anchors.rightMargin: 10

                mediaPlayer: mediaPlayer
            }






            Rectangle {
                id:eyeClickSettingsBox
                anchors.top:  parent.top
                anchors.left: parent.left
                //anchors.bottom: eyeClickContainer.bottom
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

                ColumnLayout {
                    id: eyeClickSettingsLayout
                    anchors.fill: parent
                    anchors.topMargin: 5
                    anchors.bottomMargin: 10
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 5

                   /* Rectangle {
                        id: enableEyeClick
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: eyeClickSettingsBox.height * 0.22
                        Layout.preferredHeight: eyeClickSettingsBox.height * 0.08
                        radius: GameSettings.buttonRadius*/

                        EyeClickButton {
                            id: startEyeDetector
                           // anchors.horizontalCenter: parent.horizontalCenter
                           // anchors.top: parent.bottom
                            //anchors.topMargin: GameSettings.fieldMargin
                            //anchors.bottomMargin: GameSettings.fieldMargin
                            Layout.preferredWidth: eyeClickSettingsBox.height * 0.22
                            Layout.preferredHeight: eyeClickSettingsBox.height * 0.08
                            //width: parent.width
                            //height:  parent.height
                            color: "white"
                            onClicked: eyeClickPage.startEyeDetector()


                            Text {
                                anchors.centerIn: parent
                                font.pixelSize: GameSettings.tinyFontSize
                                anchors.verticalCenterOffset: 0
                                anchors.horizontalCenterOffset: -1
                                text: qsTr("detect eye")
                                color: "black"
                            }
                        }
                   // }

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
                        text: qsTr("Left button")
                        color: "white"
                    }

                    Rectangle {
                        id: lEyeClickButtonRectangle
                        Layout.alignment: Qt.AlignLeft
                        color:"grey"
                        Layout.preferredWidth: eyeClickSettingsBox.height * 0.22
                        Layout.preferredHeight: eyeClickSettingsBox.height * 0.08
                        radius: GameSettings.buttonRadius



                        ComboBox {
                            id: lEyeClickButtonBox
                            width: lEyeClickButtonRectangle.width
                            height: lEyeClickButtonRectangle.height
                            currentIndex:  0
                            model: ["Blink the left eye", "Blink the right eye", "Double blink", "close eyes"]
                            displayText: currentText
                            anchors.centerIn: parent

                            onCurrentIndexChanged: {
                                deviceHandler.changeLeftEyeValue(currentIndex)

                            }

                        }
                    }

                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Timer")
                        color: "white"
                        visible: isVisible(lEyeClickButtonBox.currentIndex, rEyeClickButtonBox.currentIndex)
                    }

                    Rectangle {
                        id:eyeTimerBox
                        Layout.alignment: Qt.AlignLeft
                        color:"white"
                        Layout.preferredWidth: eyeClickSettingsBox.height * 0.22
                        Layout.preferredHeight: eyeClickSettingsBox.height * 0.07
                        radius: GameSettings.buttonRadius
                        visible: isVisible(lEyeClickButtonBox.currentIndex, rEyeClickButtonBox.currentIndex)

                        ColumnLayout {
                            id: eyeTimerLayouy
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
                                id: timeDesc
                                Layout.alignment: Qt.AlignCenter
                                //Layout.row: 0
                                //Layout.column: 0
                                text: qsTr("time")
                                //font.pixelSize: GameSettings.tinyFontSize * 0.7
                            }

                            Slider {
                               id:timeSlider
                               Layout.alignment: Qt.AlignCenter
                               width: eyeTimerBox.width * 0.5
                               anchors.leftMargin: 10
                               anchors.rightMargin: 10
                               //Layout.row: 0
                               //Layout.column: 1

                                from: 2
                                value: 4
                                to: 4
                                stepSize: 1

                                onValueChanged: {
                                    deviceHandler.changeTimerValue(timeSlider.value)
                                }

                            }

                            Text {
                                id: timeValue
                                Layout.alignment: Qt.AlignCenter
                                //Layout.row: 0
                                //Layout.column: 2
                                text: timeSlider.value
                                //font.pixelSize: GameSettings.tinyFontSize * 0.7
                            }
                     }
                 }

                    Text {
                         Layout.alignment: Qt.AlignCenter
                        font.pixelSize: GameSettings.tinyFontSize
                        anchors.topMargin: 0
                        text: qsTr("Right button")
                        color: "white"
                    }

                    Rectangle {
                        id: rEyeClickButtonRectangle
                        Layout.alignment: Qt.AlignLeft
                        color:"grey"
                        Layout.preferredWidth: eyeClickSettingsBox.height * 0.22
                        Layout.preferredHeight: eyeClickSettingsBox.height * 0.08
                        radius: GameSettings.buttonRadius



                        ComboBox {
                            id: rEyeClickButtonBox
                            width: rEyeClickButtonRectangle.width
                            height: rEyeClickButtonRectangle.height
                            currentIndex: 1
                            model: ["Blink the left eye", "Blink the right eye", "Double blink", "close eyes"]
                            displayText: currentText
                            anchors.centerIn: parent

                            onCurrentIndexChanged: {
                                deviceHandler.changeRightEyeValue(currentIndex)
                            }
                        }
                    }
                }
            }
        }
    }
}
