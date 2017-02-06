//
//  Filter.swift
//  Renderer
//
//  Created by Michael Ong on 17/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

open class Filter {

    public var  dirty       : Bool              = false

    open var    reliesOn    : [ Filter.Type ]   { return [ ] }


    public required init    (from layer: Layer) {


    }


    open func   update      (layer: Layer, blocks: [ Block ]) {

    }

    open func   render      (layer: Layer) {

    }


    open func   camera      (changed newData: Camera) {

    }
}
