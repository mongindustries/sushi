//
//  Matrix.swift
//  sushicore
//
//  Created by Michael Ong on 16/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

import Foundation

import simd

public typealias Matrix3 = simd_float3x3

public typealias Matrix4 = simd_float4x4

extension Matrix4 {

    public static func orthographic(edges: RectangleEdge, near nearPlane: Float, far farPlane: Float) -> Matrix4 {

        let col1: Vector4 = .init([ 2 / (edges.right - edges.left),
                                   0,
                                   0,
                                   0])
        let col2: Vector4 = .init([0,
                                    2 / (edges.top   - edges.bottom),
                                   0,
                                   0])
        let col3: Vector4 = .init([0,
                                   0,
                                   -2 / (farPlane - nearPlane),
                                   0])
        let col4: Vector4 = .init([-1 * (edges.right + edges.left) / (edges.right - edges.left),
                                   -1 * (edges.top + edges.bottom) / (edges.top - edges.bottom),
                                   -1 * (farPlane + nearPlane) / (farPlane - nearPlane),
                                   1])

        return Matrix4(col1, col2, col3, col4)
    }

    public static func translate(by offset: Vector3) -> Matrix4 {

        let x = offset.x
        let y = offset.y
        let z = offset.z

        return Matrix4([ .init(1, 0, 0, 0),
                         .init(0, 1, 0, 0),
                         .init(0, 0, 1, 0),
                         .init(x, y, z, 1), ])
    }

    public static func scale(by offset: Vector3) -> Matrix4 {

        let x = offset.x
        let y = offset.y
        let z = offset.z

        return Matrix4([ .init(x, 0, 0, 0),
                         .init(0, y, 0, 0),
                         .init(0, 0, z, 0),
                         .init(0, 0, 0, 1), ])
    }


    public static func rotateX(by angle: Float) -> Matrix4 {

        let cosx = cos(angle)
        let sinx = sin(angle)

        return Matrix4([ .init(1,    0,     0, 0),
                         .init(0, cosx, -sinx, 0),
                         .init(0, sinx,  cosx, 0),
                         .init(0,    0,     0, 1), ])
    }

    public static func rotateY(by angle: Float) -> Matrix4 {

        let cosx = cos(angle)
        let sinx = sin(angle)

        return Matrix4([ .init( cosx,   0, sinx, 0),
                         .init(    0,   1,    0, 0),
                         .init(-sinx,   0, cosx, 0),
                         .init(    0,   0,    0, 1), ])
    }

    public static func rotateZ(by angle: Float) -> Matrix4 {

        let cosx = cos(angle)
        let sinx = sin(angle)

        return Matrix4([ .init(cosx, -sinx, 0, 0),
                         .init(sinx,  cosx, 0, 0),
                         .init(0,        0, 1, 0),
                         .init(0,        0, 0, 1), ])
    }


    public static var identity: Matrix4 {

        return Matrix4([ .init(1, 0, 0, 0),
                         .init(0, 1, 0, 0),
                         .init(0, 0, 1, 0),
                         .init(0, 0, 0, 1), ])
    }
}
