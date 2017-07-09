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

public protocol ApplicationDriver: class {

    var     windowDriver            : WindowDriver          { get }


    var     graphicsDeviceDriver    : GraphicsDeviceDriver  { get }

    var     storageManagerDriver    : StorageManagerDriver  { get }


    func    initialise              ()

    func    destroy                 ()
}
