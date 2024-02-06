// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "devicehandler.h"
#include "deviceinfo.h"

#include "mousesettings.h"
#include "mousedefaultsettings.h"

#include <QtCore5Compat/QTextCodec>
#include <QtCore/qendian.h>
#include <QtCore/qrandom.h>

QUuid mouse_READ_SERVICE_UUID = QUuid::fromString("00003000-0000-1000-8000-00805F9B34FB");
QUuid mouse_WRITE_SERVICE_UUID = QUuid::fromString("00003001-0000-1000-8000-00805F9B34FB");

QUuid mouse_NOTIFY_CHARACTERISTIC = QUuid::fromString("00002FFF-0000-1000-8000-00805F9B34FB");
QUuid mouse_DEFAULT_CHARACTERISTIC = QUuid::fromString("00002FFA-0000-1000-8000-00805F9B34FB");
QUuid mouse_CURRENT_CHARACTERISTIC = QUuid::fromString("00002FFB-0000-1000-8000-00805F9B34FB");

QUuid mouse_WRITE_CHARACTERISTIC = QUuid::fromString("00002FFC-0000-1000-8000-00805F9B34FB");

QString DeviceHandler::Left_eye = "0";
QString DeviceHandler::Right_eye = "1";
QString DeviceHandler::Double_click_timer = "3";
int isStarted = 0;

QString eyeDetector = "/HeartRateGame/eye_detector/eye_detector.exe";
QString wireUpdater = "/HeartRateGame/wire_updater/flash_download_tool_3.9.5.exe";

int test_charge = 51;
int synchronize_counter = 0;


    MouseSettings mouseSettings;
    MouseDefaultSettings mouseDefaultSettings;

DeviceHandler::DeviceHandler(QObject *parent) :
    BluetoothBaseClass(parent)
{
    m_chargeValue = 0;
}

void DeviceHandler::setAddressType(AddressType type)
{
    switch (type) {
    case DeviceHandler::AddressType::PublicAddress:
        m_addressType = QLowEnergyController::PublicAddress;
        break;
    case DeviceHandler::AddressType::RandomAddress:
        m_addressType = QLowEnergyController::RandomAddress;
        break;
    }
}

DeviceHandler::AddressType DeviceHandler::addressType() const
{
    if (m_addressType == QLowEnergyController::RandomAddress)
        return DeviceHandler::AddressType::RandomAddress;

    return DeviceHandler::AddressType::PublicAddress;
}

void DeviceHandler::setDevice(DeviceInfo *device)
{
    clearMessages();
    m_currentDevice = device;

    // Disconnect and delete old connection
    if (m_control) {
        m_control->disconnectFromDevice();
        delete m_control;
        m_control = nullptr;
    }

    // Create new controller and connect it if device available
    if (m_currentDevice) {

        // Make connections
        //! [Connect-Signals-1]
        m_control = QLowEnergyController::createCentral(m_currentDevice->getDevice(), this);
        //! [Connect-Signals-1]
        m_control->setRemoteAddressType(m_addressType);
        //! [Connect-Signals-2]
        connect(m_control, &QLowEnergyController::serviceDiscovered,
                this, &DeviceHandler::serviceDiscovered);
        connect(m_control, &QLowEnergyController::discoveryFinished,
                this, &DeviceHandler::serviceScanDone, Qt::QueuedConnection);

        connect(m_control, &QLowEnergyController::errorOccurred, this,
                [this](QLowEnergyController::Error error) {
                    Q_UNUSED(error);
                    setError("Cannot connect to remote device.");
                });
        connect(m_control, &QLowEnergyController::connected, this, [this]() {
            setInfo("Controller connected. Search services...");
            m_control->discoverServices();
        });
        connect(m_control, &QLowEnergyController::disconnected, this, [this]() {
            setError("LowEnergy controller disconnected");
        });

        // Connect
        m_control->connectToDevice();
        //! [Connect-Signals-2]
    }
}

