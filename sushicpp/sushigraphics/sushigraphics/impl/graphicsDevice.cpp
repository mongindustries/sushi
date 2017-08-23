//
//  graphicsDevice.cpp
//  sushigraphicsios
//
//  Created by Michael Ong on 19/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "../graphicsDevice.hpp"
#include "../graphicsSurface.hpp"

#include <sushicore/FastFail.h>

using namespace sushi::core;
using namespace sushi::graphics;

using namespace sushi::drivers;

GraphicsDevice::GraphicsDevice                      (GraphicsDriver* driver):

CoreObject      (),

driver          (driver),
backingDevice   (driver->createGraphicsDevice()) {

}

GraphicsDevice::~GraphicsDevice                     () {

    backingDevice   = NULL;
    driver          = nullptr;
}

GraphicsSurface*    GraphicsDevice::createSurface   (const glm::vec2 &initialSize, const float &initialDpi, void *backingWindow) const {

    if (driver == nullptr) {

        FastFail::instance->crash(failureTypes::driverNotInstalled("Graphics Device driver not installed!"));
    }

    auto    surface                 = new GraphicsSurface();

            surface->graphicsDriver = driver;

            surface->backingSurface = driver->createBackingSurface(initialSize, initialDpi, backingWindow);
            surface->backingSize    = initialSize;

    return  surface;
}
