//
//  BlockModifier.swift
//  Renderer
//
//  Created by Michael Ong on 26/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

/**
 
 A block modifier is made as a side effect of a block being immutable.
 A block modifier "overrides" the data the a modifier has.
 This is helpful when a block's data needs to be constantly modified (eg Transform information).

 */
public class BlockModifier {

    private let     blockOverrideList   : [ UUID ]

    internal var    refLayer            : Layer!


    public init                         (modifies theseBlockUUIDs: [ UUID ]) {

        blockOverrideList   = theseBlockUUIDs
        refLayer            = nil
    }


    public func     set                 (data: (Block.DataName, Any)) {

        guard let _ = refLayer else { return }

        blockOverrideList.forEach { self.set(data: data, to: $0) }
    }

    public func     set                 (data: (Block.DataName, Any), to uuid: UUID) {

        guard let   layer       = refLayer else { return }
        guard let   index       = layer.blocks.index(where: { $0.id == uuid }) else { return }

        var         block       = layer.blocks[index]
        var         blockData   = block.data

        blockData[data.0]       = data.1
        block.data              = blockData

        layer.blocks[index]     = block

        // and inform filters this block is changed.

        layer.block(updated:    block)
    }
}
