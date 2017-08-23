//
//  iosGraphicsDriver.cpp
//  sushigraphicsios
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "iosGraphicsDriver.hpp"

#include "../../sushigraphics/graphicsSurface.hpp"

#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

#include <Metal/Metal.h>
#include <QuartzCore/QuartzCore.h>

#include <sushicore/FastFail.h>

using namespace sushi::core;
using namespace sushi::graphics;

using namespace sushi::drivers::ios;

iosGraphicsDriver::iosGraphicsDriver                            ():

mtlDevice(nil) {

    const auto device   = MTLCreateSystemDefaultDevice();
    mtlDevice           = (__bridge_retained void*) device;
}

iosGraphicsDriver::~iosGraphicsDriver                           () {

    CFRelease(mtlDevice);
}


void*               iosGraphicsDriver::createGraphicsDevice     () const {

    return mtlDevice;
}


void*               iosGraphicsDriver::createBackingSurface     (const glm::vec2 &initialSize,
                                                                 const float &initialDpi,
                                                                 void *backingWindow) const {

    auto device = (__bridge id<MTLDevice>) mtlDevice;
    if  (device == nil) {
        FastFail::instance->crash(failureTypes::unexpectedPayload("This is not a MTLDevice instance!"));
    }

    auto window = (__bridge UIWindow*) backingWindow;
    if  (window == nil) {
        FastFail::instance->crash(failureTypes::unexpectedPayload("This is not a UIWindow instance!"));
    }

    auto mtlLayer = (CAMetalLayer*) window.rootViewController.view.layer;

    mtlLayer.device         = (__bridge id<MTLDevice>) mtlDevice;
    mtlLayer.drawableSize   = CGSizeMake(initialSize.x, initialSize.y);
    mtlLayer.pixelFormat    = MTLPixelFormatBGRA8Unorm;
    mtlLayer.opaque         = YES;

    return (__bridge_retained void*) mtlLayer;
}

void                iosGraphicsDriver::resizeGraphicsSurface    (GraphicsSurface *surface,
                                                                 const glm::vec2 &newSize,
                                                                 const float &newDpi) const {

    auto caMetalLayer   = (__bridge CAMetalLayer*) surface->getBackingSurface();
    if  (caMetalLayer == nil) {
        FastFail::instance->crash(failureTypes::unexpectedPayload("This is not a CAMetalLayer instance!"));
    }

    auto scale          = (float) [UIScreen mainScreen].scale;

    caMetalLayer.drawableSize = CGSizeMake(newSize.x * scale, newSize.y * scale);
    surface->setBackingSize(newSize * scale);
}

void                iosGraphicsDriver::destroyBackingSurface    (void *backingSurface) {

    CFRelease(backingSurface);
}
