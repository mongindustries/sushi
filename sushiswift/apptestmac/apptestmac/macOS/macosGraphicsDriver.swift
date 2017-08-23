//
//  macosGraphicsDriver.swift
//  apptestmac
//
//  Created by Michael Ong on 10/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import AppKit

import simd
import Metal

import sushicore
import sushigraphics

class macosGraphicsDriver: GraphicsDeviceDriver {

    private var     mtlDevice               : MTLDevice? = MTLCreateSystemDefaultDevice()


    func            createGraphicsDevice    () -> Any {

        guard let   mtlDevice   = self.mtlDevice else { FastFail.instance.crash(with: .unexpectedPayload) }

        return      mtlDevice
    }

    func            createGraphicsSurface   (with initialSize: Vector2, _ dpi: Float32, to target: Any) -> Any {

        guard let   mtlDevice       = self.mtlDevice        else { FastFail.instance.crash(with: .unexpectedPayload) }

        guard let   vc              = target as? NSWindow   else { FastFail.instance.crash(with: .unexpectedPayload) }

        let         cametalLayer    : CAMetalLayer = .init()

        cametalLayer.device         = mtlDevice
        cametalLayer.drawableSize   = .init(width: CGFloat(initialSize.x), height: CGFloat(initialSize.y))
        cametalLayer.pixelFormat    = .bgra8Unorm
        cametalLayer.isOpaque       = true

        vc.contentView!.wantsLayer  = true
        vc.contentView!.layer       = cametalLayer

        return  cametalLayer
    }

    func            resizeGraphicsSurface   (_ graphicsSurface: GraphicsSurface, to newSize: Vector2, _ newDpi: Float32) {

        guard let caMetalLayer  = graphicsSurface.backingSurface as? CAMetalLayer else { FastFail.instance.crash(with: .unexpectedPayload) }

        let scale                       = Float(NSScreen.main?.backingScaleFactor ?? 1)

        caMetalLayer    .drawableSize   = .init(width: CGFloat(newSize.x * scale), height: CGFloat(newSize.y * scale))
        graphicsSurface .backingSize    = .init(scale * newSize.x, scale * newSize.y)
    }
}
