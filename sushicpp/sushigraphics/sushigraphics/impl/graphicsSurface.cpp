//
//  graphicsSurface.cpp
//  sushigraphicsios
//
//  Created by Michael Ong on 19/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include "graphicsSurface.hpp"
#include "../graphicsDriver.hpp"

using namespace sushi::graphics;

GraphicsSurface::~GraphicsSurface() {

    graphicsDriver->destroyBackingSurface(backingSurface);
}

void    GraphicsSurface::resize         (const glm::vec2 &newSize, const float &newDpi) {

    graphicsDriver->resizeGraphicsSurface(this, newSize, newDpi);
}

void    GraphicsSurface::setBackingSize (const glm::vec2 &value) {

    backingSize = value;
}
