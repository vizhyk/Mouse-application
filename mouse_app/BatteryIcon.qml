import QtQuick

Item {

    id: batteryStatus

    property int level: 2 // 0-4 levels

    function getUnicode()
    {
        if (level == 0)
            return "\uf244" // fa-battery-empty
        else if (level == 1)
            return "\uf243" // fa-battery-quarter
        else if (level == 2)
            return "images/battery-three-quarters-solid.png" // fa-battery-half
        else if (level == 3)
            return "\uf241" // fa-battery-three-quarters
        else if (level == 4)
            return "\uf240" // fa-battery-full
        else
            return "\uf244" // fa-battery-empty
    }

    Image {
        id: halfbatt
        width: 100
        height: 100
        source: getUnicode()
    }

    FontLoader { id: fontAwesome; source: "qrc:/FontAwesome.ttf" }

}
