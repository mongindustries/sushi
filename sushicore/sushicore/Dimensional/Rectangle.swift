//
//  Rectangle.swift
//  sushicore
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public struct Rectangle {

    public var          origin  : Vector2

    public var          size    : Vector2
}

extension Rectangle {

    public static var   zero    : Rectangle {

        return .init(x: 0, y: 0, width: 0, height: 0)
    }

    public init                 (x: Float32, y: Float32, width: Float32, height: Float32) {

        self.init(origin: .init(x: x, y: y), size: .init(x: width, y: height))
    }


    public static func ==(_ lhs: Rectangle, _ rhs: Rectangle) -> Bool {

        return lhs.size == rhs.size && lhs.origin == rhs.origin
    }
}
