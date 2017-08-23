//
//  macosWindowDriver.hpp
//  sushiwindowmacos
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include "../../sushiwindow/windowDriver.hpp"

namespace sushi::drivers::macos {

    class macosWindowDriver: public WindowDriver {

    public:

        core::Rectangle getUndefinedRect    () const override;


        void*           initalise           () override;

        void            destroy             () override;


        void            process             (window::WindowDriverMessages message,
                                             window::WindowEncapsulatedMessage *data) override;
    };
}

