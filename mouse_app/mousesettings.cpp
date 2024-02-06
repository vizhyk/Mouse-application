#include "mousesettings.h"
#include "qdebug.h"

int MouseSettings::m_mode(0);
bool MouseSettings::m_invertation(false);
bool MouseSettings::m_auto_click(false);
int MouseSettings::m_clear_sensibility(3);
int MouseSettings::m_sensetive_sensibility(4);
int MouseSettings::m_clear_mode_scrolling_move(0);
int MouseSettings::m_clear_mode_right_click_move(2);
int MouseSettings::m_clear_mode_left_click_move(3);
int16_t MouseSettings::m_clear_up_limit(-6500);
int16_t MouseSettings::m_clear_down_limit(6500);
int16_t MouseSettings::m_clear_left_limit(-7000);
int16_t MouseSettings::m_clear_right_limit(7000);
int MouseSettings::m_sensetive_mode_right_click_move(0);
int MouseSettings::m_sensetive_mode_left_click_move(1);
int MouseSettings::m_sensetive_mode_scrolling_move(2);
//int MouseSettings::

int counter = 0;

MouseSettings::MouseSettings(QObject *parent) :
    QObject(parent)
{

}

int MouseSettings::mode()
{
    return m_mode;
}

int MouseSettings::clear_sensibility()
{
    return m_clear_sensibility;
}

int MouseSettings::sensetive_sensibility()
{
    return m_sensetive_sensibility;
}

int MouseSettings::clear_mode_scrolling_move()
{
    return m_clear_mode_scrolling_move;
}

int MouseSettings::clear_mode_right_click_move()
{
    return m_clear_mode_right_click_move;
}

int MouseSettings::clear_mode_left_click_move()
{
    return m_clear_mode_left_click_move;
}

int MouseSettings::sensetive_mode_right_click_move()
{
    return m_sensetive_mode_right_click_move;
}

int MouseSettings::sensetive_mode_left_click_move()
{
    return m_sensetive_mode_left_click_move;
}

int MouseSettings::sensetive_mode_scrolling_move()
{
    return m_sensetive_mode_scrolling_move;
}

void MouseSettings::changeModeStatus()
{
    if(counter > 0) {
    if(m_mode == 0)
    m_mode = 1;
    else
    m_mode = 0;
    }
    qInfo() <<"m_mode" << m_mode;
    counter++;
}

void MouseSettings::changeInvertationStatus()
{
    if(m_invertation)
        m_invertation = false;
    else
        m_invertation = true;
    qInfo() <<"invertation" << m_invertation;
}

void MouseSettings::changeAutoClickStatus()
{
    if(m_auto_click)
        m_auto_click = false;
    else
        m_auto_click = true;
    qInfo() <<"m_auto_click" << m_auto_click;
}

void MouseSettings::changeClearSensibilityStatus(int clearSensibilityValue)
{
    if(clearSensibilityValue != m_clear_sensibility)
    {
        m_clear_sensibility = clearSensibilityValue;
    }
    qInfo() <<"m_clear_sensibility" << m_clear_sensibility;
}

void MouseSettings::changeSensetiveSensibilityStatus(int sensetiveSensibilityValue)
{
    if(sensetiveSensibilityValue != m_sensetive_sensibility)
    {
        m_sensetive_sensibility = sensetiveSensibilityValue;
    }
    qInfo() <<"m_sensetive_sensibility" << m_sensetive_sensibility;
}

void MouseSettings::changeClearScrollingStatus(int scrollingClickValue)
{
    if(scrollingClickValue != m_clear_mode_scrolling_move)
    {
        m_clear_mode_scrolling_move = scrollingClickValue;
    }
    qInfo() <<"m_clear_mode_scrolling_move" << m_clear_mode_scrolling_move;
}

void MouseSettings::changeClearLeftClickStatus(int leftClickValue)
{
    if(leftClickValue != m_clear_mode_left_click_move)
    {
        m_clear_mode_left_click_move = leftClickValue;
    }
    qInfo() <<"m_clear_mode_scrolling_move" << m_clear_mode_left_click_move;
}

void MouseSettings::changeClearRightClickStatus(int rightClickValue)
{
    if(rightClickValue != m_clear_mode_right_click_move)
    {
        m_clear_mode_right_click_move = rightClickValue;
    }
    qInfo() <<"m_clear_mode_scrolling_move" << m_clear_mode_right_click_move;
}

void MouseSettings::changeClearUpLimitStatus(int clearUpValue)
{
    if(clearUpValue != m_clear_up_limit)
    {
        m_clear_up_limit = clearUpValue;
    }
    qInfo() <<"m_clear_up_limit" << m_clear_up_limit;
}

void MouseSettings::changeClearDownLimitStatus(int clearDownValue)
{
    if(clearDownValue != m_clear_down_limit)
    {
        m_clear_down_limit = clearDownValue;
    }
    qInfo() <<"m_clear_down_limit" << m_clear_down_limit;
}

void MouseSettings::changeClearLeftLimitStatus(int clearLeftValue)
{
    if(clearLeftValue != m_clear_left_limit)
    {
        m_clear_left_limit = clearLeftValue;
    }
    qInfo() <<"m_clear_left_limit" << m_clear_left_limit;
}

void MouseSettings::changeClearRightLimitStatus(int clearRightValue)
{
    if(clearRightValue != m_clear_right_limit)
    {
        m_clear_right_limit = clearRightValue;
    }
    qInfo() <<"m_clear_right_limit" << m_clear_right_limit;
}

void MouseSettings::changeSensetiveRightClickStatus(int rightClickValue)
{
    if(rightClickValue != m_sensetive_mode_right_click_move)
    {
        m_sensetive_mode_right_click_move = rightClickValue;
    }
    qInfo() <<"m_sensetive_mode_right_click_move" << m_sensetive_mode_right_click_move;
}

void MouseSettings::changeSensetiveLeftClickStatus(int leftClickValue)
{
    if(leftClickValue != m_sensetive_mode_left_click_move)
    {
        m_sensetive_mode_left_click_move = leftClickValue;
    }
    qInfo() <<"m_sensetive_mode_left_click_move" << m_sensetive_mode_left_click_move;
}

void MouseSettings::changeSensetiveScrollingStatus(int scrollingValue)
{
    if(scrollingValue != m_sensetive_mode_left_click_move)
    {
        m_sensetive_mode_scrolling_move = scrollingValue;
    }
    qInfo() <<"m_sensetive_mode_scrolling_move" << m_sensetive_mode_scrolling_move;
}