void DeviceHandler::startMeasurement()
{
    setInfo("UPLOAD BUTTON PRESSED");

    if(m_foundmouseWriteService) {
        qInfo() << "service object created";
        m_write_service = m_control->createServiceObject(QBluetoothUuid(mouse_WRITE_SERVICE_UUID), this);
    }

    if(m_write_service){
        if(m_write_service->state() == QLowEnergyService::RemoteService) {

    qDebug() << connect(m_write_service, &QLowEnergyService::stateChanged, this, &DeviceHandler::writeServiceStateChanged);
    m_write_service->discoverDetails();
    }
        else {
        writeDataMessage();
        }
    }
    else {
    qInfo() << "Service not valid";
    }
}

void DeviceHandler::uploadDefaultSettings()
{
     setInfo("Default settings pressed");
    qInfo() << "upload default settings button pressed";

     if(m_foundmouseWriteService) {
        qInfo() << "service object created";
        m_write_service = m_control->createServiceObject(QBluetoothUuid(mouse_WRITE_SERVICE_UUID), this);
    }

    if(m_write_service){
        if(m_write_service->state() == QLowEnergyService::RemoteService) {
        qDebug() << connect(m_write_service, &QLowEnergyService::stateChanged, this, &DeviceHandler::writeDefaultServiceStateChanged);
        m_write_service->discoverDetails();
        }
        else {
        writeDefaultSettings();
        }
    }
    else {
    qInfo() << "Service not valid";
    }
}

void DeviceHandler::startDetector() {
    QProcess processEyeDetector;
    static qint64 pid;
    QString fullWinPath = QDir::currentPath() + eyeDetector;

    switch(isStarted) {
    case 0:
    qInfo()<< "Eye Detector started";
    qInfo()<< fullWinPath;
    processEyeDetector.setProgram(fullWinPath);
    processEyeDetector.setArguments({Left_eye, Right_eye, Double_click_timer});
    processEyeDetector.startDetached(&pid);
    qInfo()<<"PID"<<pid;

    isStarted = 1;
    break;

    case 1:
    system("taskkill /im eye_detector.exe /f");
    qInfo()<<"killed"<<pid;
    isStarted = 0;
    break;

    }
    //myProcess.startDetached(fullWinPath, {Left_eye, Right_eye, Double_click_timer} );
}

void DeviceHandler::startWireUpdater() {
    QProcess processWireUpdater;
    static qint64 pid;
    QString wireUpdaterPathWin = QDir::currentPath() + wireUpdater;

    qInfo()<< "Wire updater started";
    qInfo()<< wireUpdaterPathWin;
    processWireUpdater.startDetached(wireUpdaterPathWin);
}


void DeviceHandler::stopMeasurement()
{
    m_measuring = false;
    emit measuringChanged();
}

int DeviceHandler::getCharge()
{
    //m_chargeValue--;
    return m_chargeValue;
}

int DeviceHandler::getTestCharge()
{
    return m_chargeValue;
}

//! [Filter HeartRate service 1]
void DeviceHandler::serviceDiscovered(const QBluetoothUuid &gatt)
{
    if (gatt == QBluetoothUuid(mouse_READ_SERVICE_UUID)) {
        setInfo("mouse read service discovered. Waiting for service scan to be done...");
    qInfo() << "service 3000 discovered";
        m_foundmouseReadService = true;
    }

    if (gatt == QBluetoothUuid(mouse_WRITE_SERVICE_UUID)) {
        setInfo("mouse write service discovered. Waiting for service scan to be done...");
        qInfo() << "service 3001 discovered";
        m_foundmouseWriteService = true;

    }
}
//! [Filter HeartRate service 1]

