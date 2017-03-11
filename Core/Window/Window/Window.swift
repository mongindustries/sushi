//
//  Window.swift
//  Window
//
//  Created by Michael Ong on 14/2/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public protocol Window: class {

    associatedtype NativeWindowType

    init(from nativeWindow: NativeWindowType)
}
