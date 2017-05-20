//
// Created by Michael Ong on 20/5/17.
// Copyright (c) 2017 Michael Ong. All rights reserved.
//

#pragma once

#import "windowLogic.hpp"

class AppLogic final: public sushi::wnd::windowLogic {

public:

    void initialize         () override;

    void destroy            () override;


    bool step               () override;


    void willBecomeInactive () override;

    void didBecomeActive    () override;


    void contentRectChanged (const sushi::core::wndw_rect_sint& newrect) override;
};