void DeviceHandler::serviceScanDone()
{
    //qInfo() << "funcion1";
    setInfo("Service scan done.");

    // Delete old service if available
    if (m_service) {
        delete m_service;
        //qInfo() << m_service->state();
    }

    if (m_write_service) {
        delete m_write_service;
    }

//! [Filter HeartRate service 2]
    // If heartRateService found, create new service
    if (m_foundmouseReadService) {
        m_service = m_control->createServiceObject(QBluetoothUuid(mouse_READ_SERVICE_UUID), this);
    }

    if (m_service) {
        qInfo() << m_service->state();
        connect(m_service, &QLowEnergyService::stateChanged, this, &DeviceHandler::serviceStateChanged);
        qInfo() << m_service->state();
        connect(m_service, &QLowEnergyService::characteristicChanged, this, &DeviceHandler::readNotificationMessage);
        qInfo() << m_service->state();
        connect(m_service, &QLowEnergyService::characteristicChanged, this, &DeviceHandler::readDefaultMessage);
        qInfo() << m_service->state();
        connect(m_service, &QLowEnergyService::characteristicChanged, this, &DeviceHandler::readCurrentMessage);
        qInfo() << m_service->state();
        m_service->discoverDetails();
        qInfo() << m_service->state();
        //qInfo() << "funcion2";
    } else {
        setError("mouse Read Service not found.");
    }
//! [Filter HeartRate service 2]
}

// Service functions
//! [Find HRM characteristic]
void DeviceHandler::serviceStateChanged(QLowEnergyService::ServiceState s)
{
    switch (s) {
    case QLowEnergyService::RemoteServiceDiscovering:
        setInfo(tr("Discovering services..."));
        break;
    case QLowEnergyService::RemoteServiceDiscovered:
    {
        setInfo(tr("Service discovered."));

        const QLowEnergyCharacteristic hrChar =
            m_service->characteristic(QBluetoothUuid(mouse_NOTIFY_CHARACTERISTIC));
        setInfo(tr("Characteristic discovered."));
        if (!hrChar.isValid()) {
            setError("mouse characteristic  not found.");
            break;
        }

        m_notificationDesc = hrChar.descriptor(QBluetoothUuid::DescriptorType::ClientCharacteristicConfiguration);
        if (m_notificationDesc.isValid()) {
            setInfo(tr("Descriptor discovered."));
            m_service->writeDescriptor(m_notificationDesc, QByteArray::fromHex("0100"));
        }


        break;
    }
    default:
        //nothing for now
        break;
    }

    //emit aliveChanged();
}


void DeviceHandler::writeDefaultSettings()
{


    QString default_values = QString("{\"s_0\":%1,\"s_1\":%2,\"s_2\":%3,\"s_3\":%4,\"s_4\":%5,\"s_5\":%6,"
                                     "\"s_6\":%7,\"s_7\":%8,\"s_8\":%9,\"s_9\":%10,\"s_10\":%11,\"s_11\":%12,"
                                     "\"s_12\":%13,\"s_13\":%14,\"s_14\":%15,\"s_15\":%16,\"s_16\":false,\"s_17\":4,"
                                     "\"s_18\":5,\"s_19\":false,\"s_20\":6,\"s_21\":7}").
                             arg(mouseDefaultSettings.m_mode_def).
                             arg(mouseDefaultSettings.m_invertation).
                             arg(mouseDefaultSettings.m_clear_sensibility).
                             arg(mouseDefaultSettings.m_sensetive_sensibility).
                             arg(mouseDefaultSettings.m_clear_mode_scrolling_move).
                             arg(mouseDefaultSettings.m_clear_mode_right_click_move).
                             arg(mouseDefaultSettings.m_clear_mode_left_click_move).
                             arg(mouseDefaultSettings.m_clear_up_limit).
                             arg(mouseDefaultSettings.m_clear_down_limit).
                             arg(mouseDefaultSettings.m_clear_left_limit).
                             arg(mouseDefaultSettings.m_clear_right_limit).
                             arg(mouseDefaultSettings.m_sensetive_mode_right_click_move).
                             arg(mouseDefaultSettings.m_sensetive_mode_left_click_move).
                             arg(mouseDefaultSettings.m_sensetive_mode_scrolling_move).
                             arg(mouseDefaultSettings.m_auto_click).
                             arg(mouseDefaultSettings.m_auto_click_time);

    QByteArray default_settings = default_values.toUtf8();

    const QLowEnergyCharacteristic writeChar =
        m_write_service->characteristic(QBluetoothUuid(mouse_WRITE_CHARACTERISTIC));

        if (writeChar.uuid() != QBluetoothUuid(QBluetoothUuid(mouse_WRITE_CHARACTERISTIC))) {
            setError("mouse write Default characteristic  not found.");
            qInfo() << "mouse write Default characteristic  not found.";
            return;
        }

        qInfo() << "Default settings applied";

        m_write_service->writeCharacteristic(writeChar, default_settings, QLowEnergyService::WriteWithoutResponse);


}

