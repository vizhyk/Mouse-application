#ifndef MOUSEDEFAULTSETTINGS_H
#define MOUSEDEFAULTSETTINGS_H

#include <cstdint>
#include <QtCore/qobject.h>
#include <QtQmlIntegration/qqmlintegration.h>



class MouseDefaultSettings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool mode READ mode NOTIFY modeChanged)
    Q_PROPERTY(bool invertation READ invertation NOTIFY invertationChanged)
    Q_PROPERTY(int clear_sensibility READ clear_sensibility NOTIFY clear_sensibilityChanged)
    Q_PROPERTY(int sensetive_sensibility READ sensetive_sensibility NOTIFY sensetive_sensibilityChanged)
    Q_PROPERTY(int clear_mode_scrolling_move READ clear_mode_scrolling_move NOTIFY clear_mode_scrolling_moveChanged)
    Q_PROPERTY(int clear_mode_right_click_move READ clear_mode_right_click_move NOTIFY clear_mode_right_click_moveChanged)
    Q_PROPERTY(int clear_mode_left_click_move READ clear_mode_left_click_move NOTIFY clear_mode_left_click_moveChanged)
    Q_PROPERTY(int16_t clear_up_limit READ clear_up_limit NOTIFY clear_up_limitChanged)
    Q_PROPERTY(int16_t clear_down_limit READ clear_down_limit NOTIFY clear_down_limitChanged)
    Q_PROPERTY(int16_t clear_left_limit READ clear_left_limit NOTIFY clear_left_limitChanged)
    Q_PROPERTY(int16_t clear_right_limit READ clear_right_limit NOTIFY clear_right_limitChanged)
    Q_PROPERTY(int sensetive_mode_right_click_move READ sensetive_mode_right_click_move NOTIFY sensetive_mode_right_click_moveChanged)
    Q_PROPERTY(int sensetive_mode_left_click_move READ sensetive_mode_left_click_move NOTIFY sensetive_mode_left_click_moveChanged)
    Q_PROPERTY(int sensetive_mode_scrolling_move READ sensetive_mode_scrolling_move NOTIFY sensetive_mode_scrolling_moveChanged)
    Q_PROPERTY(bool auto_click READ auto_click NOTIFY auto_clickChanged)
    Q_PROPERTY(int auto_click_time READ auto_click_time NOTIFY auto_click_timeChanged)

    QML_ELEMENT

public:
    explicit MouseDefaultSettings(QObject *parent = nullptr);

    int m_mode_def;
    bool m_invertation;
    int m_clear_sensibility;
    int m_sensetive_sensibility;
    int m_clear_mode_scrolling_move;
    int m_clear_mode_right_click_move;
    int m_clear_mode_left_click_move;
    int16_t m_clear_up_limit;
    int16_t m_clear_down_limit;
    int16_t m_clear_left_limit;
    int16_t m_clear_right_limit;
    int m_sensetive_mode_right_click_move;
    int m_sensetive_mode_left_click_move;
    int m_sensetive_mode_scrolling_move;
    bool m_auto_click;
    int m_auto_click_time;

    int mode();
    bool invertation();
    int clear_sensibility();
    int sensetive_sensibility();
    int clear_mode_scrolling_move();
    int clear_mode_right_click_move();
    int clear_mode_left_click_move();
    int16_t clear_up_limit();
    int16_t clear_down_limit();
    int16_t clear_left_limit();
    int16_t clear_right_limit();
    int sensetive_mode_right_click_move();
    int sensetive_mode_left_click_move();
    int sensetive_mode_scrolling_move();
    bool auto_click();
    int auto_click_time();


    signals:
    void modeChanged();
    void invertationChanged();
    void clear_sensibilityChanged();
    void sensetive_sensibilityChanged();
    void clear_mode_scrolling_moveChanged();
    void clear_mode_right_click_moveChanged();
    void clear_mode_left_click_moveChanged();
    void clear_up_limitChanged();
    void clear_down_limitChanged();
    void clear_left_limitChanged();
    void clear_right_limitChanged();
    void sensetive_mode_right_click_moveChanged();
    void sensetive_mode_left_click_moveChanged();
    void sensetive_mode_scrolling_moveChanged();
    void auto_clickChanged();
    void auto_click_timeChanged();


};

#endif // MOUSEDEFAULTSETTINGS_H
