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

namespace sushi::window {

    class Window;
    class WindowLogic;
}

namespace sushi::graphics {

    class GraphicsDevice;
}

namespace sushi::drivers {

    class ApplicationDriver;
}

namespace sushi::application {

    /**

     \brief `Application` class

     Object that initialises Sushi.

     This object should be only initialised once. Usually at `main.cpp` file.
     Use `initialise` to initialise the application.
     Use `Application::instance` to get the necessary properties such as the `driver`, `graphicsDevice`, and `storageManager`.
     Use `spawnWindow()` to create a window. **DO NOT INITIALISE BY CREATING A WINDOW INSTANCE**
    */
    class Application final: public core::CoreObject {

        friend class drivers::ApplicationDriver;

    public:

        typedef std::function<void(Application const*)> initialiseCallback;


        SUSHI_PO_STRONG
        static Application*                 instance;


        /**

         Method to initalise sushi

         */
        static void                         initialise          (SUSHI_PT_TRANSFER drivers::ApplicationDriver* platformDriver,
                                                                 const initialiseCallback& initCallback);

        static void                         destroy             ();

    private:

        SUSHI_PO_STRONG
        drivers::ApplicationDriver*         platformDriver;


        SUSHI_PO_STRONG
        graphics::GraphicsDevice*           graphicsDevice;

        SUSHI_PO_STRONG
        void*                               storageManager;


        initialiseCallback                  initialisationCallback;


        SUSHI_PO_WEAK mutable
        std::vector<window::Window*>        trackedWindows;


    public:

        explicit Application                                    (SUSHI_PT_TRANSFER drivers::ApplicationDriver* platformDriver);

        ~Application                                            ();

        SUSHI_PT_REF
        const drivers::ApplicationDriver*   getPlatformDriver   () const;

        SUSHI_PT_REF
        const graphics::GraphicsDevice*     getGraphicsDevice   () const;

        SUSHI_PT_REF
        const void*                         getStorageManager   () const;


        const std::vector<window::Window*>& getTrackedWindows   () const;


        const initialiseCallback&           getInitCallback     () const;

    public:

        SUSHI_PO_STRONG
        window::Window*                     spawnWindow         (SUSHI_PT_TRANSFER window::WindowLogic* logic,
                                                                 const std::u16string& title,
                                                                 const core::Rectangle& location) const;
    };
}
