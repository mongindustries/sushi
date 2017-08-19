// application.hpp
// sushiapplication - sushicpp
// 
// Created: 01:19 08/15/2017
// Author: Michael Ong

#pragma once

#include <functional>
#include <vector>
#include <string>

#include <sushicore/Rectangle.h>
#include <sushicore/CoreObject.h>
#include <sushicore/PointerOwnership.h>

#include <sushiwindow/window.hpp>
#include <sushiwindow/windowLogic.hpp>

#include "applicationDriver.hpp"

namespace sushi::application {

    /**

    `Application` class

    Object that initialises Sushi.

        - This object should be only initialised once. Usually at `main.swift` file.

        - Use `initialise` to initialise the application.

        - Use `Application::instance` to get the necessary properties such as the `driver`, `graphicsDevice`, and `storageManager`.

        - Use `spawnWindow()` to create a window. **DO NOT INITIALISE BY CREATING A WINDOW INSTANCE**
    */
    class Application final: public core::CoreObject {
    
    public:

        typedef std::function<void(void)>   initialiseCallback;


        SUSHI_PO_STRONG
        static Application*                 instance;


        static void                         initialise          (SUSHI_PT_TRANSFER drivers::applicationDriver* platformDriver,
                                                                 const initialiseCallback& initCallback);

        static void                         destroy             ();

    private:

        drivers::applicationDriver*         platformDriver;


        void*                               graphicsDevice;

        void*                               storageManager;


        initialiseCallback                  initialisationCallback;


        SUSHI_PO_WEAK
        std::vector<window::Window*>        trackedWindows;


    public:

        explicit Application                                    (SUSHI_PT_TRANSFER drivers::applicationDriver* platformDriver);

        ~Application                                            ();


        const drivers::applicationDriver*   getPlatformDriver   () const;

        const void*                         getGraphicsDevice   () const;

        const void*                         getStorageManager   () const;


        const std::vector<window::Window*>& getTrackedWindows   () const;

    public:

        SUSHI_PO_STRONG window::Window*     spawnWindow         (window::WindowLogic* logic,
                                                                 const std::u16string& title,
                                                                 const core::Rectangle& location) const;
    };
}
