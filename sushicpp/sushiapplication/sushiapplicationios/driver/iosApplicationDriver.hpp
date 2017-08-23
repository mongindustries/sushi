//
//  iosApplicationDriver.hpp
//  sushiapplicationiosios
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include "../../sushiapplication/applicationDriver.hpp"

namespace sushi::drivers::ios {

    class iosApplicationDriver final: public ApplicationDriver {

    private:

        GraphicsDriver*     graphicsDriver;

        void*               storageDriver;


    public:

        iosApplicationDriver                    ();

        ~iosApplicationDriver                   ();


        GraphicsDriver*     getGraphicsDriver   () const override;

        void*               getStorageDriver    () const override;

        WindowDriver*       getWindowDriver     () const override;


        void                initialise          () override;

        void                destroy             () override;
    };
}
