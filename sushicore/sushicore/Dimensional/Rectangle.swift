//
//  Rectangle.swift
//  sushicore
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import simd

public struct Rectangle {

    public var          origin  : Vector2

    public var          size    : Vector2
}

public struct RectangleEdge {

    public var          left    : Float

    public var          right   : Float

    public var          top     : Float

    public var          bottom  : Float
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

extension RectangleEdge {

    public static var   zero    : RectangleEdge {

        return .init(left: 0, right: 0, top: 0, bottom: 0)
    }

    public init                 (l left: Float, r right: Float, t top: Float, b bottom: Float) {

        self.left   = left
        self.right  = right
        self.top    = top
        self.bottom = bottom
    }

    public static func ==(_ lhs: RectangleEdge, _ rhs: RectangleEdge) -> Bool {

        return  lhs.left    == rhs.left &&
                lhs.right   == rhs.right &&
                lhs.top     == rhs.top &&
                lhs.bottom  == rhs.bottom
    }
}
