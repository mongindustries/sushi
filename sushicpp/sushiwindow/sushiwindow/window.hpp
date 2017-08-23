// window.hpp
// sushiwindow - sushicpp
// 
// Created: 13:20 08/19/2017
// Author: Michael Ong

#pragma once

#include <sushicore/Rectangle.h>
#include <sushicore/CoreObject.h>
#include <sushicore/PointerOwnership.h>

#include <string>
#include <set>

#include "windowDriver.hpp"
#include "windowStates.hpp"

namespace sushi::graphics {

    class GraphicsSurface;
}

namespace sushi::window {

    class WindowLogic;

    struct WindowEncapsulatedMessage {

        unsigned int                        dataID;

        void*                               data;
    };

    class Window final: public core::CoreObject, public drivers::WindowDriverDelegate {

    public:

        static core::Rectangle              undefinedRectangle;

        static WindowEncapsulatedMessage*   encapsulate         (unsigned int dataID, void* data);

    private:

        core::Rectangle                     _location;

        float                               _dpi;

        std::u16string                      _title;

        std::set<WindowStates>              _windowState;


        SUSHI_PO_STRONG
        void*                               _backingWindow;


        SUSHI_PO_STRONG
        drivers::WindowDriver*              _windowDriver;

        SUSHI_PO_STRONG
        graphics::GraphicsSurface*          _graphicsSurface;

        SUSHI_PO_STRONG
        void*                               _inputDispatcher;


        SUSHI_PO_STRONG
        WindowLogic*                        _windowLogic;

    public:

        explicit                            Window              (SUSHI_PT_TRANSFER drivers::WindowDriver* driver, SUSHI_PT_TRANSFER WindowLogic* logic);

        explicit                            Window              (const Window& copy) = delete;

        explicit                            Window              (const Window&& move);


        ~Window                                                 ();


        SUSHI_PT_REF
        const void*                         getBackingWindow    () const { return _backingWindow; }


        SUSHI_PT_REF
        const drivers::WindowDriver*        getWindowDriver     () const { return _windowDriver; }

        SUSHI_PT_REF
        graphics::GraphicsSurface*          getGraphicsSurface  () const { return _graphicsSurface; }

        SUSHI_PT_REF
        const void*                         getInputDispatcher  () const { return _inputDispatcher; }


        const core::Rectangle&              getLocation         () const { return _location;  }

        const float&                        getDPI              () const { return _dpi; }

        const std::u16string&               getTitle            () const { return _title; }

        const std::set<WindowStates>&       getWindowState      () const { return _windowState; }


        void                                setLocation         (const core::Rectangle& value);

        void                                setDPI              (const float& value);

        void                                setTitle            (const std::u16string& value);

        void                                setWindowState      (const std::set<WindowStates>& value);


        void                                send                (WindowDriverMessages message,
                                                                 SUSHI_PT_REF WindowEncapsulatedMessage* data) override;
    };
}
