//
//  Camera.swift
//  Renderer
//
//  Created by Michael Ong on 17/12/16.
//  Copyright © 2016 Michael Ong. All rights reserved.
//

import Foundation

public class Camera {

    private(set) public var matrix_world        : Matrix4 = .identity

    private(set) public var matrix_projection   : Matrix4 = .identity


    public init             () {


    }
}
