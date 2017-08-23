//
//  main.m
//  appTestIOS
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <sushiapplication/application.hpp>
#include <sushiwindow/window.hpp>

#include <sushiapplicationios/driver/iosApplicationDriver.hpp>

#include "../../appTest/windowLogic.hpp"

using namespace sushi::application;
using namespace sushi::window;

using namespace sushi::drivers::ios;

int main(int argc, char * argv[]) {

    (void) argc;
    (void) argv;

    @autoreleasepool {

        Application::initialise (new iosApplicationDriver(), [](Application const* instance) {

            instance->spawnWindow(new windowLogic(),
                                  u"Sample Window!",
                                  Window::undefinedRectangle);
        });

        Application::destroy    ();
    }
}
