//
//  macosGraphicsDriver.cpp
//  sushigraphicsmacos
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "macosGraphicsDriver.hpp"

#include "../../sushigraphics/graphicsSurface.hpp"

#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>

#include <Metal/Metal.h>
#include <QuartzCore/QuartzCore.h>

#include <sushicore/FastFail.h>

using namespace sushi::core;
using namespace sushi::graphics;

using namespace sushi::drivers::macos;

macosGraphicsDriver::macosGraphicsDriver                        ():

mtlDevice(nil) {

    for (id<MTLDevice> device in MTLCopyAllDevices()) {

        if (device.isLowPower == YES) {

            mtlDevice = (__bridge_retained void*) device;

            break;
        }
    }
}

macosGraphicsDriver::~macosGraphicsDriver                       () {

    CFRelease(mtlDevice);
}


void*               macosGraphicsDriver::createGraphicsDevice   () const {

    return mtlDevice;
}

void*               macosGraphicsDriver::createBackingSurface   (const glm::vec2 &initialSize,
                                                                 const float &initialDpi,
                                                                 void *backingWindow) const {

    auto device = (__bridge id<MTLDevice>) mtlDevice;
    if  (device == nil) {
        FastFail::instance->crash(failureTypes::unexpectedPayload("This is not a MTLDevice instance!"));
    }

    auto window = (__bridge NSWindow*) backingWindow;
    if  (window == nil) {
        FastFail::instance->crash(failureTypes::unexpectedPayload("This is not a UIWindow instance!"));
    }

    const auto mtlLayer = [[CAMetalLayer alloc] init];

    mtlLayer.device = device;
    mtlLayer.drawableSize = CGSizeMake(initialSize.x, initialSize.y);
    mtlLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    mtlLayer.opaque = YES;

    window.contentView.wantsLayer = YES;
    window.contentView.layer = mtlLayer;

    return (__bridge_retained void*) mtlLayer;
}

void                macosGraphicsDriver::resizeGraphicsSurface  (GraphicsSurface *surface,
                                                                 const glm::vec2 &newSize,
                                                                 const float &newDpi) const {

    auto caMetalLayer = (__bridge CAMetalLayer*) surface->getBackingSurface();
    if  (caMetalLayer == nil) {
        FastFail::instance->crash(failureTypes::unexpectedPayload("This is not a CAMetalLayer instance!"));
    }

    auto scale = (float) [NSScreen mainScreen].backingScaleFactor;

    caMetalLayer.drawableSize = CGSizeMake(newSize.x * scale, newSize.y * scale);
}

void                macosGraphicsDriver::destroyBackingSurface  (void *backingSurface) {

    CFRelease(backingSurface);
}
