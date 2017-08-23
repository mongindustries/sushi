//
//  iosWindowDriver.hpp
//  sushiwindowios
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include "../../sushiwindow/windowDriver.hpp"

namespace sushi::drivers::ios {

    class iosWindowDriver: public WindowDriver {

    public:

        core::Rectangle getUndefinedRect    () const override;


        void*           initalise           () override;

        void            destroy             () override;


        void            process             (window::WindowDriverMessages message, void *data) override;
    };
}
