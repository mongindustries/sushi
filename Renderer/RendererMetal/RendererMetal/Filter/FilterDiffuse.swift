//
//  FilterDiffuse.swift
//  RendererMetal
//
//  Created by Michael Ong on 26/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation
import Metal

import Renderer

extension       Block.DataName {

    public static let diffuseTexture            = Block.DataName(rawValue: 0x1A00_0000)

    public static let diffuseTextureCoordinates = Block.DataName(rawValue: 0x1A00_0001)
}

private struct  DiffuseData {

    public var              world           : Matrix4 = .identity

    public var              projection      : Matrix4 = .identity
}

private struct  DiffuseEntry {

    public var              position        = Vector3(0, 0, 0)

    public var              texCoord        = Vector2(0, 0)
}

private struct  DiffuseBatch {

    public var              vertStart       = 0

    public var              vertEnd         = 0


    public var              indexStart      = 0

    public var              indexEnd        = 0


    public var              textureIndex    = 0
}

public class    FilterDiffuse: Filter {

    public override var     reliesOn        : [ Filter.Type ] {

        return [ FilterTransform.self ]
    }


    private var             buffer_vertex   : MTLBuffer!

    private var             buffer_index    : MTLBuffer!


    private var             buffer_data     : MTLBuffer!


    private var             texture_output  : MTLTexture!

    private var             pipelineState   : MTLRenderPipelineState!


    private var             batches         = [ DiffuseBatch ]()


    public required init                    (from layer: Layer) {

        super.init(from: layer)

        let scene       = SceneMetal.instance

        buffer_vertex   = scene.graphicsDevice.makeBuffer(length: 1024 * MemoryLayout<DiffuseEntry>.stride, options: [ .cpuCacheModeWriteCombined ])
        buffer_index    = scene.graphicsDevice.makeBuffer(length: 4096 * MemoryLayout<UInt32>.stride,       options: [ .cpuCacheModeWriteCombined ])

        buffer_data     = scene.graphicsDevice.makeBuffer(length: MemoryLayout<DiffuseData>.stride,         options: [ .cpuCacheModeWriteCombined ])

        texture_output  = scene.graphicsDevice.makeTexture(descriptor: .texture2DDescriptor(pixelFormat: .rgba8Unorm, width: 200, height: 200, mipmapped: false))
    }


    public override func    update          (layer: Layer, blocks: [ Block ]) {

        let bufferSize  = blocks.reduce(0, { $0 + $1.vertices   .count }) * MemoryLayout<DiffuseEntry>.stride
        let indexSize   = blocks.reduce(0, { $0 + $1.indices    .count }) * MemoryLayout<UInt32>.stride

        let scene       = SceneMetal.instance

        // resize bufers if needed.

        if  bufferSize  > buffer_vertex .length {

            buffer_vertex   = scene.graphicsDevice.makeBuffer(length: bufferSize    * MemoryLayout<DiffuseEntry>.stride, options: [ .cpuCacheModeWriteCombined ])
        }

        if  indexSize   > buffer_index  .length {

            buffer_index    = scene.graphicsDevice.makeBuffer(length: indexSize     * MemoryLayout<UInt32>.stride,       options: [ .cpuCacheModeWriteCombined ])
        }

        // construct upload buffer

        var list_vert = [ DiffuseEntry ]()
        var list_idxs = [ UInt32 ]()

        for block in blocks {

            let transform   = block.data[.transformMatrix] as! Matrix4
            let texCoord    = block.data[.diffuseTextureCoordinates] as! [ Vector2 ]

            let vertices    = block.vertices    .map({ $0 * transform })
            let indices     = block.indices     .map({ $0 + UInt32(list_idxs.count) })

            let diffEntry   = vertices.enumerated().map({ offset, element -> DiffuseEntry in return .init(position: element, texCoord: texCoord[offset]) })

            list_vert.append(contentsOf: diffEntry  )
            list_idxs.append(contentsOf: indices    )
        }

        // upload to buffers

        buffer_index    .contents().copyBytes(from: &list_idxs, count: list_idxs.count * MemoryLayout<UInt32>.stride)
        buffer_vertex   .contents().copyBytes(from: &list_vert, count: list_vert.count * MemoryLayout<UInt32>.stride)

        // construct batches

        batches         .removeAll(keepingCapacity: true)

        var curVertStart    = 0
        var curVertEnd      = 0

        var curIdxStart     = 0
        var curIdxEnd       = 0

        var texToCheck      : ResourceHandle!

        for block in blocks {

            let curTexture  = block.data[.diffuseTexture] as! ResourceHandle

            if  curTexture != texToCheck {

                batches.append(.init(vertStart: curVertStart, vertEnd: curVertEnd, indexStart: curIdxStart, indexEnd: curIdxEnd, textureIndex: 0))

                curVertStart    = curVertEnd
                curIdxStart     = curIdxEnd

                texToCheck      = curTexture
            }

            curVertEnd  += MemoryLayout<DiffuseEntry>.stride * block.vertices.count
            curIdxEnd   += MemoryLayout<UInt32>.stride * block.indices.count
        }

        if  curVertEnd > curVertStart || curIdxEnd > curIdxStart {

            batches.append(.init(vertStart: curVertStart, vertEnd: curVertEnd, indexStart: curIdxStart, indexEnd: curIdxEnd, textureIndex: 0))
        }
    }

    public override func    render          (layer: Layer) {

        let commandBuffer       = SceneMetal.instance.commandQueue.makeCommandBuffer()
        let renderDescriptor    = MTLRenderPassDescriptor()

        renderDescriptor.colorAttachments[0].texture        = texture_output

        renderDescriptor.colorAttachments[0].loadAction     = .clear
        renderDescriptor.colorAttachments[0].storeAction    = .dontCare

        renderDescriptor.colorAttachments[0].clearColor     = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)

        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor)

        renderEncoder.setVertexBuffer(buffer_vertex,    offset: 0, at: 0)
        renderEncoder.setVertexBuffer(buffer_data,      offset: 0, at: 1)

        for batch in batches {

            // draw the batches!

            renderEncoder.setFragmentTexture    (nil, at: 0)

            renderEncoder.drawIndexedPrimitives (type: .triangle, indexCount: batch.indexEnd - batch.indexStart, indexType: .uint32, indexBuffer: buffer_index, indexBufferOffset: batch.indexStart)
        }

        renderEncoder.endEncoding()
    }


    public override func    camera          (changed newData: Camera) {

        var data = DiffuseData(world: newData.matrix_world, projection: newData.matrix_projection)

        buffer_data.contents().copyBytes(from: &data, count: MemoryLayout<DiffuseData>.stride)
    }
}

extension Block {

    public mutating func    complyDiffuse   (texture: ResourceHandle, coordinates: [ Vector2 ]) throws {

        try self.comply(to: FilterDiffuse.self, with: [ .diffuseTexture : texture, .diffuseTextureCoordinates : coordinates ])
    }
}
