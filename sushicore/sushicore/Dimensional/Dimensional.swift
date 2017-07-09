//
//  Dimensional.swift
//  sushicore
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public struct Dimensional2<Size: Numeric> {

    public var  x   : Size

    public var  y   : Size
}

public struct Dimensional3<Size: Numeric> {

    public var  x   : Size

    public var  y   : Size

    public var  z   : Size
}

public struct Dimensional4<Size: Numeric> {

    public var  x   : Size

    public var  y   : Size

    public var  z   : Size

    public var  w   : Size
}


extension Dimensional2 {

    public init(_ x: Size, _ y: Size ) {

        self.x = x
        self.y = y
    }

    public static func ==(_ lhs: Dimensional2, _ rhs: Dimensional2) -> Bool {

        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Dimensional3 {

    public init(_ x: Size, _ y: Size, _ z: Size) {

        self.x = x
        self.y = y
        self.z = z
    }

    public init(_ dimension2: Dimensional2<Size>, _ z: Size) {

        self.x = dimension2.x
        self.y = dimension2.y

        self.z = z
    }

    public static func ==(_ lhs: Dimensional3, _ rhs: Dimensional3) -> Bool {

        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

extension Dimensional4 {

    public init(_ x: Size, _ y: Size, _ z: Size, _ w: Size) {

        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init(_ dimension2: Dimensional2<Size>, _ z: Size, _ w: Size) {

        self.x = dimension2.x
        self.y = dimension2.y

        self.z = z
        self.w = w
    }

    public init(_ dimension3: Dimensional3<Size>, _ w: Size) {

        self.x = dimension3.x
        self.y = dimension3.y
        self.z = dimension3.z

        self.w = w
    }

    public static func ==(_ lhs: Dimensional4, _ rhs: Dimensional4) -> Bool {

        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }
}
