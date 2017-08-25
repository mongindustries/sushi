//
//  macosWindowDriverView.cpp
//  sushiwindowmacos
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "macosWindowDriverView.h"

#include "../../sushiwindow/window.hpp"
#include "../../sushiwindow/windowEncapsulationIDs.hpp"

using namespace sushi::core;
using namespace sushi::window;

@interface      macosWindowDriverView() < NSWindowDelegate >

@end

@implementation macosWindowDriverView

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {

    [super viewWillMoveToWindow:newWindow];

    if (self.window != nil) {

        self.window.delegate = nil;
    }

    if (newWindow != nil) {

        newWindow.delegate = self;
    }
}

- (void)windowWillMove:(NSNotification *)notification {

    const auto window   = (NSWindow*) notification.object;

    auto    windowFrame = NSRectToCGRect(window.frame);

    auto    windowRef   = (Window*) _windowRef;

    auto    newSize     = new Rectangle {   glm::vec2 { CGRectGetMinX(windowFrame), CGRectGetMinY(windowFrame) },
                                            glm::vec2 { CGRectGetWidth(windowFrame), CGRectGetHeight(windowFrame)} };
    auto    data        = Window::encapsulate(WindowEncapsulationIDs::valueRectangle, newSize);

    windowRef->send(WindowDriverMessages::sizeChanged, data);

    delete  newSize;
    delete  data;
}

- (void)windowWillMiniaturize:(NSNotification *)notification {


}

- (void)windowDidDeminiaturize:(NSNotification *)notification {


}

- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize {

    auto    window  = (Window*) _windowRef;

    auto    newSize = new Rectangle { window->getLocation().location, glm::vec2 { frameSize.width, frameSize.height } };
    auto    data    = Window::encapsulate(WindowEncapsulationIDs::valueRectangle, newSize);

    window->send(WindowDriverMessages::sizeChanged, data);

    delete  newSize;
    delete  data;
    
    return frameSize;
}

@end
