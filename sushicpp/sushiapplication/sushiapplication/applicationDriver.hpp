#pragma once

#include <sushiwindow/windowDriver.hpp>
#include <sushigraphics/graphicsDriver.hpp>

#include <sushicore/PointerOwnership.h>

namespace sushi::drivers {

    class ApplicationDriver {

    public:

        virtual ~ApplicationDriver                  () = default;


        SUSHI_PT_REF
        virtual GraphicsDriver* getGraphicsDriver   () const = 0;

        SUSHI_PT_REF
        virtual void*           getStorageDriver    () const = 0;


        SUSHI_PT_TRANSFER
        virtual WindowDriver*   getWindowDriver     () const = 0;

        virtual void            initialise          () = 0;

        virtual void            destroy             () = 0;
    };
}
