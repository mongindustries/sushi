//
//  iosWindowDriver.cpp
//  sushiwindowios
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "iosWindowDriver.hpp"
#include "iosWindowDriverVC.h"

#import <UIKit/UIKit.h>

#include "../../sushiwindow/window.hpp"

#include <sushicore/FastFail.h>
#include <sushigraphics/graphicsSurface.hpp>

using namespace std;

using namespace sushi::core;
using namespace sushi::window;

using namespace sushi::drivers::ios;

Rectangle   iosWindowDriver::getUndefinedRect   () const {

    auto screenBounds = [UIScreen mainScreen].bounds;

    return Rectangle { glm::vec2 { 0, 0 }, glm::vec2 { CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds) } };
}

void*       iosWindowDriver::initalise          () {

    auto    rootVC                      = [[iosWindowDriverVC alloc] initWithNibName:nil bundle:nil];
            rootVC.refToWindow          = (void*) this->getDelegate();

    auto    window                      = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

            window.rootViewController   = rootVC;

    [window makeKeyAndVisible];

    return  (__bridge void*) window;
}

void        iosWindowDriver::destroy            () {

    CFRelease(getDelegate()->getBackingWindow());
}

void        iosWindowDriver::process            (WindowDriverMessages message, void *data) {

    const auto sushiWindow  = getDelegate();
    const auto window       = (__bridge UIWindow*) sushiWindow->getBackingWindow();

    switch (message) {

    case WindowDriverMessages::sizeChanged: {

        sushiWindow->getGraphicsSurface()->resize(sushiWindow->getLocation().size, -1);

    }   break;

    case WindowDriverMessages::titleChanged: {

        auto newTitle   = u16string(*reinterpret_cast<u16string*>(data));
        auto rootVC     = window.rootViewController;

        [rootVC setTitle:[NSString stringWithCString:(const char*) newTitle.data()
                                            encoding:NSUTF16StringEncoding]];
    } break;

    case WindowDriverMessages::stateChanged:

        // message is ignored. might implement this in the future but meh.

        break;
    }
}
