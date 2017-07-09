//
//  Vector.swift
//  sushicore
//
//  Created by Michael Ong on 22/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public typealias Vector2 = Dimensional2<Double>

public typealias Vector3 = Dimensional3<Double>

public typealias Vector4 = Dimensional4<Double>


extension Dimensional2 where Size == Double {

    public static var zero: Dimensional2 { return .init(x: 0, y: 0) }
}

extension Dimensional3 where Size == Double {

    public static var zero: Dimensional3 { return .init(x: 0, y: 0, z: 0) }
}

extension Dimensional4 where Size == Double {

    public static var zero: Dimensional4 { return .init(x: 0, y: 0, z: 0, w: 0) }
}
