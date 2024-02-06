// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef DEVICEHANDLER_H
#define DEVICEHANDLER_H

#include "bluetoothbaseclass.h"

#include <QtBluetooth/qlowenergycontroller.h>
#include <QtBluetooth/qlowenergyservice.h>

#include <QtCore/qdatetime.h>
#include <QtCore/qlist.h>
#include <QtCore/qtimer.h>

#include <QString>
#include <QFile>
#include <QDir>

#include <QtQml/qqmlregistration.h>

#include <QProcess>


class DeviceInfo;

class DeviceHandler : public BluetoothBaseClass
{
    Q_OBJECT

    Q_PROPERTY(bool measuring READ measuring NOTIFY measuringChanged)
    Q_PROPERTY(bool alive READ alive NOTIFY aliveChanged)
    Q_PROPERTY(int charge READ charge NOTIFY chargeValueChanged)
    Q_PROPERTY(AddressType addressType READ addressType WRITE setAddressType)
    //Q_PROPERTY(int sensetive_mode_scrolling_move READ sensetive_mode_scrolling_move NOTIFY sensetive_mode_scrolling_moveChanged)
    //Q_PROPERTY(int sensetive_mode_scrolling_move READ sensetive_mode_scrolling_move NOTIFY sensetive_mode_scrolling_moveChanged)

    QML_ELEMENT

public:
    enum class AddressType {
        PublicAddress,
        RandomAddress
    };
    Q_ENUM(AddressType)

    DeviceHandler(QObject *parent = nullptr);

    void setDevice(DeviceInfo *device);
    void setAddressType(AddressType type);
    AddressType addressType() const;

    bool measuring() const;
    bool alive() const;

    static QString Left_eye;
    static QString Right_eye;
    static QString Double_click_timer;

    // Statistics
    int charge() const;

signals:
    void measuringChanged();
    void aliveChanged();
    void statsChanged();
    void chargeValueChanged(int chargeValue);
    void synchronizeCurrentSettings(int sync_mode, bool sync_invertation, int sync_clear_sensibility, int sync_sensible_sensibility,
                                    int sync_clear_scrolling_move, int sync_clear_right_click_move, int sync_clear_left_click_move,
                                    int16_t sync_clear_up_limit, int16_t sync_clear_down_limit, int16_t sync_clear_left_limit, int16_t sync_clear_right_limit,
                                    int sync_sensetive_right_click_move, int sync_sensetive_left_click_move, int sync_sensetive_scrolling_move, bool sync_auto_click);

public slots:
    void startMeasurement();
    void uploadDefaultSettings();
    void startDetector();
    void startWireUpdater();
    void stopMeasurement();
    void disconnectService();
    void changeLeftEyeValue(int indexValue);
    void changeRightEyeValue(int indexValue);
    void changeTimerValue(double timerValue);
    int getCharge();
    int getTestCharge();

private:
    //QLowEnergyController
    void serviceDiscovered(const QBluetoothUuid &);
    void serviceScanDone();


    //QLowEnergyService
    void serviceStateChanged(QLowEnergyService::ServiceState s);
    void serviceWriteStateChanged(QLowEnergyService::ServiceState s);



    void writeServiceStateChanged(QLowEnergyService::ServiceState s);
    void writeDefaultServiceStateChanged(QLowEnergyService::ServiceState s);

    void readNotificationMessage(const QLowEnergyCharacteristic &c,
                              const QByteArray &value);
    void confirmedDescriptorWrite(const QLowEnergyDescriptor &d,
                                  const QByteArray &value);
    void readDefaultMessage();
    void readCurrentMessage();

    void writeDataMessage();
    void writeDefaultSettings();

private:
    void addMeasurement(int value);
    void addChargeChanged(int charge);

    QLowEnergyController *m_control = nullptr;
    QLowEnergyService *m_service = nullptr;
    QLowEnergyService *m_write_service = nullptr;
    QLowEnergyDescriptor m_notificationDesc;
    DeviceInfo *m_currentDevice = nullptr;

    bool m_foundmouseReadService = false;
    bool m_foundmouseWriteService = false;
    bool m_measuring = false;
    int m_currentValue = 0, m_min = 0, m_max = 0, m_sum = 0;
    float m_avg = 0, m_calories = 0;
    int m_chargeValue = 0;

    // Statistics
    QDateTime m_start;
    QDateTime m_stop;

    QList<int> m_measurements;
    QLowEnergyController::RemoteAddressType m_addressType = QLowEnergyController::PublicAddress;

    QTimer m_demoTimer;
};

#endif // DEVICEHANDLER_H
