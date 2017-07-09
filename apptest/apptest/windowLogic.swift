//
//  windowLogic.swift
//  apptest
//
//  Created by Michael Ong on 9/7/17.
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


    func        initialise          () {

        swapChain       = window.graphicsSurface.backingSurface as! CAMetalLayer

        let mtlDevice   = Application.instance.graphicsDevice.backingDevice as! MTLDevice

        commandQueue    = mtlDevice.makeCommandQueue()!

        let vertLoc: [ Float32 ] = [

             0.0,  0.5, 0, 1,
            -0.5, -0.5, 0, 1,
             0.5, -0.5, 0, 1,
        ]

        let vertCol: [ Float32 ] = [

            1, 0, 0, 1,
            0, 1, 0, 1,
            0, 0, 1, 1
        ]

        library                 = try? mtlDevice.makeDefaultLibrary(bundle: Bundle.main)

        let function_fragment   = library.makeFunction(name: "fragment_main")
        let function_vertex     = library.makeFunction(name: "vertex_main")

        let pipelineDescriptor              = MTLRenderPipelineDescriptor()

        pipelineDescriptor.fragmentFunction = function_fragment
        pipelineDescriptor.vertexFunction   = function_vertex

        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

        pipelineState           = try? mtlDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)

        resource_vertLoc        = mtlDevice.makeBuffer(bytes: vertLoc, length: vertLoc.count * MemoryLayout<Float32>.size, options: .cpuCacheModeWriteCombined)
        resource_vertCol        = mtlDevice.makeBuffer(bytes: vertCol, length: vertCol.count * MemoryLayout<Float32>.size, options: .cpuCacheModeWriteCombined)

        if let sadkotoura       = Application.instance.storageManager.open(from: .local)?.open("sadkotoura.jpg") as? StorageEntryFile {
        if let sadkotourastream = sadkotoura.dataStream() {

        if let image            = UIImage(data: sadkotourastream) {

            resource_texture = mtlDevice.makeTexture(descriptor: .texture2DDescriptor(pixelFormat:  .rgba8Unorm,
                                                                                      width:        Int(image.size.width),
                                                                                      height:       Int(image.size.height),
                                                                                      mipmapped:    false))

        } } }


        CADisplayLink(target: self, selector: #selector(refresh(_:))).add(to: RunLoop.main, forMode: .defaultRunLoopMode)
    }

    func        finalise            () {


    }

    func        run                 () {


    }


    func        stateChanged        (to state: Set<WindowState>) {


    }


    @objc
    func        refresh             (_ dl: CADisplayLink) {

        let commandBuffer   = commandQueue.makeCommandBuffer()!

        let drawable        = swapChain.nextDrawable()!

        let renderPassDesc  = MTLRenderPassDescriptor()

        renderPassDesc.colorAttachments[0].texture      = drawable.texture
        renderPassDesc.colorAttachments[0].loadAction   = .clear
        renderPassDesc.colorAttachments[0].storeAction  = .store
        renderPassDesc.colorAttachments[0].clearColor   = .init(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)

        guard let encoder               = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDesc) else { return }

        encoder.setRenderPipelineState  (pipelineState)

        encoder.setVertexBuffer         (resource_vertLoc, offset: 0, index: 0)
        encoder.setVertexBuffer         (resource_vertCol, offset: 0, index: 1)

        encoder.drawPrimitives          (type: .triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)

        encoder.endEncoding             ()

        commandBuffer.present           (drawable)
        commandBuffer.commit            ()
    }
}
