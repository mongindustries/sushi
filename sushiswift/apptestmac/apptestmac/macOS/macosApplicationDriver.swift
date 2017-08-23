//
//  macosApplicationDriver.swift
//  apptestmac
//
//  Created by Michael Ong on 10/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import AppKit

import sushicore

import sushiapplication
import sushiwindow
import sushigraphics
import sushistorage

@objc(macosApplicationDriverDelegate)
class macosApplicationDriverDelegate: NSObject, NSApplicationDelegate {

    func    applicationDidFinishLaunching   (_ notification: Notification) {

        Application.instance.initCallback()
    }
}

class macosApplicationDriver: ApplicationDriver {

    var     storageManagerDriver            : StorageManagerDriver  { return macosStorageManagerDriver  () }


    var     windowDriver                    : WindowDriver          { return macosWindowDriver          () }

    var     graphicsDeviceDriver            : GraphicsDeviceDriver  { return macosGraphicsDriver        () }


    func    initialise                      () {

        let argc = CommandLine.argc
        let argv = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: Optional<UnsafeMutablePointer<CChar>>.self, capacity: Int(argc))

        _ = NSApplicationMain(argc, argv)
    }

    func    destroy                         () {

    }
}
