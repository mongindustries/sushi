//
//  graphicsDriver.hpp
//  sushigraphicsios
//
//  Created by Michael Ong on 19/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include <sushicore/PointerOwnership.h>
#include <sushicore/Vector.h>

namespace sushi::graphics {

    class GraphicsSurface;
}

namespace sushi::drivers {

    class GraphicsDriver {

    public:

        virtual ~GraphicsDriver () = default;


        SUSHI_PT_REF
        virtual void*           createGraphicsDevice    () const = 0;


        SUSHI_PT_TRANSFER
        virtual void*           createBackingSurface    (const glm::vec2& initialSize,
                                                         const float& initialDpi,
                                                         SUSHI_PT_REF void* backingWindow) const = 0;

        virtual void            resizeGraphicsSurface   (SUSHI_PT_REF graphics::GraphicsSurface* surface,
                                                         const glm::vec2& newSize,
                                                         const float& newDpi) const = 0;


        virtual void            destroyBackingSurface   (SUSHI_PT_TRANSFER void* backingSurface) = 0;
    };
}
