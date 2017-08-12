//
//  InputSourceDriver.swift
//  sushiinput
//
//  Created by Michael Ong on 23/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

/**

 Protocol that an `InputSource` requires to have to properly interact with the OS.

 */
public protocol InputSourceDriver {

    weak var    inputSource     : InputSourceAny! { get set }


    init                        ()


    func        initialize      (from backingStore: Any)

    func        destroy         ()
}
