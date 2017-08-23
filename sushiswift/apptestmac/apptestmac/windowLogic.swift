//
//  windowLogic.swift
//  apptestmac
//
//  Created by Michael Ong on 10/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import Metal
import QuartzCore

import sushicore
import sushiwindow
import sushiapplication
import sushistorage

class windowLogic: WindowLogic {

    weak var    window              : Window!


    var         swapChain           : CAMetalLayer!


    var         commandQueue        : MTLCommandQueue!


    var         resource_vertLoc    : MTLBuffer!

    var         resource_vertCol    : MTLBuffer!


    var         resource_texture    : MTLTexture!


    var         library             : MTLLibrary!


    var         pipelineState       : MTLRenderPipelineState!


    var         cvDisplayLink       : CVDisplayLink?


    func        initialise          () {

        swapChain       = window.graphicsSurface.backingSurface as! CAMetalLayer

        let mtlDevice   = Application.instance.graphicsDevice.backingDevice as! MTLDevice

        commandQueue    = mtlDevice.makeCommandQueue()!

        let vertLoc: [ Vector4 ] = [

            Vector4( 0.0,  0.5, 0, 1),
            Vector4(-0.5, -0.5, 0, 1),
            Vector4( 0.5, -0.5, 0, 1),
            ]

        let vertCol: [ Vector4 ] = [

            Vector4.init(1, 0, 0, 1),
            Vector4.init(0, 1, 0, 1),
            Vector4.init(0, 0, 1, 1)
        ]

        library                 = try? mtlDevice.makeDefaultLibrary(bundle: Bundle.main)

        let function_fragment   = library.makeFunction(name: "fragment_main")
        let function_vertex     = library.makeFunction(name: "vertex_main")

        let pipelineDescriptor              = MTLRenderPipelineDescriptor()

        pipelineDescriptor.fragmentFunction = function_fragment
        pipelineDescriptor.vertexFunction   = function_vertex

        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

        pipelineState           = try? mtlDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)

        resource_vertLoc        = mtlDevice.makeBuffer(bytes: vertLoc, length: vertLoc.count * MemoryLayout<Vector4>.size, options: .cpuCacheModeWriteCombined)
        resource_vertCol        = mtlDevice.makeBuffer(bytes: vertCol, length: vertCol.count * MemoryLayout<Vector4>.size, options: .cpuCacheModeWriteCombined)

        CVDisplayLinkCreateWithActiveCGDisplays (&cvDisplayLink)
        CVDisplayLinkSetOutputCallback          ( cvDisplayLink!, refresh, Unmanaged<windowLogic>.passUnretained(self).toOpaque())

        CVDisplayLinkStart                      ( cvDisplayLink!)
    }

    func        finalise            () {

    }

    func        run                 () {


    }


    func        stateChanged        (to state: Set<WindowState>) {


    }
}

fileprivate func refresh             (_ link: CVDisplayLink,
                                      _ timeStamp: UnsafePointer<CVTimeStamp>,
                                      _ ouputTime: UnsafePointer<CVTimeStamp>,
                                      _ flagsIn: CVOptionFlags,
                                      _ flagsOut: UnsafeMutablePointer<CVOptionFlags>,
                                      _ context: UnsafeMutableRawPointer?) -> CVReturn {

    let logic           = Unmanaged<windowLogic>.fromOpaque(context!).takeUnretainedValue()

    let commandBuffer   = logic.commandQueue.makeCommandBuffer()!
    let drawable        = logic.swapChain.nextDrawable()!

    let renderPassDesc  = MTLRenderPassDescriptor()

    renderPassDesc.colorAttachments[0].texture      = drawable.texture
    renderPassDesc.colorAttachments[0].loadAction   = .clear
    renderPassDesc.colorAttachments[0].storeAction  = .store
    renderPassDesc.colorAttachments[0].clearColor   = .init(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)

    guard let encoder               = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDesc) else { return kCVReturnError }

    encoder.setRenderPipelineState  (logic.pipelineState)

    encoder.setVertexBuffer         (logic.resource_vertLoc, offset: 0, index: 0)
    encoder.setVertexBuffer         (logic.resource_vertCol, offset: 0, index: 1)

    encoder.drawPrimitives          (type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)

    encoder.endEncoding             ()

    commandBuffer.present           (drawable)
    commandBuffer.commit            ()

    return kCVReturnSuccess
}
