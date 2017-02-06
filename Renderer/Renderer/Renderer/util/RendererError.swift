//
//  RendererError.swift
//  Renderer
//
//  Created by Michael Ong on 26/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

enum RendererError: Error {

    case invalidBlockFilterAppend
    case invalidLayerFilterAppend

    case invalidBlockRemove
    case invalidBlockModifierRemove

    case nullBlockToLayerReference


    case invalidExecutionState(with: String)
}
