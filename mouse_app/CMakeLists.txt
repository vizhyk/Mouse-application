# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.16)
project(mouse-app LANGUAGES CXX)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()


find_package(Qt6 REQUIRED COMPONENTS Bluetooth Core Gui Qml Quick QuickControls2 Svg)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(mouse-app
    heartrate-global.h
    main.cpp
)

set_target_properties(mouse-app PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(mouse-app PRIVATE
    Qt::Bluetooth
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
)

set_source_files_properties(GameSettings.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(mouse-app
    URI HeartRateGame
    VERSION 1.0
    SOURCES
        bluetoothbaseclass.cpp bluetoothbaseclass.h
        connectionhandler.cpp connectionhandler.h
        devicefinder.cpp devicefinder.h
        devicehandler.cpp devicehandler.h
        deviceinfo.cpp deviceinfo.h
        mousesettings.cpp mousesettings.h
    QML_FILES
        App.qml
        BluetoothAlarmDialog.qml
        BottomLine.qml
        Connect.qml
        GameButton.qml
        GamePage.qml
        GameSettings.qml
        Measure.qml
        SplashScreen.qml
        Stats.qml
        StatsLabel.qml
        TitleBar.qml
        Main.qml
        EyeClick.qml
        EyeClickButton.qml
    RESOURCES
        images/bt_off_to_on.png
        images/logo.png
        images/battery-empty-solid.png
        images/battery-quarter-solid.png
        images/battery-half-solid.png
        images/battery-three-quarters-solid.png
        images/battery-full-solid.png
        SOURCES mousedefaultsettings.h mousedefaultsettings.cpp
        QML_FILES AudioControl.qml PlaybackControl.qml PlaybackRateControl.qml PlaybackSeekControl.qml
        RESOURCES images/Mute_Icon.svg images/Speaker_Icon.svg
        QML_FILES Profile.qml
        QML_FILES RegistrationPage.qml
        QML_FILES UserGuide.qml
        QML_FILES FrontendButton.qml
        QML_FILES LoginPage.qml
        QML_FILES ForgotPasswordPage.qml
        QML_FILES PageView.qml
        SOURCES pageviewbackend.h pageviewbackend.cpp
        QML_FILES Update.qml
)

if (APPLE)
    # Using absolute path for shared plist files is a Ninja bug workaround
    get_filename_component(SHARED_PLIST_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../shared ABSOLUTE)
    if (IOS)
        set_target_properties(heartrate-game PROPERTIES
            MACOSX_BUNDLE_INFO_PLIST "${SHARED_PLIST_DIR}/Info.cmake.ios.plist"
        )
    else()
        set_target_properties(heartrate-game PROPERTIES
            MACOSX_BUNDLE_INFO_PLIST "${SHARED_PLIST_DIR}/Info.cmake.macos.plist"
        )
    endif()
endif()

install(TARGETS mouse-app
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
