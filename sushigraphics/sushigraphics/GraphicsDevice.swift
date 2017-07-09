//
//  GraphicsDevice.swift
//  sushigraphics
//
//  Created by Michael Ong on 28/6/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore

public class GraphicsDevice {

    public var      driver          : GraphicsDeviceDriver?


    public internal(set)
    var             backingDevice   : Any


    public func     createSurface   (with initialSize: Vector2, _ dpi: Double, to target: Any) throws -> GraphicsSurface {

        guard let driver = driver else { throw FastFailType.driverNotInstalled }

        let     surface                 = GraphicsSurface()

                surface.backingSurface  = driver.createGraphicsSurface(with: initialSize, dpi, to: target)
                surface.driver          = driver

                surface.backingSize     = initialSize

        return  surface
    }


    public init                     (backingType: Any) {

        self.backingDevice = backingType
    }
}
