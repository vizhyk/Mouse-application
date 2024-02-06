// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "connectionhandler.h"
#include "devicefinder.h"
#include "devicehandler.h"
#include "heartrate-global.h"
#include "mousesettings.h"
#include "mousedefaultsettings.h"
#include "pageviewbackend.h"

#include <QtCore/qcommandlineoption.h>
#include <QtCore/qcommandlineparser.h>
#include <QtCore/qloggingcategory.h>

#include <QtGui/qguiapplication.h>

#include <QtQml/qqmlapplicationengine.h>

#include <QQmlContext>

using namespace Qt::StringLiterals;

bool simulator = false;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    parser.setApplicationDescription(u"Bluetooth Low Energy Heart Rate Game"_s);
    parser.addHelpOption();
    parser.addVersionOption();
    QCommandLineOption simulatorOption(u"simulator"_s, u"Simulator"_s);
    parser.addOption(simulatorOption);

    QCommandLineOption verboseOption(u"verbose"_s, u"Verbose mode"_s);
    parser.addOption(verboseOption);
    parser.process(app);

    if (parser.isSet(verboseOption))
        QLoggingCategory::setFilterRules(u"qt.bluetooth* = true"_s);
    simulator = parser.isSet(simulatorOption);

    ConnectionHandler connectionHandler;
    DeviceHandler deviceHandler;
    DeviceFinder deviceFinder(&deviceHandler);
    MouseDefaultSettings mouseDefaultSettings;
    MouseSettings mouseSettings;
    PageViewBackEnd pageViewBackEnd;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("pageViewBackEnd", &pageViewBackEnd);
    engine.rootContext()->setContextProperty("mouseSettings", &mouseSettings);
    engine.rootContext()->setContextProperty("deviceHandler", &deviceHandler);
    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());

    engine.addImportPath("qrc:/");
    engine.setInitialProperties({
        {u"connectionHandler"_s, QVariant::fromValue(&connectionHandler)},
        {u"deviceFinder"_s, QVariant::fromValue(&deviceFinder)},
        {u"deviceHandler"_s, QVariant::fromValue(&deviceHandler)},
        {u"mouseSettings"_s, QVariant::fromValue(&mouseSettings)},
        {u"mouseDefaultSettings"_s, QVariant::fromValue(&mouseDefaultSettings)},
        {u"pageViewBackEnd"_s, QVariant::fromValue(&pageViewBackEnd)}

    });

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed, &app,
                     []() { QCoreApplication::exit(1); }, Qt::QueuedConnection);
    engine.loadFromModule("HeartRateGame", "Main");

    return app.exec();
}
