//
//  InputSource.swift
//  sushiinput
//
//  Created by Michael Ong on 23/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore

/**

 An `InputSourceAny` object intercepts input events from the OS.
 Its intended to be used with `InputDispatcher`'s `listen(from:_:)` method.
 The input source would be responsible for reading input state from the OS,
 and inform the input dispatcher whence it will be right for event
 dispatching for sushi.

 */
open class InputSourceAny: Hashable {

    public final
    class func          ==                  (lhs: InputSourceAny, rhs: InputSourceAny) -> Bool {

        return lhs.id == rhs.id
    }


    open var            id                  : String { FastFail.instance.crash(with: .unimplemented) }

    public var          hashValue           : Int { return id.hashValue }


    internal var        associatedOp        : OperationQueue?


    public internal(set)
    var                 backingStore        : Any!


    internal(set) public
    weak var            sink                : InputSourceSink? = nil


    public init                             () {

    }

    /// Method to initialize the input source. It is imperative that any calls made here should
    /// not block caller indefinitely. Any blocking actions must be done in `run()`.
    open func           initialize          () {

    }

    /// Method that destroys the input source. Do not also block this call indefinitely.
    open func           destroy             () {


    }


    /// Method that runs the input source. The input dispatcher will make a dedicated thread
    /// for the code inside here to run into.
    open func           run                 () {


    }
}

/**

 Type specific version of `InputSourceAny`. Use this if you want platform abstraction.

 */
open class InputSource<Driver: InputSourceDriver>: InputSourceAny {

    open var            driver              : Driver { return .init() }

    var                 _vendedDriver       : Driver!


    open override func  initialize          () {

        _vendedDriver               = driver
        _vendedDriver.inputSource   = self

        _vendedDriver.initialize    (from: backingStore)
    }

    open override func  destroy             () {

        _vendedDriver.destroy       ()
    }
}
