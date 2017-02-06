//
//  Scene.swift
//  Core
//
//  Created by Michael Ong on 29/1/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

open class Scene {

    private var                 lastNodeIndex   = UInt32()


    internal(set) public var    nodes           = Set<Node>()

    internal(set) public var    components      = Set<Component>()


    private var                 availableIDs    = Set<NodeID>()


    private let                 onWhatThread    : Thread


    public init                                 () {

        onWhatThread = Thread.current
    }


    public func                 add             (component: Component) throws {

        assert(Thread.current == onWhatThread, "Operation must run on what thread this scene was created.")

        if components.insert(component).inserted == false {

            throw NodeError.addingSameNodeTwice
        }

        component.initialise()
    }

    public func                 add             (node: Node) throws {

        assert(Thread.current == onWhatThread, "Operation must run on what thread this scene was created.")

        if nodes.insert(node).inserted == false {

            throw NodeError.addingSameNodeTwice
        }

        node.nodePriority = assignID()
    }


    public func                 group           (leader node: Node, followers list: [ Node ]) throws {

        if node.isGrouped {

            throw NodeError.cannotBeGrouped
        }

        var tempLeaderLevel  = NodeID(node.nodePriority.groupIndex + 1)

        if      list.filter({ $0.nodePriority *== tempLeaderLevel }).count > 0 {

            tempLeaderLevel += NodeID(group: 1, index: 0)
        }
        else if list.filter({ $0.nodePriority  *> tempLeaderLevel }).count > 0 {

            tempLeaderLevel += list.reduce(NodeID(), { max($0, $1.nodePriority) })
        }

        var     count       = tempLeaderLevel
        var     toIncrement = nodes.filter({ $0.nodePriority *== count })

        while   toIncrement.count > 0 {

            for item in toIncrement {

                item.nodePriority += NodeID.init(group: 1, index: 0)
            }

            count       += NodeID.init(group: 1, index: 0)
            toIncrement  = nodes.filter({ $0.nodePriority *== count })
        }
        
        node.nodePriority   = tempLeaderLevel
        node.isGrouped      = true
    }

    public func                 ungroup         (leader node: Node) {

        node.isGrouped      = false
        node.nodePriority   = assignID()
    }


    open func                   update          () {


    }


    public func                 step            () {

        for component in components.filter({ $0.needsUpdating }) {

            component.rollup    ()

            component.step      ()

            component.teardown  ()
        }

        update()
    }


    internal func               nodeRemoved     (_ node: Node) {

        assert(Thread.current == onWhatThread, "Operation must run on what thread this scene was created.")

        for componentType in node.conformedComponents {

            guard let index = components.index(where: { $0.hashValue == Int(componentType.Identifier) }) else {

                continue
            }

            let component   = components[index]

            component.dataToManage  .removeValue    (forKey: node)

            guard let nidx  = component.dataToIterate.index(of: node) else {

                continue
            }

            component.dataToIterate .remove         (at: nidx)
        }

        guard let node = nodes.remove(node) else {

            return
        }

        availableIDs.insert(node.nodePriority)
    }

    internal func               assignID        () -> NodeID {

        if let availableID = availableIDs.first {

            availableIDs.remove(availableID)

            return NodeID(group: 0, index: availableID.nodeIndex)
        }
        else {

            defer {

                lastNodeIndex += 1
            }

            return NodeID(group: 0, index: lastNodeIndex)
        }
    }
}
