//
//  GraphicsSurface.swift
//  sushigraphics
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore

public class GraphicsSurface {

    public var      backingSurface  : Any!

    public var      backingSize     : Vector2 = .zero


    public internal(set)
    weak var        driver          : GraphicsDeviceDriver?


    public init                     () {


    }


    public func     resize          (to newSize: Vector2, _ dpi: Double) throws {

        guard let driver = driver else { throw FastFailType.driverNotInstalled }

        driver.resizeGraphicsSurface(self, to: newSize, dpi)
    }
}
