//
//  SceneMetal.swift
//  RendererMetal
//
//  Created by Michael Ong on 17/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

import Renderer
import Metal

import QuartzCore
import CoreGraphics

import UIKit

public class SceneMetal: Scene {

    public typealias    GraphicsDevice  = MTLDevice

    public typealias    ContainingView  = UIView


    public static let   instance        = SceneMetal()


    public var          graphicsDevice  : MTLDevice!

    internal var        commandQueue    : MTLCommandQueue!


    private var         rootLayer       : Layer?



    weak var            layer           : CAMetalLayer!


    public init                         () {

        graphicsDevice  = nil
        commandQueue    = nil

        layer           = nil
    }


    public func         setLayer        (root layer: Layer) {

        rootLayer = layer
    }


    public func         spawn           (from view: UIView) {

        graphicsDevice  = MTLCreateSystemDefaultDevice()

        commandQueue    = graphicsDevice.makeCommandQueue()

        let mtlLayer                = CAMetalLayer()

            mtlLayer.frame          = view.layer.bounds
            mtlLayer.isOpaque       = true

            mtlLayer.device         = graphicsDevice
            mtlLayer.pixelFormat    = .bgra8Unorm

            mtlLayer.drawableSize   = view.bounds.size

            layer                   = mtlLayer

        view.layer.addSublayer(mtlLayer)
    }

    public func         die             () {


    }


    public func         step            (with timeInterval: Double) {

        if let      rootLayer   = rootLayer {

            rootLayer.step(with: timeInterval)
        }

        guard let   swapChain   = layer.nextDrawable() else {

            return
        }

        let         buffer      = commandQueue.makeCommandBuffer()
        let         texture     = swapChain.texture

        let         descriptor  = MTLRenderPassDescriptor()

        descriptor.colorAttachments[0].texture      = texture

        descriptor.colorAttachments[0].loadAction   = .clear
        descriptor.colorAttachments[0].storeAction  = .store
        descriptor.colorAttachments[0].clearColor   = MTLClearColorMake(1, 0.5, 0.5, 1)

        let         encoder     = buffer.makeRenderCommandEncoder(descriptor: descriptor)

        encoder     .endEncoding()

        buffer      .present    (swapChain)
        buffer      .commit     ()
    }
}