void DeviceHandler::writeServiceStateChanged(QLowEnergyService::ServiceState s)
{

    QString settings_values = QString("{\"s_0\":%1,\"s_1\":%2,\"s_2\":%3,\"s_3\":%4,\"s_4\":%5,\"s_5\":%6,"
                                     "\"s_6\":%7,\"s_7\":%8,\"s_8\":%9,\"s_9\":%10,\"s_10\":%11,\"s_11\":%12,"
                                     "\"s_12\":%13,\"s_13\":%14,\"s_14\":%15,\"s_15\":%16,\"s_16\":false,\"s_17\":4,"
                                     "\"s_18\":5,\"s_19\":false,\"s_20\":6,\"s_21\":7}").
                                  arg(MouseSettings::m_mode).
                             arg(MouseSettings::m_invertation).
                             arg(MouseSettings::m_clear_sensibility).
                             arg(MouseSettings::m_sensetive_sensibility).
                             arg(MouseSettings::m_clear_mode_scrolling_move).
                             arg(MouseSettings::m_clear_mode_right_click_move).
                             arg(MouseSettings::m_clear_mode_left_click_move).
                             arg(MouseSettings::m_clear_up_limit).
                             arg(MouseSettings::m_clear_down_limit).
                             arg(MouseSettings::m_clear_left_limit).
                             arg(MouseSettings::m_clear_right_limit).
                             arg(MouseSettings::m_sensetive_mode_right_click_move).
                             arg(MouseSettings::m_sensetive_mode_left_click_move).
                             arg(MouseSettings::m_sensetive_mode_scrolling_move).
                             arg(MouseSettings::m_auto_click).
                             arg(mouseSettings.m_auto_click_time);

    /*QString settings_values = QString("{\"s_0\":%1,\"s_1\":%2,\"s_2\":3,\"s_3\":%3,\"s_4\":0,\"s_5\":2,"
                                      "\"s_6\":3,\"s_7\":%4,\"s_8\":%5,\"s_9\":%6,\"s_10\":%7,\"s_11\":%8,"
                                      "\"s_12\":%9,\"s_13\":%10,\"s_14\":%11,\"s_15\":3,\"s_16\":false,\"s_17\":4,"
                                      "\"s_18\":5,\"s_19\":false,\"s_20\":6,\"s_21\":7}").
                                   arg(MouseSettings::m_mode).
                                   arg(MouseSettings::m_invertation).
                                   arg(MouseSettings::m_sensetive_sensibility).
                                   arg(MouseSettings::m_clear_up_limit).
                                   arg(MouseSettings::m_clear_down_limit).
                                   arg(MouseSettings::m_clear_left_limit).
                                   arg(MouseSettings::m_clear_right_limit).
                                   arg(MouseSettings::m_sensetive_mode_right_click_move).
                                   arg(MouseSettings::m_sensetive_mode_left_click_move).
                                   arg(MouseSettings::m_sensetive_mode_scrolling_move).
                                   arg(MouseSettings::m_auto_click);*/

    QByteArray mouse_settings = settings_values.toUtf8();

   /* QString settings_values = QString("{\"s_0\":true,\"s_1\":false,\"s_2\":3,\"s_3\":2,\"s_4\":0,\"s_5\":2,"
                      "\"s_6\":3,\"s_7\":-3500,\"s_8\":3000,\"s_9\":-1000,\"s_10\":6000,\"s_11\":0,"
                      "\"s_12\":1,\"s_13\":2,\"s_14\":true,\"s_15\":1,\"s_16\":false,\"s_17\":4,"
                      "\"s_18\":5,\"s_19\":false,\"s_20\":6,\"s_21\":7}");*/

    switch (s) {
    case QLowEnergyService::RemoteServiceDiscovering:
        setInfo(tr("Discovering services..."));
        qInfo() << "Discovering services";
        break;
    case QLowEnergyService::RemoteServiceDiscovered:
    {
        setInfo(tr("Service discovered."));
        qInfo() << "Service discovered.";

        const QLowEnergyCharacteristic writeChar =
            m_write_service->characteristic(QBluetoothUuid(mouse_WRITE_CHARACTERISTIC));

        setInfo(tr("Write Characteristic discovered."));
        qInfo() << "Write Characteristic discovered.";

        if (writeChar.uuid() != QBluetoothUuid(QBluetoothUuid(mouse_WRITE_CHARACTERISTIC))) {
            setError("mouse write characteristic  not found.");
            qInfo() << "mouse write characteristic  not found.";
            break;
        }

        qInfo() << "Message was sent";

        m_write_service->writeCharacteristic(writeChar, mouse_settings, QLowEnergyService::WriteWithResponse);

        break;
    }
    default:
        //nothing for now
        break;
    }
}

