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

        SUSHI_PT_REF
        const Window*   getWindow       () const { return window; }


        virtual void    initialise      (SUSHI_PT_REF void* fromSavedState) = 0;

        SUSHI_PT_TRANSFER
        virtual void*   destroy         (bool permanentally) = 0;


        virtual void    stateChanged    (unsigned int newState) = 0;
    };
}
