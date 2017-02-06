//
//  ResourceHandle.swift
//  RendererMetal
//
//  Created by Michael Ong on 26/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation



public class ResourceHandle: Hashable {

    public var          hashValue   : Int {

        return 0
    }

    public init                     (where location: String) {


    }

    public static func  ==          (lhs: ResourceHandle, rhs: ResourceHandle) -> Bool {

        return lhs.hashValue == rhs.hashValue
    }
}
