//
//  WindowDriver.swift
//  sushiwindow
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore

/**

 Protocol that `Window` conforms to so that OS can send events to `Window`.

 */
public protocol WindowDriverDelegate: class {

    func        send            (message: WindowDriverMessage, data: Any)
}

/**

 Protocol to conform so that `Window` can process OS events.

 */
public protocol WindowDriver: class {

    weak var    delegate        : (Window & WindowDriverDelegate)? { get set }


    func        undefinedRect   () -> Rectangle


    func        initialise      () -> Any

    func        destory         ()


    func        process         (message: WindowDriverMessage, data: Any)
}
