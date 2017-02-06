//
//  NodeID.swift
//  Core
//
//  Created by Michael Ong on 29/1/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public typealias NodeID = UInt64

infix operator *<

infix operator *>

infix operator *==


infix operator .<

infix operator .>

infix operator .==

public extension NodeID {

    var nodeIndex           : UInt32 {

        return UInt32(0x0000_0000_FFFF_FFFF & self)
    }

    var groupIndex          : UInt8 {

        return UInt8((0xFFFF_0000_0000_0000 & self) >> 24)
    }


    var isGroupLeader       : Bool {

        return groupIndex > 0
    }


    init                    (group: UInt8, index: UInt32) {

        let fgroup  = UInt64(group) << 24
        let findex  = UInt64(index) & 0x0000_0000_FFFF_FFFF

        self        = fgroup + findex
    }
}

public extension NodeID {

    public static func *<   (lhs: NodeID, rhs: NodeID) -> Bool {

        return lhs.groupIndex <  rhs.groupIndex
    }

    public static func *>   (lhs: NodeID, rhs: NodeID) -> Bool {

        return lhs.groupIndex >  rhs.groupIndex
    }

    public static func *==  (lhs: NodeID, rhs: NodeID) -> Bool {

        return lhs.groupIndex == rhs.groupIndex
    }



    public static func .<   (lhs: NodeID, rhs: NodeID) -> Bool {

        return lhs.nodeIndex < rhs.nodeIndex
    }

    public static func .>   (lhs: NodeID, rhs: NodeID) -> Bool {

        return lhs.nodeIndex > rhs.nodeIndex
    }

    public static func .==  (lhs: NodeID, rhs: NodeID) -> Bool {
        
        return lhs.nodeIndex < rhs.nodeIndex
    }
}
