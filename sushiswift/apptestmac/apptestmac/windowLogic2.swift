//
//  windowLogic2.swift
//  apptestmac
//
//  Created by Michael Ong on 11/8/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation
import AppKit

import Metal
import QuartzCore

import simd

import sushicore
import sushiwindow
import sushiapplication
import sushistorage
import sushiinput

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


    var         cvDisplayLink       : CVDisplayLink?


    var         rotation            : Float = 0


    var         inputTimer          : Timer!


    func        initialise          () {

        window.inputDispatcher.listen(from: InputSourcePointer<macOSInputSourceDriver>()) { (event) in

            guard let pointerEvent = event as? InputDispatcherPointerEvent else { return }

            print("Event at: \(String(describing: pointerEvent.points.first))")
        }

        inputTimer      = Timer.scheduledTimer(withTimeInterval: 0.03333, repeats: true, block: { [unowned self] (timer) in

            self.window.inputDispatcher.flush()
        })

        swapChain       = window.graphicsSurface.backingSurface as! CAMetalLayer

        let mtlDevice   = Application.instance.graphicsDevice.backingDevice as! MTLDevice

        commandQueue    = mtlDevice.makeCommandQueue()!

        let vertLoc             : [ quadVertex ] = [

            quadVertex(position: .init( 0,  0, 0, 1), texCoord: .init(0, 0, 0, 0)),
            quadVertex(position: .init(1920,  0, 0, 1), texCoord: .init(1, 0, 0, 0)),
            quadVertex(position: .init(1920, 1080, 0, 1), texCoord: .init(1, 1, 0, 0)),

            quadVertex(position: .init(1920, 1080, 0, 1), texCoord: .init(1, 1, 0, 0)),
            quadVertex(position: .init( 0, 1080, 0, 1), texCoord: .init(0, 1, 0, 0)),
            quadVertex(position: .init( 0,  0, 0, 1), texCoord: .init(0, 0, 0, 0)),
            ]

        var matrix              = Matrix4.identity

        library                 = try? mtlDevice.makeDefaultLibrary(bundle: Bundle.main)

        let pipelineVertexIn                                = MTLVertexDescriptor()

        pipelineVertexIn.attributes[0].format               = .float4
        pipelineVertexIn.attributes[0].offset               = 0
        pipelineVertexIn.attributes[0].bufferIndex          = 0

        pipelineVertexIn.attributes[1].format               = .float4
        pipelineVertexIn.attributes[1].offset               = MemoryLayout<Vector4>.size
        pipelineVertexIn.attributes[1].bufferIndex          = 0

        pipelineVertexIn.layouts[0].stepFunction            = .perVertex
        pipelineVertexIn.layouts[0].stride                  = MemoryLayout<Vector4>.size * 2

        let pipelineDescriptor                              = MTLRenderPipelineDescriptor()

        pipelineDescriptor.fragmentFunction                 = library.makeFunction(name: "tex_frag_main")
        pipelineDescriptor.vertexFunction                   = library.makeFunction(name: "tex_vert_main")

        pipelineDescriptor.vertexDescriptor                 = pipelineVertexIn

        pipelineDescriptor.colorAttachments[0].pixelFormat  = .bgra8Unorm

        pipelineState               = try? mtlDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)

        resource_vertex             = mtlDevice.makeBuffer(bytes:       vertLoc,
                                                           length:      vertLoc.count * MemoryLayout<quadVertex>.stride,
                                                           options:     .cpuCacheModeWriteCombined)

        resource_matrix             = mtlDevice.makeBuffer(bytes:       &matrix,
                                                           length:      MemoryLayout<Matrix4>.stride,
                                                           options:     .cpuCacheModeWriteCombined)

        guard let sadkotoura        = Application.instance.storageManager.open(from: .local)?.open("sadkotoura.jpg") as? StorageEntryFile
            else { FastFail.instance.crash(with: .unexpectedPayload) }

        guard let sadkotourastream  = sadkotoura.dataStream()
            else { FastFail.instance.crash(with: .unexpectedPayload) }

        if let image            = NSImage(data: sadkotourastream) {

            let texDesc = MTLTextureDescriptor.texture2DDescriptor(pixelFormat:  .rgba8Unorm,
                                                                   width:        Int(image.size.width),
                                                                   height:       Int(image.size.height),
                                                                   mipmapped:    false)

            texDesc.resourceOptions = .storageModeManaged
            texDesc.usage           = .shaderRead

            resource_texture = mtlDevice.makeTexture(descriptor: texDesc)

            let rawData = UnsafeMutablePointer<Int8>.allocate(capacity: resource_texture.width * resource_texture.height * 4)

            let context = CGContext.init(data: rawData,
                                         width: resource_texture.width, height: resource_texture.height,
                                         bitsPerComponent: 8, bytesPerRow: resource_texture.width * 4,
                                         space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!

            var prect = NSRect(origin: .zero, size: image.size)
            let cgImage = image.cgImage(forProposedRect: &prect, context: nil, hints: nil)

            context.draw(cgImage!, in: .init(origin: .zero, size: image.size))

            resource_texture.replace(region: MTLRegionMake2D(0, 0, resource_texture.width, resource_texture.height),
                                     mipmapLevel: 0,
                                     withBytes: rawData,
                                     bytesPerRow: resource_texture.width * 4)
        }

        CVDisplayLinkCreateWithActiveCGDisplays (&cvDisplayLink)
        CVDisplayLinkSetOutputCallback          ( cvDisplayLink!, refresh2, Unmanaged<windowLogic2>.passUnretained(self).toOpaque())

        CVDisplayLinkStart                      ( cvDisplayLink!)
    }

    func        finalise            () {


    }

    func        run                 () {


    }


    func        stateChanged        (to state: Set<WindowState>) {


    }
}

