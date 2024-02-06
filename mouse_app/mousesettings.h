#ifndef MOUSESETTINGS_H
#define MOUSESETTINGS_H

#include <cstdint>
#include <QtCore/qobject.h>
#include <QtQmlIntegration/qqmlintegration.h>

class MouseSettings : public QObject
{
Q_OBJECT

    Q_PROPERTY(int clear_sensibility READ clear_sensibility NOTIFY clear_sensibilityChanged)
    Q_PROPERTY(int sensetive_sensibility READ sensetive_sensibility NOTIFY sensetive_sensibilityChanged)
    Q_PROPERTY(int clear_mode_scrolling_move READ clear_mode_scrolling_move NOTIFY clear_mode_scrolling_moveChanged)
    Q_PROPERTY(int clear_mode_right_click_move READ clear_mode_right_click_move NOTIFY clear_mode_right_click_moveChanged)
    Q_PROPERTY(int clear_mode_left_click_move READ clear_mode_left_click_move NOTIFY clear_mode_left_click_moveChanged)
    //Q_PROPERTY(int clear_up_limit READ clear_up_limit NOTIFY clear_up_limitChanged)
    //Q_PROPERTY(int clear_down_limit READ clear_down_limit NOTIFY clear_down_limitChanged)
    //Q_PROPERTY(int clear_left_limit READ clear_left_limit NOTIFY clear_left_limitChanged)
    //Q_PROPERTY(int clear_right_limit READ clear_right_limit NOTIFY clear_right_limitChanged)
    Q_PROPERTY(int sensetive_mode_right_click_move READ sensetive_mode_right_click_move NOTIFY sensetive_mode_right_click_moveChanged)
    Q_PROPERTY(int sensetive_mode_left_click_move READ sensetive_mode_left_click_move NOTIFY sensetive_mode_left_click_moveChanged)
    Q_PROPERTY(int sensetive_mode_scrolling_move READ sensetive_mode_scrolling_move NOTIFY sensetive_mode_scrolling_moveChanged)
    //Q_PROPERTY(int auto_click READ auto_click NOTIFY auto_clickChanged)
    //Q_PROPERTY(int auto_click_time READ auto_click_time NOTIFY auto_click_timeChanged)
QML_ELEMENT

public:
    explicit MouseSettings(QObject *parent = nullptr);
    static int m_mode;
    static bool m_invertation;
    static int m_clear_sensibility;
    static int m_sensetive_sensibility;
    static int m_clear_mode_scrolling_move;
    static int m_clear_mode_left_click_move;
    static int m_clear_mode_right_click_move;
    static int16_t m_clear_up_limit;
    static int16_t m_clear_down_limit;
    static int16_t m_clear_left_limit;
    static int16_t m_clear_right_limit;
    static int m_sensetive_mode_right_click_move;
    static int m_sensetive_mode_left_click_move;
    static int m_sensetive_mode_scrolling_move;
    static bool m_auto_click;
    int m_auto_click_time;

    int mode();
    int clear_sensibility();
    int sensetive_sensibility();
    int clear_mode_scrolling_move();
    int clear_mode_right_click_move();
    int clear_mode_left_click_move();
    int sensetive_mode_right_click_move();
    int sensetive_mode_left_click_move();
    int sensetive_mode_scrolling_move();

signals:
    void clear_sensibilityChanged();
    void sensetive_sensibilityChanged();
    void clear_mode_scrolling_moveChanged();
    void clear_mode_right_click_moveChanged();
    void clear_mode_left_click_moveChanged();
    void sensetive_mode_right_click_moveChanged();
    void sensetive_mode_left_click_moveChanged();
    void sensetive_mode_scrolling_moveChanged();

public slots:
    void changeModeStatus();
    void changeInvertationStatus();
    void changeAutoClickStatus();
    void changeClearSensibilityStatus(int clearSensibilityValue);
    void changeSensetiveSensibilityStatus(int sensetiveSensibilityValue);
    void changeClearScrollingStatus(int scrollingClickValue);
    void changeClearLeftClickStatus(int leftClickValue);
    void changeClearRightClickStatus(int rightClickValue);
    void changeClearUpLimitStatus(int clearUpValue);
    void changeClearDownLimitStatus(int clearDownValue);
    void changeClearLeftLimitStatus(int clearLeftValue);
    void changeClearRightLimitStatus(int clearRightValue);
    void changeSensetiveRightClickStatus(int rightClickValue);
    void changeSensetiveLeftClickStatus(int leftClickValue);
    void changeSensetiveScrollingStatus(int scrollingClickValue);

};

#endif // MOUSESETTINGS_H
