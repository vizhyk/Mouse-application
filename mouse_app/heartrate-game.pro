TEMPLATE = app
TARGET = heartrate-game
QT += qml quick bluetooth

CONFIG += qmltypes
QML_IMPORT_NAME = HeartRateGame
QML_IMPORT_MAJOR_VERSION = 1

QML_IMPORT_PATH = $$PWD
QML_DESIGNER_IMPORT_PATH = $$PWD


HEADERS += \
    connectionhandler.h \
    deviceinfo.h \
    devicefinder.h \
    devicehandler.h \
    bluetoothbaseclass.h \
    heartrate-global.h

SOURCES += main.cpp \
    connectionhandler.cpp \
    deviceinfo.cpp \
    devicefinder.cpp \
    devicehandler.cpp \
    bluetoothbaseclass.cpp

qml_resources.files = \
    qmldir \
    App.qml \
    BluetoothAlarmDialog.qml \
    BottomLine.qml \
    Connect.qml \
    GameButton.qml \
    GamePage.qml \
    GameSettings.qml \
    Measure.qml \
    SplashScreen.qml \
    Stats.qml \
    StatsLabel.qml \
    TitleBar.qml \
    Main.qml \
    images/bt_off_to_on.png \
    images/logo.png \
    images/battery-three-quarters-solid.png \
    BatteryIcon.qml \
    UserGuide.qml

qml_resources.prefix = /qt/qml/HeartRateGame

RESOURCES = qml_resources \
    fonts.qrc

ios: QMAKE_INFO_PLIST = ../shared/Info.qmake.ios.plist
macos: QMAKE_INFO_PLIST = ../shared/Info.qmake.macos.plist

target.path = $$[QT_INSTALL_EXAMPLES]/bluetooth/heartrate-game
INSTALLS += target

DISTFILES += \
    test_file.qml

