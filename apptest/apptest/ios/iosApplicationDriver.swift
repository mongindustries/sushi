//
//  iosApplicationDriver.swift
//  apptest
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore

import sushiapplication
import sushiwindow
import sushigraphics

@objc(iosApplicationDriverDelegate)
class iosApplicationDriverDelegate: NSObject, UIApplicationDelegate {

    func    applicationDidFinishLaunching   (_ application: UIApplication) {

        Application.instance.initCallback()
    }
}

class iosApplicationDriver: ApplicationDriver {

    var     windowDriver                    : WindowDriver          { return iosWindowDriver    () }

    var     graphicsDeviceDriver            : GraphicsDeviceDriver  { return iosGraphicsDriver  () }


    func    initialise                      () {

        let argc = CommandLine.argc
        let argv = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(argc))

        UIApplicationMain(argc, argv, nil, String(describing: iosApplicationDriverDelegate.self))
    }

    func    destroy                         () {

    }
}
