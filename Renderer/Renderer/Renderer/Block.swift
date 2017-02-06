//
//  Block.swift
//  Renderer
//
//  Created by Michael Ong on 17/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

/**

 Blocks are immutable objects that Filters in a layer use to render stuff.
 When adding a block to a layer via the `add(_)` methods, the layer makes a copy of the block and assigns it a unique identifer.

 */
public struct Block: Hashable {

    /// The unique identifier for the block. The layer assigns this value when `add(_)` is called.
    internal(set) public var    id              : UUID!


    /// Filter data for the block. Can be modified **before** adding to the layer.
    public var                  data            : [ DataName : Any ]        = [ : ]

    /// Filters that this block will render onto.
    private(set) public var     filters         : [ Filter.Type ]           = [ ]


    /// Vertex data for the block. This is immutable.
    private(set) public var     vertices        : [ Vector3 ]               = [ ]

    /// Index data for the block. This is immutable.
    private(set) public var     indices         : [ UInt32 ]                = [ ]


    public var                  hashValue       : Int {

        return id.hashValue
    }

    public static func          ==              (lhs: Block, rhs: Block) -> Bool {

        return lhs.id == rhs.id
    }


    /**
     
     Initalises the block with the specified vertex and index data.
     
     - parameters:
        - vertices: Vertex data of the block.
        - indices: Index data of the block.
     
     - important:
        The contents of this block will be **copied** to a layer when added.

     */
    public init                                 (vertices: [ Vector3 ], indices: [ UInt32 ]) {

        self.id         = nil

        self.vertices   = vertices
        self.indices    = indices
    }


    /**
     
     Marks the block to comply on a filter.
     
     - parameters:
        - filter: The class-type of the filter to comply with.
        - data: The data the filter might require for normal operation.
     
     - throws:
        This method throws a `.invalidBlockFilterAppend` when a filter is complied to more than once.

     */
    public mutating func        comply          (to filter: Filter.Type, with data: [ DataName : Any ]) throws {

        if  filters.contains(where: { $0 == filter }) == false {

            filters.append(filter)

            for item in data {

                self.data[item.key] = item.value
            }
        }
        else {

            throw RendererError.invalidBlockFilterAppend
        }
    }
}


extension Block {

    public struct DataName: Hashable {

        private var         value       : Int

        public var          hashValue   : Int {

            return value
        }


        public init                     (rawValue: Int) {

            value = rawValue
        }


        public static func  ==          (lhs: DataName, rhs: DataName) -> Bool{

            return lhs.value == rhs.value
        }
    }
}