void DeviceHandler::writeDefaultServiceStateChanged(QLowEnergyService::ServiceState s)
{
    QString default_values = QString("{\"s_0\":%1,\"s_1\":%2,\"s_2\":%3,\"s_3\":%4,\"s_4\":%5,\"s_5\":%6,"
                                     "\"s_6\":%7,\"s_7\":%8,\"s_8\":%9,\"s_9\":%10,\"s_10\":%11,\"s_11\":%12,"
                                     "\"s_12\":%13,\"s_13\":%14,\"s_14\":%15,\"s_15\":%16,\"s_16\":false,\"s_17\":4,"
                                     "\"s_18\":5,\"s_19\":false,\"s_20\":6,\"s_21\":7}").
                             arg(mouseDefaultSettings.m_mode_def).
                             arg(mouseDefaultSettings.m_invertation).
                             arg(mouseDefaultSettings.m_clear_sensibility).
                             arg(mouseDefaultSettings.m_sensetive_sensibility).
                             arg(mouseDefaultSettings.m_clear_mode_scrolling_move).
                             arg(mouseDefaultSettings.m_clear_mode_right_click_move).
                             arg(mouseDefaultSettings.m_clear_mode_left_click_move).
                             arg(mouseDefaultSettings.m_clear_up_limit).
                             arg(mouseDefaultSettings.m_clear_down_limit).
                             arg(mouseDefaultSettings.m_clear_left_limit).
                             arg(mouseDefaultSettings.m_clear_right_limit).
                             arg(mouseDefaultSettings.m_sensetive_mode_right_click_move).
                             arg(mouseDefaultSettings.m_sensetive_mode_left_click_move).
                             arg(mouseDefaultSettings.m_sensetive_mode_scrolling_move).
                             arg(mouseDefaultSettings.m_auto_click).
                             arg(mouseDefaultSettings.m_auto_click_time);

    QByteArray default_settings = default_values.toUtf8();

    switch (s) {
    case QLowEnergyService::RemoteServiceDiscovering:
        setInfo(tr("Discovering services..."));
        qInfo() << "Discovering services...";
        break;
    case QLowEnergyService::RemoteServiceDiscovered:
    {
        setInfo(tr("Service discovered."));
        qInfo() << "Service discovered.";

        const QLowEnergyCharacteristic writeChar =
            m_write_service->characteristic(QBluetoothUuid(mouse_WRITE_CHARACTERISTIC));

        setInfo(tr("Write Default Characteristic discovered."));
        qInfo() << "Write Default Characteristic discovered.";

        if (writeChar.uuid() != QBluetoothUuid(QBluetoothUuid(mouse_WRITE_CHARACTERISTIC))) {
            setError("mouse write Default characteristic  not found.");
            qInfo() << "mouse write Default characteristic  not found.";
            break;
        }

        qInfo() << "Default settings applied";

        m_write_service->writeCharacteristic(writeChar, default_settings, QLowEnergyService::WriteWithoutResponse);

        break;
    }
    default:
        //nothing for now
        break;
    }

}

