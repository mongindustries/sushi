//
//  DimensionalOperations.swift
//  sushicore
//
//  Created by Michael Ong on 10/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

extension Dimensional2 {

    public static func * (_ lhs: Dimensional2, rhs: Size) -> Dimensional2 {

        return Dimensional2(lhs.x * rhs, lhs.y * rhs)
    }

    public static func + (_ lhs: Dimensional2, rhs: Size) -> Dimensional2 {

        return Dimensional2(lhs.x + rhs, lhs.y + rhs)
    }
}
