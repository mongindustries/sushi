//
//  main.m
//  appTestMacOS
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#include <sushiapplication/application.hpp>
#include <sushiwindow/window.hpp>

#include <sushiapplicationmacos/driver/macosApplicationDriver.hpp>

#include "../../appTest/windowLogic.hpp"

using namespace sushi::application;
using namespace sushi::window;

using namespace sushi::drivers::macos;

int main(int argc, char * argv[]) {

    (void) argc;
    (void) argv;

    @autoreleasepool {

        Application::initialise (new macosApplicationDriver(), [](Application const* instance) {

            instance->spawnWindow(new windowLogic(),
                                  u"Sample Window!",
                                  Window::undefinedRectangle);
        });

        Application::destroy    ();
    }
}

