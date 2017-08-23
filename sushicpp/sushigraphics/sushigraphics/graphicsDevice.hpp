//
//  graphicsDevice.hpp
//  sushigraphicsios
//
//  Created by Michael Ong on 19/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include <sushicore/CoreObject.h>
#include <sushicore/Vector.h>

#include <sushicore/PointerOwnership.h>

#include "graphicsDriver.hpp"

namespace sushi::graphics {

    class GraphicsDevice final: public core::CoreObject {

    private:

        SUSHI_PO_WEAK
        drivers::GraphicsDriver*    driver;

        SUSHI_PO_STRONG
        void*                       backingDevice;

    public:

        GraphicsDevice              (SUSHI_PT_REF drivers::GraphicsDriver* driver);

        ~GraphicsDevice             ();


        const void*                 getBackingDevice    () const { return backingDevice; }


        GraphicsSurface*            createSurface       (const glm::vec2& initialSize, const float& initialDpi, SUSHI_PT_REF void* backingWindow) const;
    };
}
