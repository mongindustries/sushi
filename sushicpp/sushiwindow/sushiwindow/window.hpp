// window.hpp
// sushiwindow - sushicpp
// 
// Created: 13:20 08/19/2017
// Author: Michael Ong

#pragma once

#include <sushicore/Rectangle.h>
#include <sushicore/CoreObject.h>

#include <string>

#include "windowDriver.hpp"

namespace sushi::window {

class WindowLogic;

class Window final: public core::CoreObject, public drivers::WindowDriverDelegate {
        
    private:

        core::Rectangle                 _location;

        float                           _dpi;

        std::u16string                  _title;

        unsigned int                    _windowState;


        drivers::WindowDriver*          _windowDriver;

        void*                           _graphicsSurface;

        void*                           _inputDispatcher;


        WindowLogic*                    _windowLogic;

    public:

        explicit                        Window              (drivers::WindowDriver* driver, WindowLogic* logic);

        ~Window                                             ();


        const drivers::WindowDriver*    getWindowDriver     () const { return _windowDriver; }

        const void*                     getGraphicsSurface  () const { return _graphicsSurface; }

        const void*                     getInputDispatcher  () const { return _inputDispatcher; }


        const core::Rectangle&          getLocation         () const { return _location;  }

        const float&                    getDPI              () const { return _dpi; }

        const std::u16string&           getTitle            () const { return _title; }

        const unsigned int              getWindowState      () const { return _windowState; }


        void                            setLocation         (const core::Rectangle& value);

        void                            setDPI              (const float& value);

        void                            setTitle            (const std::u16string& value);

        void                            setWindowState      (const unsigned int& value);


    private:

        void                            send                (unsigned message, void* data) override;
    };
}
