//
//  DimensionalOperations.swift
//  sushicore
//
//  Created by Michael Ong on 10/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

extension Dimensional2: Equatable {

    public static func  *   (_ lhs: Dimensional2, rhs: Size) -> Dimensional2 {

        return Dimensional2(lhs.x * rhs, lhs.y * rhs)
    }

    public static func  +   (_ lhs: Dimensional2, rhs: Size) -> Dimensional2 {

        return Dimensional2(lhs.x + rhs, lhs.y + rhs)
    }

    public static func  ==  (_ lhs: Dimensional2, _ rhs: Dimensional2) -> Bool {

        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Dimensional3: Equatable {

    public static func  *   (_ lhs: Dimensional3, rhs: Size) -> Dimensional3 {

        return Dimensional3(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs)
    }

    public static func  +   (_ lhs: Dimensional3, rhs: Size) -> Dimensional3 {

        return Dimensional3(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs)
    }

    public static func  ==  (_ lhs: Dimensional3, _ rhs: Dimensional3) -> Bool {

        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

extension Dimensional4: Equatable {

    public static func  *   (_ lhs: Dimensional4, rhs: Size) -> Dimensional4 {

        return Dimensional4(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    }

    public static func  +   (_ lhs: Dimensional4, rhs: Size) -> Dimensional4 {

        return Dimensional4(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs, lhs.w + rhs)
    }

    public static func  ==  (_ lhs: Dimensional4, _ rhs: Dimensional4) -> Bool {

        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }
}
