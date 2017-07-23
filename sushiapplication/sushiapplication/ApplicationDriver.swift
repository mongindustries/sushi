//
//  ApplicationDriver.swift
//  sushiapplication
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushiwindow
import sushigraphics
import sushistorage

/**

 `ApplicationDriver` protocol

 Protocol responsible for application-centric operations with the operating system.

 Methods defined here are to initialise and destroy a Sushi application.

 Also defined here are Drivers that initialise important components for Sushi.

 */
public protocol ApplicationDriver: class {

    /// Property that defines the driver when creating new `Window` instances.
    /// The instance returned here **MUST** be unique for each `Window` instance.
    var     windowDriver            : WindowDriver          { get }


    /// Property that defines the graphics device interface to the OS.
    var     graphicsDeviceDriver    : GraphicsDeviceDriver  { get }

    /// Property that defines the storage device interface to the OS.
    var     storageManagerDriver    : StorageManagerDriver  { get }


    /// Method that `Application` calls to initialise OS-specific functions.
    func    initialise              ()

    /// Method that `Application` calls to finalise OS-specific functions.
    func    destroy                 ()
}
