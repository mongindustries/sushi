//
//  FilterTransform.swift
//  RendererMetal
//
//  Created by Michael Ong on 26/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

import Renderer

extension       Block.DataName {

    public static let       transformMatrix = Block.DataName(rawValue: 0x1B00_0000)
}


public class    FilterTransform: Filter {

    public var              worldMatrix     : Matrix4 = .identity


    public override var     reliesOn        : [ Filter.Type ] { return [ ] }


    public override func    update          (layer: Layer, blocks: [ Block ]) {

    }

    public override func    camera          (changed newData: Camera) {

    }
}

extension Block {

    public mutating func    complyTransform (matrix: Matrix4) throws {

        try self.comply(to: FilterTransform.self, with: [ .transformMatrix : matrix ])
    }
}

extension BlockModifier {

    public func             setTransform    (matrix: Matrix4) {

        self.set(data: (.transformMatrix, matrix))
    }

    public func             setTransform    (matrix: Matrix4, to uuid: UUID) {

        self.set(data: (.transformMatrix, matrix), to: uuid)
    }
}