//! [Find mouse characteristic]

//! [Reading value]
void DeviceHandler::readNotificationMessage(const QLowEnergyCharacteristic &c, const QByteArray &value)
{
    // ignore any other characteristic change -> shouldn't really happen though
    if (c.uuid() != QBluetoothUuid(QBluetoothUuid(mouse_NOTIFY_CHARACTERISTIC))) {
        qInfo() << "Wrong Notify characteristic";
        return;
    }


    auto data = value;
    QString  dataAsString = static_cast<QString>(data);
    QStringList list = dataAsString.split(',');
    //for(int i=0 ; i < list.length() ; i++)
        //qInfo() << list.at(0);
    auto charge = list.at(0).split(':');
    m_chargeValue = charge.at(1).toInt();
    emit chargeValueChanged(m_chargeValue);
    //qInfo() << m_chargeValue;

    /*qInfo() << "Notification";
    qInfo() << data;
    qInfo() << MouseSettings::m_mode;
    qInfo() << MouseSettings::m_invertation;
    qInfo() << MouseSettings::m_auto_click;
    qInfo() << MouseSettings::m_sensetive_sensibility;
    qInfo() << MouseSettings::m_sensetive_mode_right_click_move;
    qInfo() << MouseSettings::m_sensetive_mode_left_click_move;
    qInfo() << MouseSettings::m_sensetive_mode_scrolling_move;
    qInfo() << MouseSettings::m_clear_up_limit;
    qInfo() << MouseSettings::m_clear_down_limit;
    qInfo() << MouseSettings::m_clear_left_limit;
    qInfo() << MouseSettings::m_clear_right_limit;*/


    //--test_charge;

    //addMeasurement(hrvalue);
}
//! [Reading value]

void DeviceHandler::readDefaultMessage()
{
   const QLowEnergyCharacteristic hrChar =
        m_service->characteristic(QBluetoothUuid(mouse_DEFAULT_CHARACTERISTIC));

    if (hrChar.uuid() != QBluetoothUuid(QBluetoothUuid(mouse_DEFAULT_CHARACTERISTIC))) {
        qInfo() << "Wrong default characteristic";
        return;
    }

    auto data = hrChar.value();


        //qInfo() << "Default values";
        //qInfo() << data;

    //addMeasurement(randomValue);
}

