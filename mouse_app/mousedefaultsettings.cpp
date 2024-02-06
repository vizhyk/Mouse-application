#include "mousedefaultsettings.h"

MouseDefaultSettings::MouseDefaultSettings(QObject *parent) :
    QObject(parent),
    m_mode_def(0),
    m_invertation(false),
    m_clear_sensibility(3),
    m_sensetive_sensibility(4),
    m_clear_mode_scrolling_move(0),
    m_clear_mode_right_click_move(2),
    m_clear_mode_left_click_move(3),
    m_clear_up_limit(-6500),
    m_clear_down_limit(6500),
    m_clear_left_limit(-7000),
    m_clear_right_limit(7000),
    m_sensetive_mode_right_click_move(0),
    m_sensetive_mode_left_click_move(1),
    m_sensetive_mode_scrolling_move(2),
    m_auto_click(false),
    m_auto_click_time(4)
{

}

int MouseDefaultSettings::mode()
{
    return m_mode_def;
}

bool MouseDefaultSettings::invertation()
{
    return m_invertation;
}

int MouseDefaultSettings::clear_sensibility()
{
    return m_clear_sensibility;
}

int MouseDefaultSettings::sensetive_sensibility()
{
    return m_sensetive_sensibility;
}

int MouseDefaultSettings::clear_mode_scrolling_move()
{
    return m_clear_mode_scrolling_move;
}

int MouseDefaultSettings::clear_mode_right_click_move()
{
    return m_clear_mode_right_click_move;
}

int MouseDefaultSettings::clear_mode_left_click_move()
{
    return m_clear_mode_left_click_move;
}

int16_t MouseDefaultSettings::clear_up_limit()
{
    return m_clear_up_limit;
}

int16_t MouseDefaultSettings::clear_down_limit()
{
    return m_clear_down_limit;
}

int16_t MouseDefaultSettings::clear_left_limit()
{
    return m_clear_left_limit;
}

int16_t MouseDefaultSettings::clear_right_limit()
{
    return m_clear_right_limit;
}

int MouseDefaultSettings::sensetive_mode_right_click_move()
{
    return m_sensetive_mode_right_click_move;
}

int MouseDefaultSettings::sensetive_mode_left_click_move()
{
    return m_sensetive_mode_left_click_move;
}

int MouseDefaultSettings::sensetive_mode_scrolling_move()
{
    return m_sensetive_mode_scrolling_move;
}

bool MouseDefaultSettings::auto_click()
{
    return m_auto_click;
}

int MouseDefaultSettings::auto_click_time()
{
    return m_auto_click_time;
}
