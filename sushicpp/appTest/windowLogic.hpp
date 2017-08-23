//
//  windowLogic.hpp
//  appTestIOS
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include <sushiwindow/windowLogic.hpp>

class windowLogic: public sushi::window::WindowLogic {

    void    initialise      (void *fromSavedState) override;

    void*   destroy         (bool permanentally) override;


    void    stateChanged    (unsigned int newState) override;
};
