//
//  windowLogic2.swift
//  apptest
//
//  Created by Michael Ong on 9/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import Metal
import QuartzCore

import simd

import sushicore
import sushiwindow
import sushiapplication
import sushistorage

struct quadVertex {

    var         position            : Vector4
    var         texCoord            : Vector4
}

struct matrixInfo {

    var         proj                : Matrix4
    var         view                : Matrix4
}

class windowLogic2: WindowLogic {

    weak var    window              : Window!


    var         swapChain           : CAMetalLayer!


    var         commandQueue        : MTLCommandQueue!


    var         resource_vertex     : MTLBuffer!

    var         resource_matrix     : MTLBuffer!


    var         resource_texture    : MTLTexture!


    var         library             : MTLLibrary!


    var         pipelineState       : MTLRenderPipelineState!


    func        initialise          () {

        swapChain       = window.graphicsSurface.backingSurface as! CAMetalLayer

        let mtlDevice   = Application.instance.graphicsDevice.backingDevice as! MTLDevice

        commandQueue    = mtlDevice.makeCommandQueue()!

        let vertLoc             : [ quadVertex ] = [

            quadVertex(position: .init( 0,  0, 0, 1), texCoord: .init(0, 0, 0, 0)),
            quadVertex(position: .init(200,  0, 0, 1), texCoord: .init(1, 0, 0, 0)),
            quadVertex(position: .init(200, 200, 0, 1), texCoord: .init(1, 1, 0, 0)),

            quadVertex(position: .init(200, 200, 0, 1), texCoord: .init(1, 1, 0, 0)),
            quadVertex(position: .init( 0, 200, 0, 1), texCoord: .init(0, 1, 0, 0)),
            quadVertex(position: .init( 0,  0, 0, 1), texCoord: .init(0, 0, 0, 0)),
        ]

        var matrix              = matrixInfo(proj: .identity,
                                             view: .identity)

        library                 = try? mtlDevice.makeDefaultLibrary(bundle: Bundle.main)

        let pipelineVertexIn                                    = MTLVertexDescriptor()

            pipelineVertexIn.attributes[0].format               = .float4
            pipelineVertexIn.attributes[0].offset               = 0
            pipelineVertexIn.attributes[0].bufferIndex          = 0

            pipelineVertexIn.attributes[1].format               = .float4
            pipelineVertexIn.attributes[1].offset               = MemoryLayout<Vector4>.size
            pipelineVertexIn.attributes[1].bufferIndex          = 0

            pipelineVertexIn.layouts[0].stepFunction            = .perVertex
            pipelineVertexIn.layouts[0].stride                  = MemoryLayout<Vector4>.size * 2

        let pipelineDescriptor                                  = MTLRenderPipelineDescriptor()

            pipelineDescriptor.fragmentFunction                 = library.makeFunction(name: "tex_frag_main")
            pipelineDescriptor.vertexFunction                   = library.makeFunction(name: "tex_vert_main")

            pipelineDescriptor.vertexDescriptor                 = pipelineVertexIn

            pipelineDescriptor.colorAttachments[0].pixelFormat  = .bgra8Unorm

        pipelineState               = try? mtlDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)

        resource_vertex             = mtlDevice.makeBuffer(bytes:       vertLoc,
                                                           length:      vertLoc.count * MemoryLayout<quadVertex>.stride,
                                                           options:     .cpuCacheModeWriteCombined)

        resource_matrix             = mtlDevice.makeBuffer(bytes:       &matrix,
                                                           length:      MemoryLayout<matrixInfo>.stride,
                                                           options:     .cpuCacheModeWriteCombined)

        guard let sadkotoura        = Application.instance.storageManager.open(from: .local)?.open("sadkotoura.jpg") as? StorageEntryFile
            else { FastFail.instance.crash(with: .unexpectedPayload) }

        guard let sadkotourastream  = sadkotoura.dataStream()
            else { FastFail.instance.crash(with: .unexpectedPayload) }

        if let image            = UIImage(data: sadkotourastream) {

            let texDesc = MTLTextureDescriptor.texture2DDescriptor(pixelFormat:  .rgba8Unorm,
                                                                   width:        Int(image.size.width),
                                                                   height:       Int(image.size.height),
                                                                   mipmapped:    false)

            texDesc.resourceOptions = .cpuCacheModeWriteCombined
            texDesc.usage = .shaderRead

            resource_texture = mtlDevice.makeTexture(descriptor: texDesc)

            let rawData = UnsafeMutablePointer<Int8>.allocate(capacity: resource_texture.width * resource_texture.height * 4)

            let context = CGContext.init(data: rawData,
                                         width: resource_texture.width, height: resource_texture.height,
                                         bitsPerComponent: 8, bytesPerRow: resource_texture.width * 4,
                                         space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!

            context.draw(image.cgImage!, in: .init(origin: .zero, size: image.size))

            resource_texture.replace(region: MTLRegionMake2D(0, 0, resource_texture.width, resource_texture.height),
                                     mipmapLevel: 0,
                                     withBytes: rawData,
                                     bytesPerRow: resource_texture.width * 4)
        }

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

        var matrix          = matrixInfo(proj: .orthographic(edges: .init(l: 0, r: Float(drawable.texture.width ),
                                                                          t: 0, b: Float(drawable.texture.height)),
                                                             near: -1,
                                                             far: 1),
                                         view: .identity)

        resource_matrix.contents().copyBytes(from: &matrix, count: MemoryLayout<matrixInfo>.stride)

        let renderPassDesc  = MTLRenderPassDescriptor()

        renderPassDesc.colorAttachments[0].texture      = drawable.texture
        renderPassDesc.colorAttachments[0].loadAction   = .clear
        renderPassDesc.colorAttachments[0].storeAction  = .store
        renderPassDesc.colorAttachments[0].clearColor   = .init(red: 0.25, green: 0.25, blue: 0.75, alpha: 1)

        guard let encoder               = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDesc) else { return }

        encoder.setRenderPipelineState  (pipelineState)
        encoder.setCullMode             (.none)

        encoder.setVertexBuffer         (resource_vertex, offset: 0, index: 0)
        encoder.setVertexBuffer         (resource_matrix, offset: 0, index: 1)

        encoder.setFragmentTexture      (resource_texture, index: 0)

        encoder.drawPrimitives          (type: .triangle, vertexStart: 0, vertexCount: 6)

        encoder.endEncoding             ()

        commandBuffer.present           (drawable)
        commandBuffer.commit            ()
    }
}
