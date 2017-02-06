//
//  ErrorTypes.swift
//  Core
//
//  Created by Michael Ong on 29/1/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

protocol SushiError: Error {

    var description: String { get }
}


public enum NodeError: SushiError {

    case addingSameNodeTwice

    case notConnectedToScene

    case componentNotFound(component: Component.Type)

    case cannotBeGrouped

    case unknown(description: String)

    var description: String {

        switch self {

        case .addingSameNodeTwice:
            return "Cannot add the same node instance twice!"

        case .notConnectedToScene:
            return "Operation requies this Node to be added on a Scene first."

        case let .componentNotFound(component):
            return "Add \(component) first to the scene via add(component:)."

        case .cannotBeGrouped:
            return "Node has already been grouped. Call ungroup(leader:followers:) first."

        case let .unknown(info):
            return info
        }
    }
}
