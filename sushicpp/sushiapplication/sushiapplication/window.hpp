// window.hpp
// sushiapplication - sushicpp
// 
// Created: 01:19 08/15/2017
// Author: Michael Ong

#pragma once

#include <functional>
#include <vector>
#include <string>

namespace sushi::application {

    /**

    `Application` class

    Object that initialises Sushi.

        - This object should be only initialised once. Usually at `main.swift` file.

        - Use `initialise` to initialise the application.

        - Use `Application::instance` to get the necessary properties such as the `driver`, `graphicsDevice`, and `storageManager`.

        - Use `spawnWindow()` to create a window. **DO NOT INITIALISE BY CREATING A WINDOW INSTANCE**
    */
    class Application final {
    
    public:

        typedef std::function<void(void)>   initialiseCallback;


        static Application*                 instance;


        static void                         initialise  (void* driver, initialiseCallback initCallback);

        static void                         destroy     ();


    private:

        void*                               platformDriver;


        void*                               graphicsDevice;

        void*                               storageManager;


        initialiseCallback                  initialisationCallback;


        std::vector<void*>                  trackedWindows;


    public:

        Application                         (void* platformDriver);

        ~Application                        ();


    public:

        void* spawnWindow(void* logic, std::)
    };
}
