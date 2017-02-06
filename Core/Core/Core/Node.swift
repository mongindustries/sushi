//
//  Node.swift
//  Core
//
//  Created by Michael Ong on 29/1/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

open class Node: Hashable, Comparable {

    public static func              ==                  (_ lhs: Node, _ rhs: Node) -> Bool {

        return lhs.nodePriority == rhs.nodePriority
    }

    public static func              <                   (_ lhs: Node, _ rhs: Node) -> Bool {

        return lhs.nodePriority < rhs.nodePriority
    }

    public static func              >                   (_ lhs: Node, _ rhs: Node) -> Bool {

        return lhs.nodePriority > rhs.nodePriority
    }

    public static func              <=                  (_ lhs: Node, _ rhs: Node) -> Bool {

        return lhs.nodePriority <= rhs.nodePriority
    }

    public static func              >=                  (_ lhs: Node, _ rhs: Node) -> Bool {

        return lhs.nodePriority >= rhs.nodePriority
    }


    internal(set) public weak var   ref_scene           : Scene!


    public var                      isGroupLeader       : Bool {

        return nodePriority.isGroupLeader
    }


    public var                      isGrouped           = false

    internal(set) public var        nodePriority        = NodeID(0x0000_0000_0000_0000)

    public var                      conformedComponents = [ Component.Type ]()



    public var                      hashValue           : Int {

        return Int(nodePriority)
    }


    public func                     removeFromScene     () {

        ref_scene.nodeRemoved(self)
    }


    public func                     conformTo           (component: Component.Type) throws -> ComponentData? {

        guard let pscene        = ref_scene else {

            throw NodeError.notConnectedToScene
        }

        guard let pcomponent    = pscene.components.filter({ $0.hashValue == Int(component.Identifier) }).first else {

            throw NodeError.componentNotFound(component: component)
        }

        pcomponent.dataToIterate.append(self)

        conformedComponents.append(component)

        if let data = pcomponent.vendData(from: self) {

            pcomponent.dataToManage[self] = data

            return data
        }

        return nil
    }
}