fileprivate
func        refresh2             (_ link: CVDisplayLink,
                                  _ timeStamp: UnsafePointer<CVTimeStamp>,
                                  _ ouputTime: UnsafePointer<CVTimeStamp>,
                                  _ flagsIn: CVOptionFlags,
                                  _ flagsOut: UnsafeMutablePointer<CVOptionFlags>,
                                  _ context: UnsafeMutableRawPointer?) -> CVReturn {

    let logic           = Unmanaged<windowLogic2>.fromOpaque(context!).takeUnretainedValue()

    let commandBuffer   = logic.commandQueue.makeCommandBuffer()!

    let drawable        = logic.swapChain.nextDrawable()!

    let matrix          = matrixInfo(proj: .orthographic(edges: .init(l: 0, r: Float(drawable.texture.width ),
                                                                      t: 0, b: Float(drawable.texture.height)),
                                                         near: -1,
                                                         far: 1),
                                     view: .translate(by: .init(100, 100, 0)) * .rotateZ(by: -logic.rotation))

 // logic.rotation += 0.01

    var vpmatrix        = matrix.proj * matrix.view

    logic.resource_matrix

        .contents   ()
        .copyBytes  (from: &vpmatrix, count: MemoryLayout<Matrix4>.stride)

    let renderPassDesc  = MTLRenderPassDescriptor()

    renderPassDesc.colorAttachments[0].texture      = drawable.texture
    renderPassDesc.colorAttachments[0].loadAction   = .clear
    renderPassDesc.colorAttachments[0].storeAction  = .store
    renderPassDesc.colorAttachments[0].clearColor   = .init(red: 0.5, green: 0.5, blue: 0.75, alpha: 1)

    guard let encoder               = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDesc) else { return kCVReturnError }

    encoder.setRenderPipelineState  (logic.pipelineState)
    encoder.setCullMode             (.none)

    encoder.setVertexBuffer         (logic.resource_vertex, offset: 0, index: 0)
    encoder.setVertexBuffer         (logic.resource_matrix, offset: 0, index: 1)

    encoder.setFragmentTexture      (logic.resource_texture, index: 0)

    encoder.drawPrimitives          (type: .triangle, vertexStart: 0, vertexCount: 6)

    encoder.endEncoding             ()

    commandBuffer.present           (drawable)
    commandBuffer.commit            ()

    return kCVReturnSuccess
}
