//
//  InputSourceSink.swift
//  sushiinput
//
//  Created by Michael Ong on 12/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public protocol InputSourceSink: class {

    func sendMessage(from source: InputSourceAny, _ message: InputDispatcherEvent)
}
