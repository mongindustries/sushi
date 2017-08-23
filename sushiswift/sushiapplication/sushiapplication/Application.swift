//
//  Application.swift
//  sushiapplication
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore
import sushiwindow
import sushigraphics
import sushistorage

/**

 `Application` class

 Object that intiialises Sushi.

 - This object should be only initialised once. Usually at `main.swift` file.

 - Use `initialise(with:initiCallback:)` to initialise the application.

 - Use `Application.instance` to get the necessary properties such as the `driver`, `graphicsDevice`, and `storageManager`.

 - Use `spawnWindow(logic:title:at:)` to create a window. **DO NOT INITIALISE BY CREATING A WINDOW INSTANCE**

 */
public class Application {

    /// The represented instance of the `Application`. This property is filled when initialise(with:initCallback:) is called.
    public private(set) static var  instance        : Application!

    /**

     Method to initialise the application. This usually is called inside `main.swift` file.

     - parameter driver: The driver to facilitate communications with the operating system.
     - parameter callback: Callback called when the application has finished initialising but just before its event loop executes.

     */
    public static func              initialise      (with driver: ApplicationDriver, initCallback callback: @escaping () -> Void) {

        instance                = Application(driving: driver)
        instance.initCallback   = callback

        instance.driver.initialise()
    }

    /**

     Method to destroy the application. This usually is called inside `main.swift` file.

     */
    public static func              destroy         () {

        // TODO: destroy any remaining windows

        instance.driver.destroy()

        instance = nil
    }


    /// The driver for this application instance.
    public let                      driver          : ApplicationDriver

    /// The graphics device instance.
    public let                      graphicsDevice  : GraphicsDevice

    /// The storage manager instance.
    public let                      storageManager  : StorageManager


    /// The callback for performing initialisation. This is the value passed in `initialise(with:initCallback:)`.
    public private(set)
    var                             initCallback    : (() -> Void)!


    /// A list of `Window` objects that are currently bound to this application.
    public private(set)
    var                             trackedWindows  = [ Window ]()



    private init                                    (driving driver: ApplicationDriver) {

        self.driver                 = driver

        self.storageManager         = .init(driving:        driver.storageManagerDriver)

        self.graphicsDevice         = .init(backingType:    driver.graphicsDeviceDriver.createGraphicsDevice())
        self.graphicsDevice.driver  = driver.graphicsDeviceDriver
    }


    /**

     Creates a `Window` instance.

     Calling this method initialises the window, creates the graphics surface and input dispatcher for the window,
     and binds the window to the `Application` instance.

     This method should be used instead of calling `Window.init()` explicitly.

     - parameter logic: The interaction logic for the window.
     - parameter title: The initial title for the window.
     - parameter location: The initial location for the window.

     - returns: The newly created `Window` object.

     */
    public func                     spawnWindow     (logic: WindowLogic, title: String, at location: Rectangle) -> Window {

        let     window          = Window(with: driver.windowDriver, logic: logic, graphicsDevice)

                window.title    = title
                window.location = location

        trackedWindows.append(window)

        window.logic.initialise     ()

        window.logic.run            ()

        return  window
    }
}
