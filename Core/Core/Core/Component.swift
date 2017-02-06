//
//  Component.swift
//  Core
//
//  Created by Michael Ong on 29/1/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

public protocol ComponentData: class {

    var                         identifier      : NodeID { get set }

    var                         isEnabled       : Bool { get set }
}

open class      Component: Hashable {

    public static func          ==              (_ lhs: Component, _ rhs: Component) -> Bool {

        return lhs.hashValue == rhs.hashValue
    }


    open static var             Identifier      : UInt16 {

        return 0x0000
    }

    open static var             Dependencies    : [ Component.Type ] {

        return [ ]
    }


    public var                  hashValue       : Int {

        return Int(Component.Identifier)
    }

    public var                  needsUpdating   = true



    internal(set) public var    dataToManage    = [ Node : ComponentData ]()

    internal(set) public var    dataToIterate   = [ Node ]()


    func                        vendData        (from node: Node) -> ComponentData? {

        return nil
    }


    open func                   initialise      () {


    }


    open func                   rollup          () {

        // default implementation sorts nodes from biggest to smallest

        dataToIterate.sort(by: >)
    }

    open func                   teardown        () {


    }


    open func                   beforeStep      () {


    }

    open func                   step            () {


    }
}
