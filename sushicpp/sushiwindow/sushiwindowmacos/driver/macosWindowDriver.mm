//
//  macosWindowDriver.cpp
//  sushiwindowmacos
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "macosWindowDriver.hpp"
#include "macosWindowDriverView.h"

#import <AppKit/AppKit.h>

#include "../../sushiwindow/window.hpp"

#include <sushicore/FastFail.h>
#include <sushigraphics/graphicsSurface.hpp>

using namespace std;

using namespace sushi::core;
using namespace sushi::window;

using namespace sushi::drivers::macos;

Rectangle   macosWindowDriver::getUndefinedRect () const {

    auto screenBounds = [NSScreen mainScreen].frame;

    return Rectangle {

        glm::vec2 { (CGRectGetWidth(screenBounds) - 800) * 0.5f, (CGRectGetHeight(screenBounds) - 480) * 0.5f },
        glm::vec2 { 800, 480 }
    };
}

void*       macosWindowDriver::initalise        () {

    const auto delegateRect = getDelegate()->getLocation();
    const auto windowRect   = CGRectMake(delegateRect.location.x, delegateRect.location.y,
                                         delegateRect.size.x,     delegateRect.size.y);

    auto windowView = [[macosWindowDriverView alloc] initWithFrame:windowRect];

    windowView.windowRef = getDelegate();

    auto window = [[NSWindow alloc] initWithContentRect:windowRect
                                              styleMask:(NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskMiniaturizable |
                                                         NSWindowStyleMaskTitled | NSWindowStyleMaskFullSizeContentView)
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];

    window.titleVisibility = NSWindowTitleHidden;
    window.titlebarAppearsTransparent = YES;

    window.title = [NSString stringWithCString:(const char*)getDelegate()->getTitle().data()
                                      encoding:NSUTF16StringEncoding];

    window.contentView = windowView;


    [window center];
    [window makeKeyAndOrderFront:NSApp];

    return (__bridge_retained void*) window;
}

void        macosWindowDriver::destroy          () {

    CFRelease(getDelegate()->getBackingWindow());
}

void        macosWindowDriver::process          (WindowDriverMessages message, WindowEncapsulatedMessage *data) {

    const auto sushiWindow  = getDelegate();
    const auto window       = (__bridge NSWindow*) sushiWindow->getBackingWindow();

    switch (message) {

        case WindowDriverMessages::sizeChanged: {

            auto location = sushiWindow->getLocation();

            sushiWindow->getGraphicsSurface()->resize(sushiWindow->getLocation().size, -1);

            [window setFrame:NSRectFromCGRect(CGRectMake(location.location.x, location.location.y, location.size.x, location.size.y))
                     display:YES];

        }   break;

        case WindowDriverMessages::titleChanged: {

            [window setTitle:[NSString stringWithCString:(const char*) sushiWindow->getTitle().data()
                                                encoding:NSUTF16StringEncoding]];
        } break;

        case WindowDriverMessages::stateChanged:

            // message is ignored. might implement this in the future but meh.

            break;
    }
}
