//
//  macOSInputSourcePointer.swift
//  apptestmac
//
//  Created by Michael Ong on 12/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import AppKit

import sushiinput

class macOSInputSourceDriver: InputSourceDriver {

    weak var        inputSource             : InputSourceAny!

    weak var        window                  : NSWindow!


    let             ig                      = macOSInputSourceDriverResponder()


    required init                           () {


    }


    func            initialize              (from backingStore: Any) {

        window          = backingStore  as! NSWindow
        ig.inputSource  = inputSource   as! InputSourcePointer<macOSInputSourceDriver>

        guard window.makeFirstResponder(ig) else { fatalError("Cannot become first responder!") }
    }

    func            destroy                 () {

        
    }
}

class macOSInputSourceDriverResponder: NSResponder {

    weak var        inputSource             : InputSourcePointer<macOSInputSourceDriver>!


    override func   mouseMoved              (with event: NSEvent) {

    }

    override func   mouseUp                 (with event: NSEvent) {

    }

    override func   mouseDown               (with event: NSEvent) {

    }

    override func   resignFirstResponder    () -> Bool {

        return false
    }
}
