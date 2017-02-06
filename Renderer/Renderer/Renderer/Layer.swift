//
//  Layer.swift
//  Renderer
//
//  Created by Michael Ong on 17/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

/**
 
 Layers can be compared to a painter's canvas in an artistic sense.
 This holds all the `Block`s and `Filter`s for rendering in addition to the `Resolver` and the `Camera` for final composition.

 */
open class Layer {

    internal(set) public var    blocks                  : [ Block ]             = [ ]

    internal var                blockIndex              : [ UUID : UInt32 ]     = [ : ]


    internal(set) public var    filters                 : [ Filter ]            = [ ]


    public var                  resolver                : Resolver!             = nil

    public var                  camera                  : Camera!               = nil


    public weak var             superlayer              : Layer?

    public var                  sublayers               = [ Layer ]()


    private(set) public var     needsUpdate             = false


    public init                                         () {


    }


    public func                 addSublayer             (_ layer: Layer) {

        sublayers.append(layer)
    }

    public func                 removeFromSuperlayer    () {

        guard let superlayer = superlayer else {

            return
        }

        let index = superlayer.sublayers.index(where: { $0 === self })!

        superlayer.sublayers.remove(at: index)
    }


    @discardableResult
    public func                 add                     (block: Block) -> UUID {

        var myBlock                 = block

        // WARNING: COW

            myBlock.id              = UUID()

        self.blockIndex[myBlock.id] = UInt32(self.blockIndex.count)

        blocks.append   (myBlock)
        blocks.sort     (by: { self.blockIndex[$0.id]! < self.blockIndex[$1.id]! })

        self.block      (updated: myBlock)

        return myBlock.id
    }

    @discardableResult
    public func                 add                     (block: Block, on index: UInt32) -> UUID {

        var myBlock                 = block

        // WARNING: COW

            myBlock.id              = UUID()

        self.blockIndex[myBlock.id] = index

        blocks.append   (block)
        blocks.sort     (by: { self.blockIndex[$0.id]! < self.blockIndex[$1.id]! })

        self.block      (updated: myBlock)

        return myBlock.id
    }

    public func                 remove                  (block uuid: UUID) throws {

        guard let index = blocks.index(where: { $0.id == uuid }) else {

            throw RendererError.invalidBlockRemove
        }

        let block = blocks      .remove         (at: index)
                    blockIndex  .removeValue    (forKey: uuid)

        self.block(updated: block)
    }


    public func                 register                (filter: Filter.Type) throws {

        if  filters.contains(where: { type(of: $0) == filter }) == true {

            throw RendererError.invalidLayerFilterAppend
        }

        let thefilter = filter.init(from: self)
            thefilter.camera(changed: camera)

        filters.append(thefilter)
    }

    public func                 get                     (filter: Filter.Type) -> Filter? {

        return filters.filter({ type(of: $0) == filter }).first
    }


    open func                   spawn                   () {


    }

    open func                   kill                    () {


    }


    open func                   step                    (with interval: Double) {

        for sublayer in sublayers {

            sublayer.step(with: interval)
        }

        if  needsUpdate {

            needsUpdate = false

            filters.filter({ $0.dirty }).forEach({ filter in

                // inform filter that its data needs to be updated

                let filterType      = type(of: filter)
                let blocksToUpdate  = blocks.filter({ $0.filters.contains(where: { $0 == filterType }) })

                filter.update(layer: self, blocks: blocksToUpdate)

                filter.dirty = false
            })
        }

        // render layers

        filters.forEach { $0.render(layer: self) }

        // compose those layers on the resolver
    }


    internal func               block                   (updated block: Block) {

        needsUpdate = true

        // inform filters here that block is updated.

        for filter in block.filters {

            let filterToInform          = filters.filter({ filter == type(of: $0) }).first!
                filterToInform.dirty    = true
        }
    }
}
