#pragma once
#include <sushicore/CoreObject.h>
#include <sushicore/PointerOwnership.h>

namespace sushi::window {
    
    class Window;

    class WindowLogic: core::CoreObject {
        
        friend class Window;

    private:

        SUSHI_PO_WEAK
        Window*         window          = nullptr;

    public:

        SUSHI_PO_WEAK
        const Window*   getWindow       () const { return window; }


        virtual void    initialise      (void* fromSavedState) = 0;

        virtual void*   destroy         (bool permanentally) = 0;


        virtual void    stateChanged    (unsigned int newState) = 0;
    };
}
