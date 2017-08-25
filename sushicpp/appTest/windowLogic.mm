//
//  windowLogic.cpp
//  appTestIOS
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "windowLogic.hpp"

#import <QuartzCore/QuartzCore.h>
#import <Metal/Metal.h>

#include <sushiwindow/window.hpp>
#include <sushiapplication/application.hpp>

#include <sushigraphics/graphicsDevice.hpp>
#include <sushigraphics/graphicsSurface.hpp>

using namespace sushi::core;

using namespace sushi::window;
using namespace sushi::application;

using namespace sushi::graphics;

void    windowLogic::initialise     (void *fromSavedState) {

    auto surface        = (__bridge CAMetalLayer*) getWindow()->getGraphicsSurface()->getBackingSurface();
    auto drawable       = [surface nextDrawable];

    auto device         = (__bridge id<MTLDevice>) Application::instance->getGraphicsDevice()->getBackingDevice();
    auto commandQueue   = [device newCommandQueue];

    auto commandBuffer  = [commandQueue commandBuffer];

    auto renderPass     = [MTLRenderPassDescriptor renderPassDescriptor];

    renderPass.colorAttachments[0].texture      = drawable.texture;
    renderPass.colorAttachments[0].loadAction   = MTLLoadActionClear;
    renderPass.colorAttachments[0].storeAction  = MTLStoreActionStore;

    renderPass.colorAttachments[0].clearColor   = MTLClearColorMake(0.95, 0.95, 0.95, 1);

    [[commandBuffer renderCommandEncoderWithDescriptor:renderPass] endEncoding];

    [commandBuffer addCompletedHandler:^(id<MTLCommandBuffer> _Nonnull) {

        [drawable present];
    }];
    [commandBuffer commit];
}

void* 	windowLogic::destroy        (bool permanentally) {

    return nullptr;
}


void    windowLogic::stateChanged   (unsigned int newState) {


}
