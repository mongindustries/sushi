//
//  GraphicsDeviceDriver.swift
//  sushigraphics
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import sushicore

public protocol GraphicsDeviceDriver: class {

    func createGraphicsDevice   () -> Any


    func createGraphicsSurface  (with initialSize: Vector2, _ dpi: Float32, to target: Any) -> Any

    func resizeGraphicsSurface  (_ graphicsSurface: GraphicsSurface, to newSize: Vector2, _ newDpi: Float32)
}
