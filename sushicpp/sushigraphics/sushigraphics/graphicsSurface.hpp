//
//  graphicsSurface.hpp
//  sushigraphicsios
//
//  Created by Michael Ong on 19/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#pragma once

#include <sushicore/PointerOwnership.h>
#include <sushicore/CoreObject.h>
#include <sushicore/Vector.h>

namespace sushi::drivers {

    class GraphicsDriver;
}

namespace sushi::graphics {

    class GraphicsDevice;
}

namespace sushi::graphics {

    class GraphicsSurface final: public core::CoreObject {

        friend class graphics::GraphicsDevice;

    private:

        SUSHI_PO_STRONG
        void*                       backingSurface;

        glm::vec2                   backingSize;


        SUSHI_PO_WEAK
        drivers::GraphicsDriver*    graphicsDriver;


        GraphicsSurface             () = default;

    public:

        virtual ~GraphicsSurface    ();


        const void*                 getBackingSurface   () const { return backingSurface; }

        const glm::vec2&            getBackingSize      () const { return backingSize; }


        void                        resize              (const glm::vec2& newSize, const float& newDpi);
    };
}
