//
//  InputSourcePointer.swift
//  sushiinput
//
//  Created by Michael Ong on 12/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public class InputSourcePointer<Driver: InputSourceDriver>: InputSource<Driver> {

    public override var     id          : String {

        return "sushi_pointer"
    }
}

public class InputDispatcherPointerEvent: InputDispatcherEvent {

    public struct PointerState: OptionSet {

        public let          rawValue        : Int

        public init                         (rawValue: Int) {

            self.rawValue = rawValue
        }

        public static let   button_left     = PointerState(rawValue: 0)

        public static let   button_right    = PointerState(rawValue: 1)
    }

    public var  points  : [ CGPoint ]   = [ ]

    public var  state   : PointerState  = [ ]
}
