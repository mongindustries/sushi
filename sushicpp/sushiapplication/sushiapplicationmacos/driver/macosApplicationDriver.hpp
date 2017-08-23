//
//  macosApplicationDriver.hpp
//  sushiapplicationmacos
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//
#pragma once

#include "../../sushiapplication/applicationDriver.hpp"

namespace sushi::drivers::macos {

    class macosApplicationDriver final: public ApplicationDriver {

    private:

        GraphicsDriver*     graphicsDriver;

        void*               storageDriver;


    public:

        macosApplicationDriver                  ();

        ~macosApplicationDriver                 ();


        GraphicsDriver*     getGraphicsDriver   () const override;

        void*               getStorageDriver    () const override;

        WindowDriver*       getWindowDriver     () const override;


        void                initialise          () override;

        void                destroy             () override;
    };
}
