//
//  iosGraphicsDriver.hpp
//  sushigraphicsios
//
//  Created by Michael Ong on 21/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include <sushicore/PointerOwnership.h>

#include "../../sushigraphics/graphicsDriver.hpp"

namespace sushi::drivers::ios {

    class iosGraphicsDriver final: public GraphicsDriver {

    private:

        void*   mtlDevice; // id<MTLDevice>

    public:

        iosGraphicsDriver           ();

        ~iosGraphicsDriver          ();


        void*                       createGraphicsDevice    () const override;


        void*                       createBackingSurface    (const glm::vec2 &initialSize,
                                                             const float &initialDpi,
                                                             void *backingWindow) const override;

        void                        resizeGraphicsSurface   (SUSHI_PT_REF graphics::GraphicsSurface *surface,
                                                             const glm::vec2 &newSize,
                                                             const float &newDpi) const override;

        void                        destroyBackingSurface   (void *backingSurface) override;
    };
}