void DeviceHandler::readCurrentMessage()
{
        const QLowEnergyCharacteristic hrChar =
            m_service->characteristic(QBluetoothUuid(mouse_CURRENT_CHARACTERISTIC));


        if (hrChar.uuid() != QBluetoothUuid(QBluetoothUuid(mouse_CURRENT_CHARACTERISTIC))) {
        qInfo() << "Wrong current characteristic";
        return;
        }

        auto data = hrChar.value();
        QString  dataAsString = static_cast<QString>(data);
        QStringList list = dataAsString.split(',');
        //for(int i=0 ; i < list.length() ; i++)
        //qInfo() << list.at(i);

        auto _mode = list.at(0).split(':');
        static int sync_mode = _mode.at(1).toInt();
        auto _invertation = list.at(1).split(':');
        static bool sync_invertation = QVariant(_invertation.at(1)).toBool();
        auto _clear_sensibility = list.at(2).split(':');
        static int sync_clear_sensibility = _clear_sensibility.at(1).toInt();
        auto _sensible_sensibility = list.at(3).split(':');
        static int sync_sensible_sensibility = _sensible_sensibility.at(1).toInt();
        auto _clear_scrolling_move = list.at(4).split(':');
        static int sync_clear_scrolling_move = _clear_scrolling_move.at(1).toInt();
        auto _clear_right_click_move = list.at(5).split(':');
        static int sync_clear_right_click_move = _clear_right_click_move.at(1).toInt();
        auto _clear_left_click_move = list.at(6).split(':');
        static int sync_clear_left_click_move = _clear_left_click_move.at(1).toInt();
        auto _clear_up_limit = list.at(7).split(':');
        static int sync_clear_up_limit = _clear_up_limit.at(1).toInt();
        auto _clear_down_limit = list.at(8).split(':');
        static int sync_clear_down_limit = _clear_down_limit.at(1).toInt();
        auto _clear_left_limit = list.at(9).split(':');
        static int sync_clear_left_limit = _clear_left_limit.at(1).toInt();
        auto _clear_right_limit = list.at(10).split(':');
        static int sync_clear_right_limit = _clear_right_limit.at(1).toInt();
        auto _sensetive_right_click_move = list.at(11).split(':');
        static int sync_sensetive_right_click_move = _sensetive_right_click_move.at(1).toInt();
        auto _sensetive_left_click_move = list.at(12).split(':');
        static int sync_sensetive_left_click_move = _sensetive_left_click_move.at(1).toInt();
        auto _sensetive_scrolling_move = list.at(13).split(':');
        static int sync_sensetive_scrolling_move = _sensetive_scrolling_move.at(1).toInt();
        auto _auto_click = list.at(14).split(':');
        static bool sync_auto_click = QVariant(_auto_click.at(1)).toBool();



        /*qInfo() << "sync_mode" << sync_mode;
        qInfo() << "sync_invertation" << sync_invertation;
        qInfo() << "sync_clear_sensibility" << sync_clear_sensibility;
        qInfo() << "sync_sensible_sensibility" << sync_sensible_sensibility;
        qInfo() << "sync_clear_scrolling_move" << sync_clear_scrolling_move;
        qInfo() << "sync_clear_right_click_move" << sync_clear_right_click_move;
        qInfo() << "sync_clear_left_click_move" << sync_clear_left_click_move;
        qInfo() << "sync_clear_up_limit" << sync_clear_up_limit;
        qInfo() << "sync_clear_down_limit" << sync_clear_down_limit;
        qInfo() << "sync_clear_left_limit" << sync_clear_left_limit;
        qInfo() << "sync_clear_right_limit" << sync_clear_right_limit;
        qInfo() << "sync_sensetive_right_click_move" << sync_sensetive_right_click_move;
        qInfo() << "sync_sensetive_left_click_move" << sync_sensetive_left_click_move;
        qInfo() << "sync_sensetive_scrolling_move" << sync_sensetive_scrolling_move;
        qInfo() << "sync_auto_click" << sync_auto_click;*/

        if(synchronize_counter <= 0) {
        emit synchronizeCurrentSettings(sync_mode, sync_invertation, sync_clear_sensibility, sync_sensible_sensibility,
                                        sync_clear_scrolling_move, sync_clear_right_click_move, sync_clear_left_click_move,
                                        sync_clear_up_limit, sync_clear_down_limit, sync_clear_left_limit, sync_clear_right_limit,
                                        sync_sensetive_right_click_move, sync_sensetive_left_click_move, sync_sensetive_scrolling_move, sync_auto_click);
            synchronize_counter++;
            qInfo() << "Signal to synchronize values was emitted";
        }


        //qInfo() << "Current values";
        //qInfo() << data;

        //addMeasurement(randomValue);
}

