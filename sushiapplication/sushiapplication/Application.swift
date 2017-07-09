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

public class Application {

    public private(set) static var  instance        : Application!

    public static func              initialise      (with driver: ApplicationDriver, initCallback callback: @escaping () -> Void) {

        instance                = Application(driving: driver)
        instance.initCallback   = callback

        instance.driver.initialise()
    }

    public static func              destroy         () {

        // TODO: destroy any remaining windows

        instance.driver.destroy()

        instance = nil
    }


    public let                      driver          : ApplicationDriver

    public let                      graphicsDevice  : GraphicsDevice


    public private(set)
    var                             initCallback    : (() -> Void)!


    public private(set)
    var                             trackedWindows  = [ Window ]()



    private init                                    (driving driver: ApplicationDriver) {

        self.driver                 = driver

        self.graphicsDevice         = .init(backingType: driver.graphicsDeviceDriver.createGraphicsDevice())
        self.graphicsDevice.driver  = driver.graphicsDeviceDriver
    }


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
