//
//  DimensionalConstructors.swift
//  sushicore
//
//  Created by Michael Ong on 16/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

extension Dimensional2 {

    public init(_ x: Size, _ y: Size ) {

        self.x = x
        self.y = y
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
}
