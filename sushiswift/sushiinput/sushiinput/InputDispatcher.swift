//
//  InputDispatcher.swift
//  sushiinput
//
//  Created by Michael Ong on 23/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore

public class InputDispatcher: InputSourceSink {

    var             inputSources        = [ InputSourceAny : (InputDispatcherEvent) -> Void ]()

    var             messageBuffer       = [ () -> Void ]()


    let             backingStore        : Any


    public var      logInputDispatches  = false


    public init                         (from backingStore: Any) {

        self.backingStore = backingStore
    }

    deinit {

        flush()

        inputSources.forEach({

            $0.key.destroy()
        })

        inputSources.removeAll()
    }


    public func     listen              (from source: InputSourceAny, with eventCallback: @escaping (InputDispatcherEvent) -> Void) {

        inputSources[source]    = eventCallback

        source.backingStore     = backingStore
        source.sink             = self

        source.associatedOp     = .init()

        source.initialize()

        source.associatedOp!.addOperation { [unowned source] in

            source.run()
        }
    }

    public func     detach              (from source: InputSourceAny) {

        source.destroy()

        source.associatedOp!.waitUntilAllOperationsAreFinished()
    }


    public func     sendMessage         (from source: InputSourceAny, _ message: InputDispatcherEvent) {

        #if DEBUG
        guard inputSources.keys.contains(source) else { FastFail.instance.crash(with: .unexpectedPayload) }
        #endif

        let bufferMessage = inputSources[source]!

        DispatchQueue.main.async { [unowned self] in

            self.messageBuffer.append({ bufferMessage(message)  })
        }
    }


    public func     flush               () {

        #if DEBUG
        assert(Thread.current == Thread.main)
        #endif

        messageBuffer.forEach   ({ $0() })
        messageBuffer.removeAll ()
    }
}

open class InputDispatcherEvent {

    /**
     Value that the input dispatcher fills in when `sendMessage(from:_:)` is called with this event.

     The value will return nil if `logInputDispatches` property of `InputDispatcher` is set to `false`.

     */
    internal(set) public
    var             timeDispatched      : Date? = nil

    /**
     Flag that labels the input event as a coalesced event
     from multiple discrete event emissions.

     - Important:

         Implementing input sources should set this to true if the input source believes the event:
         - came from two or more emissions
         - can be merged into a singular emission without ailiasing
         - has a particular temporal restriction that batches event emissions

     */
    public var      coalesced           : Bool  = false


    public init                         () {


    }
}
