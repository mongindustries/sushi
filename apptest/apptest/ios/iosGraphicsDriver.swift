//
//  iosGraphicsDriver.swift
//  apptest
//
//  Created by Michael Ong on 8/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import Metal

import sushicore
import sushigraphics

class iosGraphicsDriver: GraphicsDeviceDriver {

    private let     mtlDevice               = MTLCreateSystemDefaultDevice()


    func            createGraphicsDevice    () -> Any {

        guard let   mtlDevice = self.mtlDevice else { FastFail.instance.crash(with: .unexpectedPayload) }

        return      mtlDevice
    }

    func            createGraphicsSurface   (with initialSize: Vector2, _ dpi: Double, to target: Any) -> Any {

        guard let   mtlDevice       = self.mtlDevice        else { FastFail.instance.crash(with: .unexpectedPayload) }

        guard let   vc              = target as? UIWindow   else { FastFail.instance.crash(with: .unexpectedPayload) }

        guard let   cametalLayer    = vc.rootViewController?.view.layer as? CAMetalLayer else { FastFail.instance.crash(with: .unexpectedPayload) }

        cametalLayer.device         = mtlDevice
        cametalLayer.drawableSize   = .init(width: initialSize.x, height: initialSize.y)
        cametalLayer.pixelFormat    = .bgra8Unorm
        cametalLayer.isOpaque       = true

        return  cametalLayer
    }

    func            resizeGraphicsSurface   (_ graphicsSurface: GraphicsSurface, to newSize: Vector2, _ newDpi: Double) {

        guard let caMetalLayer = graphicsSurface.backingSurface as? CAMetalLayer else { FastFail.instance.crash(with: .unexpectedPayload) }

        caMetalLayer.drawableSize = .init(width: newSize.x, height: newSize.y)
    }
}
