#pragma once

#include <sushicore/Rectangle.h>
#include <sushicore/PointerOwnership.h>

#include "windowDriverMessages.h"

namespace sushi::window {

    class Window;
}

namespace sushi::drivers {
    
    class WindowDriverDelegate {

    public:

        virtual ~WindowDriverDelegate               () = default;


        virtual void            send                (window::WindowDriverMessages message, SUSHI_PT_TRANSFER void* data) = 0;
    };

    class WindowDriver {
        
        friend class window::Window;

    private:

        SUSHI_PO_WEAK
        window::Window*         delegate            = nullptr;

    public:

        virtual ~WindowDriver   ()                  = default;


        SUSHI_PO_WEAK
        const window::Window*   getDelegate         () const { return delegate; }


        virtual core::Rectangle getUndefinedRect    () const = 0;


        virtual void*           initalise           () = 0;

        virtual void            destroy             () = 0;


        virtual void            process             (window::WindowDriverMessages message, SUSHI_PT_TRANSFER void* data) = 0;
    };
}
