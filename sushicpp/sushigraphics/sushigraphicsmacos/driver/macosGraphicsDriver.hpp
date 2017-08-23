//
//  macosGraphicsDriver.hpp
//  sushigraphicsmacos
//
//  Created by Michael Ong on 23/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include <sushicore/PointerOwnership.h>

#include "../../sushigraphics/graphicsDriver.hpp"

namespace sushi::drivers::macos {

    class macosGraphicsDriver final: public GraphicsDriver {

    private:

        void*   mtlDevice; // id<MTLDevice>

    public:

        macosGraphicsDriver         ();

        ~macosGraphicsDriver        ();


        void*                       createGraphicsDevice    () const override;


        void*                       createBackingSurface    (const glm::vec2 &initialSize,
                                                             const float &initialDpi,
                                                             SUSHI_PT_REF void *backingWindow) const override;

        void                        resizeGraphicsSurface   (SUSHI_PT_REF graphics::GraphicsSurface *surface,
                                                             const glm::vec2 &newSize,
                                                             const float &newDpi) const override;

        void                        destroyBackingSurface   (void *backingSurface) override;

    };
}

