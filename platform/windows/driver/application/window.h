// window.h
// 
// Created: 12:11
// Author: Michael Ong

#pragma once

#include <window/src/window.hpp>

class windowDriverWindows final: public sushi::wnd::windowDriver {

public:

    ~windowDriverWindows    () = default;

    void    make            (const std::shared_ptr<sushi::wnd::window>& window) override;

    void    kill            (const std::shared_ptr<sushi::wnd::window>& window) override;


    void    state           (const std::shared_ptr<sushi::wnd::window>& window, sushi::wnd::windowState state) override;

    void    message         (const std::shared_ptr<sushi::wnd::window>& window, int message, void* data) override;
};
