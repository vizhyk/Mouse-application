import QtQuick

Rectangle {
    id: frontendButton
    color: "blue"
    onEnabledChanged: checkColor()
    radius: GameSettings.buttonRadius

    property color baseColor: "blue"
    property color pressedColor: GameSettings.buttonPressedColor
    property color disabledColor: GameSettings.disabledButtonColor

    signal clicked

    function checkColor() {
        if (!frontendButton.enabled) {
            frontendButton.color = disabledColor
        } else {
            if (frontendMouseArea.containsPress)
                frontendButton.color = pressedColor
            else
                frontendButton.color = baseColor
        }
    }

    MouseArea {
        id: frontendMouseArea
        anchors.fill: parent
        onPressed: frontendButton.checkColor()
        onReleased: frontendButton.checkColor()
        onClicked: {
            frontendButton.checkColor()
            frontendButton.clicked()
        }
    }
}