void DeviceHandler::writeDataMessage()
{
        QString settings_values = QString("{\"s_0\":%1,\"s_1\":%2,\"s_2\":3,\"s_3\":%3,\"s_4\":0,\"s_5\":2,"
                                          "\"s_6\":3,\"s_7\":%4,\"s_8\":%5,\"s_9\":%6,\"s_10\":%7,\"s_11\":%8,"
                                          "\"s_12\":%9,\"s_13\":%10,\"s_14\":%11,\"s_15\":3,\"s_16\":false,\"s_17\":4,"
                                          "\"s_18\":5,\"s_19\":false,\"s_20\":6,\"s_21\":7}").
                                  arg(MouseSettings::m_mode).
                                  arg(MouseSettings::m_invertation).
                                  arg(MouseSettings::m_sensetive_sensibility).
                                  arg(MouseSettings::m_clear_up_limit).
                                  arg(MouseSettings::m_clear_down_limit).
                                  arg(MouseSettings::m_clear_left_limit).
                                  arg(MouseSettings::m_clear_right_limit).
                                  arg(MouseSettings::m_sensetive_mode_right_click_move).
                                  arg(MouseSettings::m_sensetive_mode_left_click_move).
                                  arg(MouseSettings::m_sensetive_mode_scrolling_move).
                                  arg(MouseSettings::m_auto_click);

        QByteArray mouse_settings = settings_values.toUtf8();


        qInfo() << "Write Data Message";
        const QLowEnergyCharacteristic writeChar =
            m_write_service->characteristic(QBluetoothUuid(mouse_WRITE_CHARACTERISTIC));

        if (writeChar.uuid() != QBluetoothUuid(QBluetoothUuid(mouse_WRITE_CHARACTERISTIC))) {
        qInfo() << "Wrong write characteristic";
        return;
        }

        qInfo() << "Message was written";
        m_write_service->writeCharacteristic(writeChar, mouse_settings, QLowEnergyService::WriteWithoutResponse);

}

void DeviceHandler::confirmedDescriptorWrite(const QLowEnergyDescriptor &d, const QByteArray &value)
{
    if (d.isValid() && d == m_notificationDesc && value == QByteArray::fromHex("0000")) {
        //disabled notifications -> assume disconnect intent
        qInfo()<<"DescriptorWrite";
        m_control->disconnectFromDevice();
        delete m_service;
        m_service = nullptr;
    }
}

void DeviceHandler::disconnectService()
{
    m_foundmouseReadService = false;

    //disable notifications
    if (m_notificationDesc.isValid() && m_service
            && m_notificationDesc.value() == QByteArray::fromHex("0100")) {
        m_service->writeDescriptor(m_notificationDesc, QByteArray::fromHex("0000"));
    } else {
        if (m_control)
            m_control->disconnectFromDevice();

        delete m_service;
        m_service = nullptr;
    }
}

bool DeviceHandler::measuring() const
{
    return m_measuring;
}

bool DeviceHandler::alive() const
{

    if (m_service)
        return m_service->state() == QLowEnergyService::RemoteServiceDiscovered;

    return false;
}

int DeviceHandler::charge() const
{

    return m_chargeValue;
    //return test_charge--;
}

void DeviceHandler::addChargeChanged(int charge)
{

}

void DeviceHandler::changeLeftEyeValue(int indexValue)
{
    Left_eye =  QString::number(indexValue);
    qInfo() <<"Left_eye" << Left_eye;
}

void DeviceHandler::changeRightEyeValue(int indexValue)
{
    Right_eye =  QString::number(indexValue);
    qInfo() <<"Right_eye" << Right_eye;
}

void DeviceHandler::changeTimerValue(double timerValue)
{

    Double_click_timer = QString::number(timerValue);
    qInfo() <<"Double_click_timer" << Double_click_timer;
}



